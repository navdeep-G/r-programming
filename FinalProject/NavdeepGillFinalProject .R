#Navdeep Gill
#Final Project

#1
#n people have a $5 bill, and n people have a $10 bill. They line up single file one night to buy
#a ticket that costs $5. The agent has no change at the beginning of the night. No one ever changes
#place in line. If the agent does not have change for the next customer, the ticket boot shuts
#down. Each ordering of the customers is equally likely. 

#What is the probability that every customer who lined up at the beginning of the process will be 
#able to purchase a ticket? Remember, there are 2n customers, so the answer will depend on n.

#Simulate for n=5,n=10, and n=20
  
  #Intitialize sample, length of sample, iteration counter, and # of simulations.
  samp = rep(c(5,10), 5)
  l.samp = length(samp)
  iter = 0
  sim = 10000
  
  #For loop to go through # of simulations
  for (j in 1:sim)
  {#for
    
    #Sample from previoius samp, set iteration b=0 for counter in next for loop and get numeric of l.samp, which is the length
    #of the samp.
    a = sample(samp, l.samp, replace = FALSE)
    b = 0
    c = numeric(l.samp)
    
    #This for loop will go through each sample. It will look to see if the number of $10 is greater than the number of $5.
    #It will increment +1 for every $5 and -1 for every $10 bill. Once the incrementation is negative, that means there are
    #more $10 than $5 and the system will shut down.
    for (i in 1:l.samp)
    {#for
      if (a[i] == 5)
      {#if
        b = b+1
      }#if
      else
      {#else
        b = b-1
      }#else
      c[i] = b
    }#for
    
    #Sum to get total # of samples with all values >0, i.e., successes/everyone got in that was in line. 
    if(sum(c>=0)==l.samp)
    {#if
      iter = iter + 1
    }#if
    
  }#for
  
  #Get probability after previous simulation. 
  prob = iter/sim


#2
#Write a function to find the k nearest neighbors of a given point. The function prototype is:
#k.nn <- function(k,p1,p)
#Here k is a positive integer. Its length should be 1. p1 is a single point in the x-y plane and it should 
#be a numeric vector of length 2. p is an mx2 matrix containing m points in the x-y plane. Each row of m 
#contains the coordinates of a single point. The p1 argument should be a vector of length 2. Of course k 
#cannot exceed m. The output should be a vector of length k containing the row numbers of the k nearest points 
#in the matrix p to the point p1.

k.nn <- function(k,p1,p) 
{#Begin Funtion
  
  #Error Checks
  if ( !is.numeric(k) ) { stop("First parameter must be numeric") }
  if ( !is.numeric(p1) ) { stop("Second parameter must be numeric") }
  if ( !is.numeric(p) ) { stop("Third parameter must be numeric") }
  if(k<0) {stop("First parameter must be positive")}
  if ( length(p1)!=2)  { stop("Second parameter must be vector of length 2") }
  if(!is.matrix(p)) {stop("Third parameter must be a matrix")}
  if(ncol(p)!=2) {stop("Third paramter must be a matrix with 2 columns")}
  if(k>nrow(p)) {stop("First parameter cannot exceed the number of rows from the third paramter")} 
  
  #Get relevant vectors for upcoming loop.
  p.row = nrow(p)
  distance = numeric(p.row)
  k.n = numeric(p.row)
  
  #Loop through each point and get distance using Euclidean distances.
  for(i in 1:p.row)
  {#for
    distance[i] = sqrt((p[i,1] - p1[1])^2 + (p[i,2]-p1[2])^2)
  }#for
  
  #Cbind distance matrix with relevant indexes.
  dist.index = cbind(distance,c(1:p.row))
  #Order the indexes in increasing order.
  dist.index = dist.index[order(dist.index[,1],dist.index[,2], decreasing=FALSE),]
  #Get the top k distances since k can vary based on user input.
  dist.index = dist.index[1:k,]
  #Get the indexes of the top k distances.
  k.nn = dist.index[,2]
  #Sort the top k distances indexes and return. 
  k.nn = sort(k.nn)
  return(dist.index)
  
}#End Function

#Test
p1 = c(6,6)
k = 3
p = matrix(c(6.9,7.6,7.1,0.4,6.2,1.8,2.5,2.3,5.7,6.9,0.9,4.4,5.2,1.9,0.6,7.4,1.2,6.6,3.3,4.9),ncol=2,nrow=10)

