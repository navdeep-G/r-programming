#This function will take a vector x and return a vector of all the odd numbers from that 
#said vector x.

oddcount <- function(x)
{#Start function
  if ( !is.vector(x) )  { stop("parameter must be a vector") }
  if ( !is.numeric(x) ) { stop("parameter must be numeric") }
  
  #Increment starting position of vector k, which will contain all of the odd numbers.
  k<-0
  for(n in x)
  {#for
    if(n%%2==1)
    {#if
      #To get actual values
      k[n]<- n
    }#if
  }#for
  k <- k[!is.na(k)] #NOTE: <<- will make k global. Use if absolutely necessary. 
  return(k)
}#End function
