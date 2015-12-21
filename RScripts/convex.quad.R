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