###############################################################################################################
#Bonus Section

#1
#Modify k.nn so it takes in more than 2 dimensions. 

k.nn <- function(k,p1,p) 
{#Begin Function
  
  #Error Checks
  if ( !is.numeric(k) ) { stop("First parameter must be numeric") }
  if ( !is.numeric(p1) ) { stop("Second parameter must be numeric") }
  if ( !is.numeric(p) ) { stop("Third parameter must be numeric") }
  if(length(p1)!=ncol(p)) {stop("Second parameter length should match number of columns in third parameter")}
  if(k<0) {stop("First parameter must be positive")}
  if(!is.matrix(p)) {stop("Third parameter must be a matrix")}
  if(k>nrow(p)) {stop("First parameter cannot exceed the number of rows from the third parameter")} 
  
  #Get relevant vectors for upcoming loop.
  p.row = nrow(p)
  distance = numeric(p.row)
  k.n = numeric(p.row)
  
  #Loop through each ROW of p and get distance from p1 using Euclidean distances. 
  for(i in 1:p.row)
  {#for
    distance[i] = sqrt(sum(p[i,]-p1)^2)
  }#for

  #Cbind distance matrix with relevant indexes.
  dist.index = cbind(distance,c(1:p.row))
  #Order the indexes in increasing order.
  dist.index = dist.index[order(dist.index[,1],dist.index[,2], decreasing=FALSE),]
  #Get the top k distances since k can vary based on user input.
  dist.index = dist.index[1:k,]
  #Get the indexes of the top k distances.
  k.nn = dist.index[,2]
  #Sort the top k distances indexes and return. 
  k.nn = sort(k.nn)
  return(k.nn)
  
}#End Function
#Test
p1 = c(6,6)
k = 3
p = matrix(c(6.9,7.6,7.1,0.4,6.2,1.8,2.5,2.3,5.7,6.9,0.9,4.4,5.2,1.9,0.6,7.4,1.2,6.6,3.3,4.9),ncol=2,nrow=10)

#2
#Given a 4x2 matrix containing four points in the x-y plane, determine if the four points form a convex 
#quadrilateral. Return TRUE if they do form a convex quadrilateral and FALSE otherwise.# The function 
#prototype is: Is.convex.quad <- function(p). 
#p is a 4x2 numerical matrix. Each row of p is a point in the x-y plane.

Is.convex.quad <- function(p)
{#Begin Function
  #Error Checks
  if ( !is.numeric(p) ) { stop("Parameter must be numeric") }
  if(!is.matrix(p)) {stop("Parameter must be a matrix")}
  if(nrow(p)!=4) {stop("Parameter must have 4 rows")}
  if(ncol(p)!=2) {stop("Parameter must have 2 columns")}
  
  #Get points from 4X2 matrix by getting each row. 
  A = p[1,]
  B = p[2,]
  C = p[3,]
  D = p[4,]
  
  #Get side lengths based on points using the distance formula. 
  AB = sqrt((B[1]-A[1])^2 + (B[2]-A[2])^2)
  BC = sqrt((C[1]-B[1])^2 + (C[2]-B[2])^2)
  CD = sqrt((D[1]-C[1])^2 + (D[2]-C[2])^2)
  DA = sqrt((A[1]-D[1])^2 + (A[2]-D[2])^2)
  
  #Get diagonal lengths based on points using the distance formula.
  AC = sqrt((C[1]-A[1])^2 + (C[2]-A[2])^2)
  BD = sqrt((D[1]-B[1])^2 + (D[2]-B[2])^2)
  
  #Get midpoint of diagonals
  x = (AC+BD)/2
  
  #Check if convex using Euler's quadrilateral theorem (generalization of parrallelogram law). 
  #This states if the sum of the lengths squared is equal to the sum of the lengths of the 
  #diagonals squared plus 4 times the midpoint of the quadralateral, then the quadrilateral is
  #convex. Otherwise, it is not convex. 
  if (AB^2 + BC^2 + CD^2 +DA^2 == AC^2 + BD^2 + 4*(x^2))
  {#if
    return(TRUE)
  }#if
  else
  {#else
    return(FALSE)
  }#else
}#End function

#Test for true
p = matrix(c(0,1,0,1,0,0,1,1),ncol=2,nrow=4)
#Test for false
p = matrix(c(0.00,1.00,0.00,0.25,0.00,0.00,1.00,0.25),ncol=2,nrow=4)

