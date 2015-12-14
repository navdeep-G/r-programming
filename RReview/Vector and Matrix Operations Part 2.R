#################################################
#
#     Vector and Matrix Operations Part 2
#
#################################################

################################################
#
#    Solving a linear system of equations
#
################################################

options( digits = 16)

A = matrix( c(1,4,7,-3,2,5,7,3,1), ncol = 3)
print(A)
b = c(5,2,-3)

x = solve(A,b)
print(x)

####   Ax shoud equal b. Let's see

print(A %*% x)
print(b)

# to calculate an inverse (which one should not do)
# use solve without a right-hand side.

A.inv = solve(A)

print(A%*%A.inv)


###############################################
#
#   Computing the eigendecomposition
#
###############################################

A.eigdecomp = eigen(A)
print(A.eigdecomp)

#### use the $ to access the components of A.eigdecomp

eigval = A.eigdecomp$values
print(eigval)

eigvec = A.eigdecomp$vectors
print(eigvec)

##############################################
#
#  Computing the SVD
#
##############################################

A = matrix( c(4,-2,3,5,9,2,-1,3,9,2,-3,1), ncol = 3)
print(A)

A.svd = svd(A)
print(A.svd)

####  Again, use the $ to access components of A.svd

print(A.svd$d)


##### Use nu and nv as arguments to select the number
##### the number of singular vectors for U and V

A.full.svd = svd(A, nu = 4)
print(A.full.svd)

####  You might want a full svd if you want a basis for the
####  nullspace

#### make A rank deficient

A[,3] = 4*A[,1] - A[,2]
print(svd(A))


### Note the third singular value is zero with some round-off error
### The singular values can tell you the numerical rank of a matrix







