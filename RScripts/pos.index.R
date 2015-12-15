#Given a numeric vector x, produce a vector named where.pos, which contains the indices of the positions where the value of x is positive.
#Example: given x = c(34, -5,0,12,-7,4) you should output a vector named where.pos which has the following entries: 1,4,6.
pos.index <- function(x)
{
  if ( !is.vector(x) )  { stop("parameter must be a vector") }
  if ( !is.numeric(x) ) { stop("parameter must be numeric") }
  
  n = length(x)
  where.pos = numeric(length(x))
  for(i in 1:n)
  {
    if(x[i]>0)
    {
      where.pos[i] = i
    }
  }
  where.pos = (where.pos[where.pos>0])
  print(where.pos)
}

#Test Case
x<-c(34,-5,0,12,-7,4)
pos.index(x)
