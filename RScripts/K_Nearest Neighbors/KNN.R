#
# Function "detect.misclass" 
#
# Inputs:  class.v = a matrix read from a CSV file listing the classification of points
#          p       = a matrix read from a CSV file of "m" points with "n" measured attributes
#       
# 
# Returns: A list containing the following:
#          "err.found": "TRUE"  if error(s) in classification found
#                       "False" if no errors in classification found
#
#          "err.loc"  : Location of points(s) in "p" where errors in 
#                       classification found for example: $err.loc = [1,2,34]
#                       NULL   if no errors in classification found
#
#          "new.class": New classification of points found in error
#                       NULL   if no errors in classification found
#
#          FALSE if:
#                    1. Either "class.v" has less than four (4) elements or 
#                       "p" has less than four (4) rows:
#                       a. It doesn't make sense to classify an empty set or 
#                          one point
#                       b. Classifying only two (2) points, if they aren't the same 
#                          classification, the algorithm will just switch the 
#                          classifications.
#                       c. Classifying only three (3) points also doesn't make sense 
#                          because:
#                          i. "K" will be (3), which means we evaluate all points, 
#                             but it doesn't make sense to include the point being 
#                             evaluated as a "nearest neighbor" and the tally would 
#                             be biased.
#                          ii. The algorithm could be modified so that if there are 
#                              only three (3) elements, and set "K" to 2, but this 
#                              also doesn't make sense, because the tally could 
#                              result in a tie vote
#
#                    2. Number of classifications NOT EQUAL to the number of rows of 
#                       "p" 
#                    3. All elements of "class.v" are NOT numeric
#                    4. All elements of "p" are NOT numeric  
#                    


