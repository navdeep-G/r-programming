##############################
#
#   Vectors in R
#
##############################

# you can build a vector with the c() function

v1 = c(3,-2,4)
v2 = c(5,1,6)

print(v1)
print(v2)

#  You can add vectors
v3 = v1 + v2

print(v3)

#  You can form linear combinations of vectors
v4 = 2*v1 - 3*v2

print(v4)

# To refer to a single element of a vector use []
a = v4[2]
print(a)

################################
#
#   Matrices in R
#
################################

#  You can form a matrix from vectors

#  Use rbind() to have the vectors placed as rows
#  into the matrix

A = rbind(v1,v2) # rbind(0 binds vectors as row vectors
print(A)

# To refer to a single element of a matrix
#    example
print(A[2,3])

# To refer to a single row of a matrix
#    example
b = A[2,]  # pick second row 
print(b)

# To refer to a single column of a matrix
#   example
b = A[,1] # pick the first column
print(b)

# To refer to a subset of a matrix
b = A[1:2,2:3] # pick first two rows and second and third columns
print(b) 

#  Use cbind() to have the vectors placed as columns
#  into the matrix

A = cbind(v1,v2) # rbind(0 binds vectors as column vectors
print(A)

#  Use the matrix() function to create a matrix
u = c(1,2,3,4,5,6,7,8)
C = matrix(u,nrow = 4) # Use 4 rows 
print(C)             # Note that u is placed in column order
                     # as the default

D = matrix(u,nrow = 4, byrow = TRUE) # use byrow = TRUE to
                                     # overrise the default
print(D)

E = matrix(u, ncol = 2) # you can also specify the number of columns
print(E)

F = matrix(c(v1,v2), ncol = 2) # same as cbind(v1,v2)
print(F)

#######################################
#
#  Matrix operations
#
#######################################


A = matrix(c(1,2,3,4), nrow = 2)
B = matrix(c(-1,0,1,2), ncol = 2)

# A and B are 2x2 matrices
print(A)
print(B)

#  matrix addition
C = A + B
print(C)

#  element by element multiplication
#  Note this is not normal matrix multiplication

C = A*B
print(C)

#  You must use %*% for matrix multiplication
C = A%*%B
print(C)

v = c(5,6)

#  Matrix vector multiplication uses %*% too
Y = A %*% v
print(Y)

####  matrix transpose

A.t = t(A)
print(A)
print(A.t)

#####  To compute the dot product of two vectors

dotprod <- function(u,v)
{ # dotprod
  stopifnot(is.vector(u))
  stopifnot(is.vector(v))
  stopifnot(length(u) == length(v))
  return(sum(u*v))
} # dotprod

print(v1)
print(v2)
dotprod(v1,v2)

###### To compute the Euclidean Norm of a vector

vnorm <- function(v)
{ # vnorm
  stopifnot(is.vector(v))
  return(sqrt(sum(v*v)))
} # vnorm

vnorm(v1)














