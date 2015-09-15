#Navdeep Gill
#Assignment 4

#Convolution function

conv <- function(x,y)
{ # function starts
  
  #Error Checking
  if ( !is.vector(x) )  { stop("parameter must be a vector") }
  if ( !is.numeric(x) ) { stop("parameter must be numeric") }
  if ( !is.vector(y) )  { stop("parameter must be a vector") }
  if ( !is.numeric(y) ) { stop("parameter must be numeric") }
  
  #Get relevant lengths of vectors x & y
  n = length(x)
  m = length(y)
  
  #Make a new sequence a where new.x is a vector of x flipped from n:1 and the rest are 0's
  new.x = c(x[n:1],rep(0,(m-1)))
  
  #Make a new sequence new.y where new.y is a vector of 0's and then y
  new.y = c( rep(0,(n-1)),y )
  
  #Get relevant lengths k (only need to get of a since length(new.x) = length(new.y))
  k = (length(new.x))
  
  #Allocate vector for convolution
  conv.vec = numeric(k)
  
  #Start loop to calculate convolution
  for (i in 1:k)
  { #i
    conv.vec[i]=sum(new.x*new.y)
    
    #Re allocate new.x for next iteration in loop. This is essentially shifting, getting the overlap, multiplying, and adding
    #across the overlap.
    new.x = c(0,new.x)
    new.x = new.x[1:k]
  }#i
  return(conv.vec)
} # function ends

############################################################################################################################

#1

#Let Y be the sum of 25 throws of a die. Use your conv() function to calculate the pdf of Y. Using 
#only the pdf of Y, calculate E[Y] and Var(Y). You can do this using the definition of expectation 
#and variance. Plot the pdf of Y. Calculate P( 79 <= Y <= 96) and also P( 70 <= Y <= 105). 

#Define two vectors for convolution function
rolling = c(0,rep(1/6,6))
dice = c(0, rep(1/6,6))

#Convolve 25 rolls of a die. So, if X1 = one roll of a die, then Y = X1+X2+...+X25
  for (i in 1:24)
  {
    rolling = conv(rolling, dice)
  }
  rolling

# Plot of roll
plot(0:150,rolling,type="l", ylab="Probability", xlab="Total value of 25 rolls: 0 to 150")

# Below is used to find expectation of the convolution
x = rolling
k = length(x)

expectation <- function(x)
{ 
  for (i in 1:k)
  {
    x[i] = (x[i]*(i-1))
  }
  return(x)
}
expected = expectation(x)
expected.value = sum(expected)
expected.value

#Below is used to find variance of convolution
v = rolling
k = length(v)
variation <- function(v)
{
  for (i in 1:k)
  {
    v[i] = (v[i]*(i-1)^2)
  }
  return(v)
}
variant = variation(v)
var.conv = sum(variant)
variance = var.conv - (expected.value)^2
variance

#Before we find probabilities, we need the standard deviation
standard.dev = sqrt(variance)
standard.dev

# P( 79 <= Y <= 96)

prob1 = pnorm(96, mean=expected.value, sd=standard.dev)

prob2 = pnorm(79, mean=expected.value, sd=standard.dev)
actualprob = prob1 - prob2
actualprob

#P( 70 <= Y <= 105)

prob3 = pnorm(105, mean=expected.value, sd=standard.dev)
prob4 = pnorm(70, mean=expected.value, sd=standard.dev)
actualprob2  = prob3 - prob4
actualprob2

#############################################################################################################################

#2

#X ~ binom(40, 0.8) and Y ~poisson(12). X and Y are independent. Z = X + Y. Use your conv() 
#function to calculate the pdf of Z. Using the pdf of Z you calculated, calculate E[Z] and Var(Z). 
#Plot the pdf of Z. Calculate P( Z <= 40 ). Since Y is Poisson, the support of Z is semi-infinite. 
#When convolving X and Y, it will suffice (actually more than suffice) to truncate the pdf of Y at 
#200. 

#Define binomial(40,.8) and poisson(12)
n = 40 
p = 0.8
lamda = 12
x = dbinom(0:n,n,p) # pdf of values over support
y = dpois(0:140,12)

#Get convolution for Z = x + y
Z = conv(x,y)

# Below is used to find expectation of the convolution
x = Z
k = length(x)
expectation <- function(x)
{
  for (i in 1:k)
  {
    x[i] = (x[i]*(i-1))
  }
  return(x)
}
expected = expectation(x)
expected.value = sum(expected)
expected.value

#Below is used to find variance of convolution
v = Z
k = length(v)
variation <- function(v)
{
  for (i in 1:k)
  {
    v[i] = (v[i]*(i-1)^2)
  }
  return(v)
}
variant = variation(v)
var.conv = sum(variant)
variance = var.conv - (expected.value)^2
variance

