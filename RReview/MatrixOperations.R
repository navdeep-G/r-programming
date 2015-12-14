#########   Matrices
#         and operations on matrices

a = matrix(1:6, nrow = 2 )  # a is 2X3
b = matrix(0:5, nrow = 3 )  # b is 3X2

print(a)
print(b)

m.c = a %*% b    #  %*% is the matrix multiplication operator
print(m.c)

m.c = b %*% a    # now we get a 3X3 matrix
print(m.c)

m.c.trans = t(m.c)   # t() gives the transpose
print(m.c.trans)

# another transpose
print(t(a))

##   what happens if you multiply matrices with non-conforming
#    dimensions? Remember, R allows one to add vectors with
#    non-conforming dimensions using the recycling rule.

t(a) %*% b    # a 3X2 times a 3X2
#    That's a relief. No recycling rule here
#    Remove the "%" around the "*"
print( t(a)*b )

#    if a and b are vectors a*b results in the element-by-element
#    multiplication of vectors. The same thing happens if a and b
#    are matrices. However, for vectors of unequal length we have
#    the recycling rule for the "*" operator. We do not for matrices.


d = matrix(11:14, nrow = 2)
print(d)
d * b
#   Matrices must have the dimensions one expects from a standard
#   linear algebra viewpoint.

#   Other matrix functions
print(dim(m.c))   # get the dimensions of m.c
print(diag(m.c))  # get the diagonals

s = diag(c(1,4,6))     # create a diagonal matrix 
print(s)
print(diag(diag(m.c))) # to form a matrix from the diagonals
# instead of a vector
#  Create an identity matrix of size n
n = 4
I.n = diag(rep(1,n))
print(I.n)

#   We can calculate the determinant for square matrices
options(digits = 16)

d = matrix(c(11.01,12,13,14), nrow = 2)
print(d)
print(det(d))
#  Now 11.01*14 = 154 + 0.01*14 = 154.14
#  So 11.01*14 - 12*13 = -1.86 exactly

print(11.01*14 - 12*13)
#  Now I am really feeling uneasy. You can see
#  that the arithmetic is not exact.

##    is a singular matrix.  (11+1/7)*14 - 12*13 = 0
d = matrix(c(11+1/7,12,13,14), nrow = 2)
print(det(d))

# You do not want to rely on det() to test for a matrix
# being singular. 

# Mathematically, a matrix is either singular or it isn't.
# But some matrices will have very small determinants on
# the order of 10^-16 or so. We really cannot distinguish
# these matrices from the ones which are mathematically singular.

# We can use the SVD to determine the numerical rank of a matrix

# Nor do you want to use Cramer's rule to solve Ax = b
# linear systems

#  Let's solve a system
A = matrix(c(2,1,3,2), nrow = 2)
b = c(12,5)
x = solve(A,b)
print(A)
print(x)
print(A %*% x)
#  Indeed 2*9 +3*(-2) = 12
#  and    1*9 +2*(-2) = 5
#
# also, when you want to find the inverse of a matrix
# use solve(). 
A.inv = solve(A)
print(A.inv)
print(A %*% A.inv)


#  But note that for serious numerical linear algebra problems
#  no one calculates an inverse or a determinant.

#  Things you can do with matrices
#  You can build a permutation matrix, which can permute the rows
#  of another matrix, or permute a vector.

P = matrix(c( c(1,0,0), c(0,0,1), c(0,1,0) ), nrow = 3, byrow = 'T')
x = c(1,2,3)
print(P)        # permute 2nd and 3rd elements
print(P %*% x)

#  You can rotate vectors (or points)

#  Given a point (x,y) it has a polar representation
#  (r,theta). r = sqrt(x^2+y^2), and theta = Arctan(y/x)
#
#  We use the vector v = c(x,y) to represent the point.
#  x = r*cos(theta) and y = r*sin(theta)
#  Suppose we have a matrix R.
#      cos(phi)    -sin(phi)
#      sin(phi)     cos(phi)

#  What is R %*% v?

#         r*cos(theta)*cos(phi) - r*sin(theta)*sin(phi)
#         r*cos(theta)*sin(phi) + r*sin(theta)*cos(phi)
#
#  which equals

#         r*cos(theta + phi)
#         r*sin(theta + phi)

#  The point (x,y) has been rotated by the angle phi

#   Example   v = (1,1)
#    R rotates by pi/4 (45 degrees)
options(digits = 7)
v = c(1,1)/sqrt(2)   # r = 1
phi = pi/4
c.phi = cos(phi);   s.phi = sin(phi)
R = rbind( c(c.phi,-s.phi), c(s.phi,c.phi) )
R %*% v

v = c(rnorm(1), rnorm(1) )  # pick a random point
w = R %*% v

r = sqrt( v[1]^2 + v[2]^2 )  # for plot limits

dev.new()
plot(v[1],v[2], col = 'red', xlim = c(-(r+1),(r+1)), ylim =c(-(r+1),(r+1)) ,
     main = "Before is Red\n After is Blue")
