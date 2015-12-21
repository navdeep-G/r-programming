#A function to find the k nearest neighbors of a given point. The function prototype is:
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