#Plot of pdf,Z
plot(0:180,Z,type="l", ylab="Probability", xlab="Total value of Z = X + Y")

#Before we find probabilities, we need the standard deviation
standard.dev = sqrt(variance)
standard.dev

#Find probabilit Z<=40
prob.z = pnorm(40, mean=expected.value, sd=standard.dev)
prob.z
#############################################################################################################################

#3 
#Go to the Coupon6.R script that is included in the Blackboard Course Materials. It starts with a 
#function that simulates the number of times sample is called on a vector of length 3 until all 
#permutations of (1,2,3) are generated. Change the code to find the number of times sample 
#must be called to generate all the permutations of (1,2,3,4). Making simple changes such as this 
#to existing code is a job skill.

############
#
#    coupon6 function
#
#    Specialized to 6 coupons
#
#    This code is not good for a general number of coupons
#    It gives an idea of one kind of strategy that may work
#    very well in other applications
#
#    Simulates the distribution of number of coupons bought
#    to acquire at least one of each coupon type.

#    Another interpretation is: how many permutations from sample()
#    do we compute before we have computed all 6 permuations?
#############

coupon6 <- function(n)   # n is number of simulations
{ # begin coupon 6
  
  t = 0   # number of coupons bought
  v = numeric(313)
  #   We represent the sample as a base 4 number
  #   Each permutation of (1,2,3,4) represents a coupon
  #  (1,2,3,4) maps to 64*1 + 16*2 + 4*3 +4 => v[112]
  #  (1,2,4,3) maps to 64*1 + 16*2 + 4*4 +3 => v[115]
  #  (1,4,2,3) maps to 64*1 + 16*4 + 4*2 +3 => v[139]
  #  (1,4,3,2) maps to 64*1 + 16*4 + 4*3 +2 => v[142]
  #  (1,3,4,2) maps to 64*1 + 16*3 + 4*4 +2 => v[130]
  #  (1,3,2,4) maps to 64*1 + 16*3 + 4*2 +4 => v[124]
  #  (2,3,1,4) maps to 64*2 + 16*3 + 4*1 +4 => v[184]
  #  (2,3,4,1) maps to 64*2 + 16*3 + 4*4 +1 => v[193]
  #  (2,4,3,1) maps to 64*2 + 16*4 + 4*3 +1 => v[205]
  #  (2,4,1,3) maps to 64*2 + 16*4 + 4*1 +3 => v[199]
  #  (2,1,4,3) maps to 64*2 + 16*1 + 4*4 +3 => v[163]
  #  (2,1,3,4) maps to 64*2 + 16*1 + 4*3 +4 => v[160]
  #  (3,1,2,4) maps to 64*3 + 16*1 + 4*2 +4 => v[220]
  #  (3,1,4,2) maps to 64*3 + 16*1 + 4*4 +2 => v[226]
  #  (3,4,1,2) maps to 64*3 + 16*4 + 4*1 +2 => v[262]
  #  (3,4,2,1) maps to 64*3 + 16*4 + 4*2 +1 => v[265]
  #  (3,2,4,1) maps to 64*3 + 16*2 + 4*4 +1 => v[241]
  #  (3,2,1,4) maps to 64*3 + 16*2 + 4*1 +4 => v[232]
  #  (4,1,2,3) maps to 64*4 + 16*1 + 4*2 +3 => v[283]
  #  (4,1,3,2) maps to 64*4 + 16*1 + 4*3 +2 => v[286]
  #  (4,3,1,2) maps to 64*4 + 16*3 + 4*1 +2 => v[310]
  #  (4,3,2,1) maps to 64*4 + 16*3 + 4*2 +1 => v[313]
  #  (4,2,3,1) maps to 64*4 + 16*2 + 4*3 +1 => v[301]
  #  (4,2,1,3) maps to 64*4 + 16*2 + 4*1 +3 => v[295]
  
  
  p = c(4^3,4^2,4,1) #Add 4^3 for base 4
  #Redefine vector s based on above
  s = c(112,115,124,130,139,142,160,163,184,193,199,205,220,226,232,241,262,265,283,286,295,301,310,313) 
  num.bought = numeric(n)
  for ( i in 1:n )
  { # for
    # each iteration of the for loop is one trial 
    t    = 0           # number of coupons bought
    v[s] = c(rep(0,6)) # so far no coupon bought
    while ( prod(v[s]) == 0 ) # true while one coupon not obtained yet
    { # while
      t = t + 1
      x = sample(c(1,2,3,4),4,replace = F)
      v[sum(p*x)] = 1
    } # while
    num.bought[i] = t       
  } # for
  return(num.bought)    
} # end coupon 6

n = 5000
b = coupon6(n)  # n trials
print(mean(b))
dev.new()
plot(table(b)/n, main = "Simulation PDF for\n obtaining 6 coupons") # simulation pdf