points(w[1],w[2], col = 'blue')
abline ( h = 0, v = 0)
ang = seq(0,2*pi,length = 1000)
lines(r*cos(ang),r*sin(ang))

##   Translate and Rotate a Triangle

p1 = c(4,7)
p2 = c(2,3)
p3 = c(5,2)
p.x = c(p1[1],p2[1],p3[1])
p.y = c(p1[2],p2[2],p3[2])

x.lim = c(-max(p.x), max(p.x))
y.lim = c(-max(p.y),max(p.y))
dev.new()
plot( c(p.x,p1[1]),c(p.y,p1[2]), xlab = 'x', ylab = 'y',
      xlim = x.lim, ylim = y.lim, type = 'l')
text(p1[1],p1[2],'P1')
text(p3[1],p3[2],'P3')

abline( h = 0, v = 0)
p1.t = p1 - p2
p2.t = c(0,0)
p3.t = p3 - p2
p.t.x = c(p1.t[1],p2.t[1],p3.t[1])
p.t.y = c(p1.t[2],p2.t[2],p3.t[2])
lines( c(p.t.x, p.t.x[1]),c(p.t.y,p.t.y[1]), col = 'blue')
text(p1.t[1],p1.t[2],'P1.t')
text(p3.t[1],p3.t[2],'P3.t')





ang = -atan2(p3.t[2],p3.t[1])

R   = rbind( c( cos(ang), -sin(ang) ), c(sin(ang), cos(ang) ))
t.r.1   = R %*% p1.t
t.r.2   = p2.t
t.r.3   = R %*% p3.t
t.r.x = c(t.r.1[1],0,t.r.3[1])
t.r.y = c(t.r.1[2],0,t.r.3[2])
lines( c(t.r.x, t.r.x[1]),c(t.r.y,t.r.y[1]), col = 'red')
text(t.r.1[1],t.r.1[2],'P1.t.r')
text(t.r.3[1],t.r.3[2],'P3.t.r')

##   Suppose we did not know Heron's formula
#    The area of the original triangle is
0.5*t.r.3[1]*t.r.1[2]   # (1/2)*base*height


####   Next we will discuss eigenvalues and eigenvectors

#      Knowledge of the eigendecomposition of a matrix allows us to
#      to easily calculate the effect of a matrix.
#      For any vector x, we can find a linear combination of eigenvectors
#      that equal x. 
#      A^n*x can be calculated from its eigenvectors.

t = seq(0,2*pi, length=10000)
x = cos(t)
y = sin(t)

v = rbind(x,y)

A = matrix(c(3,1,1,4),nrow = 2)

w = A %*% v

dev.new()
plot(x,y, type = 'l', xlim = c(-5,5), ylim = c(-5,5))
lines(w[1,],w[2,], col = 'red')
abline( v = 0, h = 0)

d = eigen(A)
print(d)

eig.val.1 = d$values[1]
eig.vec.1 = d$vectors[,1]
eig.val.2 = d$values[2]
eig.vec.2 = d$vectors[,2]
lines( c(0,eig.vec.1[1]),c(0,eig.vec.1[2]) )
lines( c(0,eig.vec.2[1]),c(0,eig.vec.2[2]) )

#   A is symmetric. Therefore, eigenvectors are 
#   mutually orthogonal, and eigenvectors are real.

#  Note that the eigenvectors point to the largest and smallest
#  increase in the unit circle.

#  If A is singular....

A = matrix(c(2,1,4,2),nrow = 2)
w = A %*% v

dev.new()
plot(x,y, type = 'l', xlim = c(-5,5), ylim = c(-5,5))
lines(w[1,],w[2,], col = 'red')
abline( v = 0, h = 0)

d = eigen(A)
print(d)

#  A is not symmetric, so the eigenvectors are not orthogonal

eig.val.1 = d$values[1]
eig.vec.1 = d$vectors[,1]
eig.val.2 = d$values[2]
eig.vec.2 = d$vectors[,2]
lines( c(0,eig.vec.1[1]),c(0,eig.vec.1[2]) )
lines( c(0,eig.vec.2[1]),c(0,eig.vec.2[2]) )

#  note that Av is a one-dimensional space
#  This happens because all the vectors in v
#  are a linear combination of the two eigenvectors.
#  The component in the direction of the eigenvector
#  whose eigenvalue = 0 becomes zero. The other component
#  is is in the direction of the eigenvector associated with
#  the eigenvalue 4. Hence the result is always a vector in the
#  direction of the eigenvector with the non-zero eigenvalue.
#  The only exception is the vector whose only component is in
#  the direction of the eigenvector with eigenvalue 0.

#  Hence the space spanned by A is one dimensional. 

#  If the matrix is not symmetric we can have complex eigenvalues
#  and eigenvectors

ang = 0.3

R   = rbind( c( cos(ang), -sin(ang) ), c(sin(ang), cos(ang) ))
eigen(R)

