#A function to find out if points are inside a circle. The function prototype is 
#inside.circle <- function( center, radius, p). Here center is a vector of length 2, which contain the 
#coordinates of the center of the circle. The radius argument is a number which gives the radius. 
#The p argument is a matrix of n rows and 2 columns. The p matrix contains the coordinates of n 
#separate points. The function returns the row numbers of p for all points of p that are inside the 
#circle. The function also generates a plot containing the circle, and all the points of p. Those 
#points of p inside the circle are printed in red, and those points of p outside the circle are 
#printed in blue.

inside.circle = function(center, radius, p)
{#Begin Function
  
  #Error Checks
  
  if ((length(center)) !=2) 
  {stop ("First argument must be a vector of length two.")}
  
  if ( radius<=0 )
  {stop ("Second argument is not a positive number. Radius must be positive.")}
  
  if ( (length(radius)) !=1 )
  {stop ("Second argument must contain only 1 element.") }
  
  #Create lengths for later use.
  p.1 = length(p[,1])
  x.coord = numeric(p.1)
  y.coord = numeric(p.1)
  
  #Below will calculate the distance using the distance formula and check if it is within the circle. 
  #It will iterate through p[i,1] and p[i,2] and check the distance across these points and evaluate via
  # the if() statement.If the if() is true, x.coord and y.coord will take on those points and they will 
  #represent the points in the circle. 
  
  for (i in 1:p.1)
  {#for
    #In an x-y Cartesian coordinate system, the circle with centre coordinates (a, b) and radius r is the set 
    #of all points (x, y) such that:
    if ((p[i,1] - center[1])^2 + (p[i,2] - center[2])^2 <= radius^2)
    {#if
      #Allocatio of points in circle.
      x.coord[i] = p[i,1]
      y.coord[i] = p[i,2]
    }#if
  }#for
  
  
  #Get valid values and cbind to get vector of points in circle.
  x.coord = x.coord[x.coord != 0]
  y.coord = y.coord[y.coord != 0]
  coordinates = cbind(x.coord,y.coord)
  
  #Get plot values and the parameters for the equation of a circle.
  theta = seq(0,2*pi,length = 2000)
  a = center[1]
  b = center[2]
  x = a + (radius*cos(theta))
  y = b + (radius*sin(theta))
  
  #Plot cirlce and add points 
  plot(x,y, type = 'l', xlim = c(0,max(p[,1])), ylim = c(0,max(p[,2])), main = "Plot of circle with given parameters", ylab = "Y", xlab = "X")
  points(p[,1], p[,2], col = "blue")
  
  #The points inside the cirlce are red.
  points(x.coord,y.coord, col = "red")
  
  return(coordinates)
  
}#End Function