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