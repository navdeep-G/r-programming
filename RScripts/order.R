#Given a positive integer n, create the sequence 1,2,3,...,n,n-1,n-2,....2,1.
order <- function(n)
{
  if ( length(n)>1)  { stop("parameter must be vector of length one") }
  if ( !is.numeric(n) ) { stop("parameter must be numeric") }
  if(n<0){
    print("Error. Need a positive number")
  }
  else{
    n = n
    m = n-(n-1)
    first = seq(m,n,by=1)
    second = seq(n,m,by=-1)
    second<-second[-1]
    y<<-c(first,second)
    return(y)
  }
}

#Test Case
order(5)

#Sum the sequence you created in order(). 
sum.order <- function(y)
{
  if ( !is.numeric(y) ) { stop("parameter must be numeric") }
  k = length(y)
  sum = 0
  for(i in 1:k)
  {
    sum = sum + y[i]
  }
  return(sum)
}

#Test Case
sum.order(y)

#The sum is the square of the number, n. So, for n=5 the sum is 25.
