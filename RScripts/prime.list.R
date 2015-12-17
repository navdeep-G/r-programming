#A function that returns a vector of all primes less than a specified integer n.
#This function has one argument, which is a positive integer greater than 1. 
#This function will check that the argument actually is a positive integer greater than 1. It will also check that n does not exceed an upper limit. 
#The upper limit is set to 10,000.

#Example:prime.list(10) returns the vector(2,3,5,7)

prime.list <- function(n)
{#Begin Function
  
  #Initial checks of input.
  if(!is.numeric(n)) {stop("Parameter must be a numeric")}
  if(n<0){stop("The input must be positive.") } 
  if(n<=1){stop("The input must be greater than one.") } 
  if(n>10000){stop("The input cannot be greater than 10,000") } 
  
  #We will first make a sequence of 2:n since 1 is not prime.
  prime <- 2:n
  
  #Counter
  iter <- 1
  
  while (prime[iter] <= sqrt(n))
  {#Start while
    prime <-  prime[prime %% prime[iter] != 0 | prime==prime[iter]]
    iter <- iter+1
  }#Finish while
  
  #Output vector titled "prime".
  prime<<-prime
}#End Function