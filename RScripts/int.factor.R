#A function that returns the prime factorization of a positive integer in the range 2 to 1,000,000.
#The function prototype is int.factor(n)
#This will call the prime.list function within the int.factor function. 
#Will return the prime factors as the first row of a matrix and the powers as the second row in the matrix.

#Set working directory to where you put the repo R-Programming locally.
setwd("~/To/Location/Of/R-Programming")

#Source prime.list.R
source("prime.list.R")

int.factor <- function(n)
  {#Begin Function
    
    #Initial checks of input
    if(!is.numeric(n)) {stop("Parameter must be a numeric")}
    if(n<0){stop("The input must be positive.") } 
    if(n<=1){stop("The input must be greater than one.") } 
    if(n>1000000){stop("The input cannot be greater than 1,000,000") }  
    
    #Make an empty vector v, which will be filled up later.
    v=c()
    
    #Implement previous function,prime.list, into this function,int.factor
    y=prime.list(n)
    
    #Counter
    iter=1
    
    #This while loop will go through each prime and check the modulus,i.e, whether it is ==0, which indicates it is divisible
    #by our number of interest,n. Then, it will append that divisor into the vector x() until the loop is finished, i.e., we get
    #to the last value in our vector.
    while( n!= 1)
    {#Start while
      if( n%%y[iter]==0)
      {
        n=n/y[iter]; 
        v=append(v,y[iter])
      }
      
      else
      {
        iter=iter+1
      }
    }#Finish while
    
    #Now, we will get the prime factors and their respective powers.
    m=0
    prime=c(v[1])
    power=c(1)
    
    for(j in 2:length(v))
    {#Start for loop
      if (v[j]==v[j-1])
      {
        m=length(power)
        power[m]=power[m]+1
      }
      else 
      { 
        prime=append(prime,v[j])
        power=append(power,1)
      }
    }#Finish for loop
    
    #Use rbind to put factors and powers together into a matrix. 
    y=rbind(prime,power)
    print(y)
    
  }#End Function