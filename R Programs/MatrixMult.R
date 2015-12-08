#Matrix multiplication

matrix.mult <- function(a,b)
{
  #Check if input is numeric and a matrix
  if(!is.numeric(a)) {stop("Parameter must be a numeric")}
  if(!is.numeric(b)) {stop("Parameter must be a numeric")}
  if(!is.matrix(a)) {stop("Parameter must be a matrix")}
  if(!is.matrix(b)) {stop("Parameter must be a matrix")}
  
  #Check if input is suitable for matrix multiplication
  if(nrow(a)!=ncol(b)) {stop("Rows of first matrix should equal column of second matrix")}
  
  #Anymore erros checks?????
  
  #Get rows of a, columns of b, and allocate our product matrix,c
  m = nrow(a)
  r = ncol(b)
  c = matrix(rep(0,m*r), ncol = r)
  
  #Begin for loop for multiplication. Recall, matrix multiplication is row(a) * col(b) and we will loop through as such.
  for(i in 1:m) #Loops through rows of a
  {#i
    for(j in 1:r)#Loops through columns of b
    {#j
      c[i,j] = sum(a[i,] * b[,j])
    }#j
  }#i
  return(c)
}

#Test case:
a = matrix(1:6, nrow = 2 )  # a is 2X3
b = matrix(0:5, nrow = 3 )  # b is 3X2

matrix.mult(a,b)

#Check if it is right:
d = a%*%b
c==d