abs(eigen(R)$values) # eigenvalues have modulus 1

# Note the eigenvalues/vectors are complex conjugates for
# rotation matrices

# a general asymmetrical matrix

A = rbind( c(3,2), c(7,1) )
eigen(A)

w = A %*% v
dev.new()
plot(x,y, type = 'l', xlim = c(-6,6), ylim = c(-6,6))
lines(w[1,],w[2,], col = 'red')
abline( v = 0, h = 0)

d = eigen(A)
print(d)

# eigenvectors are not orthogonal
sum( d$vectors[,1]*d$vectors[,2] )
eig.val.1 = d$values[1]
eig.vec.1 = d$vectors[,1]
eig.val.2 = d$values[2]
eig.vec.2 = d$vectors[,2]
lines( c(0,eig.vec.1[1]),c(0,eig.vec.1[2]) )
lines( c(0,eig.vec.2[1]),c(0,eig.vec.2[2]) )

###  For symmetric matrices we have
###  the Rayleigh Quotient
###  maximize t(x)*A*x/t(x)*x (note: we use '*' instead of '%*%' here

#    If x is a unit length vector, we can ignore the denominator
#    Recall v is a set of vectors on the unit circle

#   Covariance matrices will be symmetric
#   Another important concept is positive definite.
#   If t(x)*A*x > 0 if norm(x) > 0, then A is positive definite.
#   A is positive definite iff all eigenvalues of A are positive.

k   = ncol(v)
r.q = numeric(k)
A = rbind( c(3,1), c(1,5) )

for ( i in 1:k ) { r.q[i] = t(v[,i]) %*% A %*% v[,i] }

max(r.q)            # max magnification
v[,which.max(r.q)]  # for which vector did the max occur?

min(r.q)            # min magnification
v[,which.min(r.q)]  # for which vector did the min occur?
dev.new()
plot(r.q, type = 'l', main = "Rayleigh Quotient")

###   note that the Rayleigh Quotient is related to the
#     eigendecomposition of the matrix
d = eigen(A)
print(d)
abline(h = d$values[1])
abline(h = d$values[2] )
#  For symmetric matrices we can sweep through a sequence of unit length
#  vectors and get an idea of the eigendecomposition. (But for matrices
#  with many dimensions, it is hard to make the vector grid dense
#  enough to give a good estimate. But one can at least get a lower
#  bound for the maximum eigenvalue.

#   Gershgorin disks
#   This is another way to put a bound on eigenvalues
#   proof done in class

A = rbind(  c(3,13,-4,1,5),
            c(4,8,-2,0,-1),
            c(6,-3,-32,0,3),
            c(2,6,-5,-7,0),
            c( 0.51,-0.03,0,0.01,29)
)
r = numeric(5)
for ( i in 1:5)
{
  r[i] = sum(abs(A[i,])) - abs(A[i,i])
}
center = diag(A)


unit.c.x = cos(seq(0,2*pi,length=1000))
unit.c.y = sin(seq(0,2*pi,length=1000))

G.circ.x.1 = r[1]*unit.c.x + center[1]
G.circ.y.1 = r[1]*unit.c.y
G.circ.x.2 = r[2]*unit.c.x + center[2]
G.circ.y.2 = r[2]*unit.c.y
G.circ.x.3 = r[3]*unit.c.x + center[3]
G.circ.y.3 = r[3]*unit.c.y
G.circ.x.4 = r[4]*unit.c.x + center[4]
G.circ.y.4 = r[4]*unit.c.y
G.circ.x.5 = r[5]*unit.c.x + center[5]m
G.circ.y.5 = r[5]*unit.c.y

x.min = min(G.circ.x.1,G.circ.x.2,G.circ.x.3,
            G.circ.x.4,G.circ.x.5) - 2 
x.max = max(G.circ.x.1,G.circ.x.2,G.circ.x.3,
            G.circ.x.4,G.circ.x.5) + 2 
eig.A = eigen(A)

dev.new()
plot(G.circ.x.1,G.circ.y.1, xlim = c(x.min,x.max), ylim = c(x.min,x.max),
     type = 'l', main = "Gershgorin Disks")
lines(G.circ.x.2,G.circ.y.2)
lines(G.circ.x.3,G.circ.y.3)
lines(G.circ.x.4,G.circ.y.4)
lines(G.circ.x.5,G.circ.y.5)
points(as.complex(eig.A$values),pch = 2, col = 'red')
abline(v=0);abline(h=0)

#  Since eigenvalues for an nXn matrix are the roots of a polynomial
#  of degree n, we must use iterative methods when n > 4.
#  In serious numerical analysis, no one computes eigenvalues by
#  solving the characteristic polynomial.

#  In fact people solve polynomials by calculating the eigenvalues of the
#  companion matrix associated with the polynomial.

#  c0 + c1*x + c2*x^2 + c3*x^3

#   0    1    0    0
#   0    0    1    0
#   0    0    0    1
#  -c0 -c1  -c2  -c3

#  is the companion matrix