detect.misclass<-function(class.v,p) 
{
  if ((nrow(class.v) < 4 ))
    {
     cat("ERROR: class.v must have at least four (4) points, please verify\n")
     return(FALSE)
    }
  
  if ( (ncol(p) < 2) || (nrow(p) < 4) || mode(p) != "numeric")
    {
     cat("ERROR: p must be a numeric with at least two (2) columns and four (4) rows, please verify\n")
     return(FALSE)
    }
  
  if (nrow(class.v) != nrow(p))
    {
     cat("ERROR: length of elements in class.v must equal rows in p, please verify\n")
     return(FALSE)
    }
  
  if ( mode(class.v) !="numeric")
    {
     cat("ERROR: class.v must contain numeric classifications, please verify\n")
     return(FALSE)
    }
         
  
  elements  <- length(class.v)    # Number of points to be evaluated
  class.KNN <- numeric(elements)  # Stores class of points determined by KNN algorithm
                   
  #
  # Calculate the "optimum" number of nearest neighbors for the set being analyzed, 
  # This is "K" which is the square root of the number of elements in the problem, rounded off, 
  # If "K" is even, add 1, so that there is never a tie
  #
         
  K <-round(sqrt(elements))
                   
  if ( (K %% 2) == 0 )
     {
      K = K + 1
     }
  
  #
  # "distance.matrix" is a matrix that contains the distances from one point to ALL other points
  # This will be used to calculate KNN, remember, we must ignore elements where the distance 
  # between the point and itself is calculated, because that is just comparing the point to itself
  #
                   
  distance.matrix <- as.matrix(dist(p, upper=TRUE,diag=TRUE, method="euclidean"))
                   
  for (point in 1:elements)
      {
       
        # Gets the distance of the first point to be analyzed to all other points
        distance <-as.vector(distance.matrix[,point])  
        
        # Contains distance and class information for all points    
        find.KNN <-cbind(class.v,distance)             
           
        # Remove the distance between the point and itself
        find.KNN <- find.KNN[which(!find.KNN[,2]==0),] 
                        
        #
        # Determine the point's "K" nearest neighbors and put into "KNN.points". 
        #
        # 1. "Assume" that the first "K" elements of "find.KNN" are really the KNN of the point
        # 2. Find the local maximum "MAX" and it's location 
        # 3. If the local maximum is greater than the minimum point of all the others, 
        #    then replace the maximum with the new minimum and delete the new minimum from 
        #    "other.points", it's now a nearest neighbor.
        # 4. If the local maximum is smaller than all other points, then we have all the 
        #    nearest neighbors for that point, no need to continute.
        # 5. Repeat steps #1-#4 until the local maximun of "KNN.points" is less than 
        #    all other points (ALL KNN have been found)
         
        
        #
        # "Assume" first "K" elements of "find.KNN" are the K nearest neighbors
        #
        
        KNN.points        <- matrix(ncol=2, nrow=K) 
        KNN.points[1:K,]  <-find.KNN[1:K,]  
        
        #
        # All other points (from (K+1) to (elements-1)), 
        # special case for "elements" = 4 because "K"=3 and 
        # "KNN.points" now contains the points K nearest neighbors
        # Just make "other.points" infinity so that the search ends
        #
      {
        if (elements != 4)
          {
            other.points  <- matrix(ncol=2, nrow=(elements-K-1))  
            other.points[1:(elements-K-1),] <-find.KNN[(K+1):(elements-1),]  
          }
        else 
           {
             other.points <- matrix(c(Inf,Inf), ncol=2)   
           }
      }
        #
        # Using "repeat" because this search should execute atleast once
        #

        repeat 
              {
                # Local Maximum
                MAX     <-KNN.points[which(KNN.points[,2] == max(KNN.points[,2])),] 
                
                # Location of Local Maximum
                MAX.loc <-which(KNN.points[,2] == max(KNN.points[,2]))              
                { 
                 if ( (MAX[2] > other.points[which( other.points[,2] == min(other.points[,2])),2]))
                      {
                        # Replace Local Maximum
                        KNN.points[MAX.loc,] <- other.points[which( other.points[,2] == min(other.points[,2])),] 
                        
                        # Delete the minimum point from "other.points" its now K nearest neighbor
                        other.points  <- matrix(other.points[which(!other.points[,2] == min(other.points[,2])),],ncol=2)   
                        
                        #Cycled through all "other.points", no need to analyze; break loop
                        if (nrow(other.points) == 0) 
                          {
                           break
                          }
                       }
                 # "KNN.points" contains all K nearest points, all other points in 
                 # "other.points" are farther away; done, break from the loop
                 else 
                     { 
                       break
                     }
                 }
                         
              } # End of "repeat" loop
    
       #
       # "KNN.points" stores the KNN of the point currently being analyzed. 
       # Now determine which classification ranks the highest among all of the neighbors; 
       # this is the classification of the point based on the KNN algorithm
       # Put the classification determined by KNN into the "class.KNN" vector.  
       # This vector will be compared with "class.v" to determine if there was a mismatch
       #
                        
       class.KNN[point]<-as.integer(names(table(KNN.points[,1]))
                                   [table(KNN.points[,1])==max(table(KNN.points[,1]))])                        
      } #END of FOR LOOP "point"
                       
       #
       # Are there any errors? Compare the original "class.v" with the classifications determined
       # by the KNN proceedure, if there are no errors, all elements of "answer" should be "0", 
       # if there are errors in classification of points, the element of "answer" correesponding 
       # to the point will be non-zero
       #
         
       answer <- class.KNN - class.v  # Difference between KNN classifications and what was passed 
                                      # to function
                   
       err.found <- (any(answer !=0) ==TRUE)  # Are there differences?
       { 
        if (err.found == FALSE)  # NO ERROR(S) FOUND, set "err.loc" and "new.class" to NULL
           {
             err.loc   <-NULL     
             new.class <-NULL
            }
        else  # ERROR(S) FOUND, find location of errors and what the class based on KNN should be
           {
             err.loc   <-which(!answer==0)  
             new.class <-class.KNN[err.loc]
            }
        }
                      
        return(list(err.found=err.found,err.loc=err.loc,new.class=new.class))
  
        } #END FUNCTION "detect.misclass"     

#
# To make things easier, I have sample data for "class.v" and "p" in a CSV file,
# I'm assuming that the reader will download files into their own directory.
# The following will get the current directory and set the paths.  
# If the files "class.v" and "p" can not be found in the user's working directory,
# an error message requesting that the user download the two CSV files into the 
# working directory will be displayed
#

path <- getwd()

{
if ( !file.exists(sprintf("%s/class_v.csv", path)) || !file.exists(sprintf("%s/p.csv", path)) ) 
   {
    cat("ERROR: class_v.csv and/or p.csv are not in your working directory\n")
    return(FALSE)
   }
else
   {
    # Files are in Working Directory, run "detect.misclass" 
    class.v <- as.matrix(read.csv(sprintf("%s/class_v.csv", path)))
    p       <- as.matrix(read.csv(sprintf("%s/p.csv", path)))

    test.detect.misclass <- detect.misclass(class.v,p)
    cat("Errors Found:", test.detect.misclass$err.found,"\n") 
    cat("Points misclassified:", test.detect.misclass$err.loc,"\n") 
    cat("New Classifications", test.detect.misclass$new.class,"\n") 
   }
  
}

