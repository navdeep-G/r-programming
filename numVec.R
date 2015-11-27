#Navdeep Gill
#This will take in a number and split it into its respective
#single digit numbers. For example, 12345 would become a vector
#of 1,2,3,4,5
num.vec.while <- function(x)
{
    #Increment vector digits, which is the final outcome.
    digits = numeric()
    
    #Counter
    dig.index = 1
    
    while(x>0)
    {#Begin while loop
      digits[dig.index]= x%%10
      x = x-digits[dig.index]
      x = x%/%10
      dig.index = dig.index+1
    }#End while loop
    
    #Output Vector
    digits = digits[length(digits):1]
    print(digits)
}

#Test
x <- 2473
num.vec.while(x)

#Alternative using a for loop
num.vec.for <- function(y)
{
  n = ceiling(log10(y))
  digits = numeric()

  for (i in 1:n)
  {
    digits[i] = y%%10
    y = y-digits[i]
    y = y%/%10
  }
  digits = digits[length(digits):1]
  print(digits)
}

#Test
y = 12345
num.vec.for(y)