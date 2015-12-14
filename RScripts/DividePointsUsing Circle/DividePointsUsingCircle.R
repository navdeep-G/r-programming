###########################################################################################################
# # Write a function that that takes in a matrix of points, the center of a circle, and the radius
#   of a circle and returns a matrix of points located inside and/or on the circle and draws a plot of
#   the points outside the circle in blue, inside the circle in red, the circle, and appropriately
#   scaled axes
#
#
#   in.circle(pts,cntr,r)
#
#   Input:
#           pts: nX2 numeric matrix, 1st column represents x coordinates, 2nd column y coordinates   
#           cntr:x and y coordinates of the center of a circle
#           r   : radius of a circle
#
#   Returns: 
#           If "pts" contains points inside and/or on circle, function returns nX2 matrix of these points
#           If "pts" does not contain points inside and/or on circle, function returns "NULL"
#
#           ERROR STATES:
#           The function will return "FALSE" if the following conditions occur:
#
#           1. "pts", "r", or, "cntr" is empty or has incorrect number of elements
#           2. "pts", "r", or "cntr" is not numeric
#           3. "r" is a negative number or radius = 0
#       

in.circle <-function(pts,cntr,r)
         {
  
          #
          # ERROR CHECKS:
          #
            #
            # Item #1
            #
              if ((length(pts) == 0) || (length(cntr) !=2) || (length(r) !=1))
                 {
                  cat("Missing or incorrect number of elements in pts, cntr, or r, please check data\n")
                  return(FALSE)
                 }
            
              if ((class(pts) != "matrix") || (dim(pts)[2] != 2) || (dim(pts)[1] < 1))
                 {
                  cat("pts should be a nX2 numeric matrix, please check pts\n") 
                  return(FALSE)
                 }
            
            #  
            # Item #2 ERROR
            #
              if ((is.numeric(pts) != TRUE) || (is.numeric(r) != TRUE) || (is.numeric(cntr) != TRUE))
                 {
                  cat("pts, r, and cntr must be numeric, please check values\n")
                  return(FALSE)
                 }
            
            #
            # Item #3 ERROR
            #
              if ( r <=  0) 
                {
                 cat("r must be a positive number greater than zero (0), please check value\n")
                 return(FALSE)
                }
            
          #
          # "test.circle" is a function that determines if a point in the matrix
          # "pts" is inside or outside of a circle with radius "r" and center at "cntr"
          #
          # 1. Determine the squared length of line from the center to the point
          # 2. If the squared length is less than or equal to the radius squared, 
          #    the point is inside the circle. ("Inside" the circle is considered in or
          #    on the circle)
          # 3. If the point is inside the circle, set "points" = 1, if not, points = 0
          # 4. This function will be used to vectorize the process of determining if a
          #    point is inside or outside the circle using "apply()"
          #
          
            test.circle <-function(points,r,cntr) 
                        { 
                         length = (((points[1]-cntr[1])^2) + ((points[2]-cntr[2])^2))
      
                         if (length <= r^2) 
                           { 
                            points = 1 
                            }
                         else               
                           { 
                            points = 0 
                            }
                        } #end "test.circle"

          #  
          # Vectorize the process of determining if a point is inside or outside the circle
          # by using "apply()"
          # 1. Each element of "pts", row by row, is read by "apply()" and the values are
          #    passed to function "test.circle".
          #
          
            circle.results=apply(pts,1,test.circle,r,cntr)
          
          #  
          # If classified as "1" it is an inside point, put x,y coordinates into "inside.circle" matrix
          # If classified as "0" it is an outside point,put x,y coordinates into "outside.circle" matrix
          #
          # Before assigning, size both "inside.circle" and "outside.circle" appropriately.
          # The number of rows of "inside.circle" is equal to the number of elements 
          # where  "pts" == 1 divided by 2
          # The number of rows of "outside.circle" is equal to the number of elements 
          # where "pts" == 0 divided by 2
          #
          # It's assumed for this application that the number of columns is equal to 2 (x/y coordinates) 
          #
          
            inside.rows     <- length(pts[circle.results == 1,])/2
            outside.rows    <- length(pts[circle.results == 0,])/2
          
            inside.circle   <- matrix(pts[circle.results == 1,], nrow=inside.rows,  ncol=2)
            outside.circle  <- matrix(pts[circle.results == 0,], nrow=outside.rows, ncol=2)
            
          #
          # Create a vector that has "x" and "y" points of the circle
          # described by "r" and "cntr", “nseg” represents 360 degrees of circle
          #
          
            nseg=360
            circle.x <- cntr[1] + r*cos( seq(0,2*pi, length.out=nseg) )
            circle.y <- cntr[2] + r*sin( seq(0,2*pi, length.out=nseg) )

          #
          # Calculate limits of "X" and "Y" axis in plot:
          # Take the union of "pts" and points on circle to calculate limits
          #
          
            total.x = c(pts[,1],circle.x)
            total.y = c(pts[,2],circle.y)

            x.axis = c( min(total.x) - 1, max(total.x) + 1)
            y.axis = c( min(total.y) - 1, max(total.y) + 1)

          #
          # Make plot of axis, points in circle are red, points outside circle, blue
          # and draw circle with radius "r" and center "cntr"
          #
          
            plot(x.axis,y.axis,main="Divide Points Using Circle",type="n",xlab="X",ylab="Y", 
                 sub="Sarah Quadri")
            points(circle.x,circle.y, type = 'l')
            points(outside.circle, asp=1, col="purple",pch=8)
            points(inside.circle, asp=1, col="green",pch=8)
          
          #
          # Specifications state to return a matrix containing points in the circle,
          # If there are no points in the circle, return "NULL"
          #
          
            {
            if (length(inside.circle) == 0) 
               {
                return(NULL)
               }
            else
               {
                return(inside.circle)
               }
            }
         } #End function.circle"

#
# Generate test data for function "in.circle"
# "pts" are some random points generated by getting 14 random numbers
# from a uniform distribution between 0 and 10 and rounding them,
# this is done twice to get an "x" coordinate and a "y" coordinate
# for 14 points
#

 set.seed(40)
 x = runif(14,0,10)
 x = round(x,3)
 y = runif(14,0,10)
 y = round(y,3)
 pts = cbind(x,y)
 cntr = c(4,5)
 r = 3.5

# Run function "in.circle"
test.in.circle = in.circle(pts,cntr,r)