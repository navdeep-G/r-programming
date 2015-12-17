#A function to determine if a point is inside a triange. 
#The function prototype is inside.triange <-function(t,p)
#t is a 3x2 matrix containing the points that form the triangle, and p is a vector of length 2. 
#If p is contained in the triangle (or on one of the sides of the triangle) then return TRUE. Otherwise return FALSE.

inside.triangle <-function(t,p)
{#Begin Function
  
  #Initial checks of input
  if ( !is.vector(p) )  { stop("parameter must be a vector") }
  if ( !is.numeric(p) ) { stop("parameter must be numeric") }
  if ( !is.matrix(t) )  { stop("parameter must be a vector") }
  if ( !is.numeric(t) ) { stop("parameter must be numeric") }
  if(length(p)<2){stop("vector is not long enough") } 
  if(length(p)>2){stop("vector is too long") } 
  if(dim(t)!=c(3,2)){stop("matrix is not the right dimensions") } 
  
  #Set up points for triangle based on matrix, t.
  x=c(t[1,1],t[1,2])
  y=c(t[2,1],t[2,2])
  z=c(t[3,1],t[3,2])
  
  #Move origin to one vertex
  yx = y-x
  zx = z-x
  px = p-x
  
  #Calculate scalar used for weights wx,wy, and wz. 
  d=yx[1]*zx[2]-zx[1]*yx[2]
  print(d)
  
  #Compute Barycentric weights
  wx = (px[1]*(yx[2]-zx[2])+px[2]*(zx[1]-yx[1])+(yx[1]*zx[2])-(zx[1]*yx[2]))/d
  wy = (px[1]*zx[2]-px[2]*zx[1])/d
  wz = (px[2]*yx[1]-px[1]*yx[2])/d
  
  print(wx); 
  print(wy); 
  print(wz);
  
  #If all weights are between 0 and 1, then p is in triangle. 
  if ((wx > 0) && (wx < 1) && (wy > 0) && (wy < 1) && (wz > 0) && (wz < 1))
  {
    return(TRUE)
  }
  
  else    
  {
    return(FALSE)
  }
}#End Function


