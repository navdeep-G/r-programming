#Given a numeric vector x, calculate the sample variance using a loop. 
my.variance <- function(x)
{
  if ( !is.vector(x) )  { stop("parameter must be a vector") }
  if ( !is.numeric(x) ) { stop("parameter must be numeric") }
  
  sum=0
  n = length(x)
  for(i in 1:n)
  {
    sum = sum + x[i]
    x.bar = sum/n
  }
  numerator = numeric(n)
  for ( i in 1:n)
  {
    numerator[i] = (x[i]-x.bar)^2
  }
  var = sum(numerator)/(n-1)
  print(var)
}

#Test Case
x<-c(1:20)
variance(x)
var(x)
