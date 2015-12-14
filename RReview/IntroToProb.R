### Intro to Probability

### R uses r<dist>, d<dist>, p<dist>, and q<dist> functions for the
### most common probability distributions.
### Here, <dist> stands for the distribution. For example <dist> could be
### norm for the normal distribution, or <dist> could be exp for the exponential
### distribution. 

### rnorm() and rexp() will generate random variables from the normal and exponential
### distributions respectively. The first argument to a r<dist> function is the number 
### of random variable you want to generate. The other arguments will generally be the
### parameters associated with the distribution. You can look up the arguments and their
### meaning by doing a ?rexp command, for example. If the internet is not available to you,
### you can always do an experiment.

### which parameterization does rexp use? lambda or theta?
### let's experiment. If it uses lambda, mean(t) = 1/lambda and var(t) = 1/lambda^2
### If it uses theta, then mean(t) = theta and var(t) = theta^2
t = rexp(200000,10)
sprintf("length(t) = %d  mean(t) = %8.6f  var(t) = %8.6f",length(t),mean(t),var(t))
###  Evidently rexp uses lambda

### Simlarly for rnorm, or rgamma, you can experiment to find out if rnorm uses the
### standard deviation or the variance as a parameter
t = rnorm(20000,3,100)
sprintf("length(t) = %d  mean(t) = %8.6f  var(t) = %8.6f",length(t),mean(t),var(t))
### Evidently the second parameter is mu, and the third parameter is sigma (NOT sigma^2)
### rnorm defaults to the standard normal, so if that is what you want you need only specify
### the number of samples you desire
t = rnorm(200000)
sprintf("length(t) = %d  mean(t) = %8.6f  var(t) = %8.6f",length(t),mean(t),var(t))

####  the d and p prefix before <dist> give the pdf and CDF respectively for the <dist>
####  distribution. See this example
dev.new()()
x = seq(0,2,0.01)
plot(x,dexp(x,4),type = 'l', col = 'red')
lines(x,pexp(x,4),col = 'blue')
abline( v = 0, h = 0)
title("pdf (red) and CDF (blue) for Exp(lamda = 4)")

### Note the dexp and pexp functions have a vector of values where the pdf and cdf is to be
### evaluated.

# If we want we can evaluate at a singe point
y = dexp(1,4)
sprintf("pdf at x = 1 is %1.9e and 4*exp(-4) = %1.9e",y,4*exp(-4))

#############   Not everything is reliable
options( digits = 16)

1 - pnorm(8)
integrate(dnorm,8,Inf)
#  They agree only to the first digit!

#   Now let's check out how useful integrate is
0.5 + integrate(dnorm,0,8)

#   let's investigate
x = integrate(dnorm,0,8)
mode(x)
str(x)
names(x)
x$value
#   of course that must be true. progams would never lie to you
x$abs.value
#   well, ok, the absoulte error is pretty big

x = integrate(dnorm,0,8,rel.tol=1.0e-16)

#   OK. We asked for too much
#   But let's check what is returned in x
x$value
x$abs.error
x$message

######   So the message is "OK"? But it complains that round off error was
######   detected. And it does not print the value it obtained.

x = integrate(dnorm,0,8, rel.tol = 1.0e-15)
#   Let's try again
x = integrate(dnorm,0,8,rel.tol=1.0e-14)
0.5 - x$value

#   Now accuracy goes away
1 - pnorm(8.3)




#############   plots a histogram and pdf using lines() to add the pdf
t = rexp(100000,4)
dev.new()
hist(t, xlim = c(0,max(t)), prob = TRUE, main = "Histogram and pdf of Exp(4)" )
x = seq(0,max(t),0.01)
lines(x,dexp(x,4), col = 'red')

#############   plots the histogram and pdf using curve() to add the pdf
dev.new()
hist(t, xlim = c(0,max(t)), prob = TRUE, main = "Histogram and pdf of Exp(4)" )
# Need  to specify add = TRUE to have curve added to an existing plot.
# Default is to have a new plot
curve(4*exp(-4*x),0,max(t), col = 'red', add = TRUE)


graphics.off()  3 kill plots

#### Example of curve()
curve(sin(1/x),0.02,1)

#### It handles asymptotes very nicely
curve(x/(x-3),0,5); abline( v = 3) # add the vertical asymptote

#################################################################
#
#      More on the histogram
#
##################################################################

#### If we use default in hist(), we have prob = FALSE, and the histogram
#### gives absolute numbers in the bin
dev.new()
hist(t, xlim = c(0,max(t)), main = "Histogram of Exp(4)" )

# Use breaks to get a more (or fewer) bins than the default. You can
# also use a vector to control the bin size and placement. Bins need
# not be uniform in size.
v = c(seq(0,0.5,length=50),seq(0.6,2,by = 0.1),max(t))
dev.new()   
hist(t, xlim = c(0,max(t)), breaks = 50, main = "Histogram of Exp(4)" )

###   Now we use non-uniform bins
v = c(seq(0,0.5,length=50),seq(0.6,2,by = 0.1),max(t))

dev.new()
hist(t, xlim = c(0,max(t)), breaks = v, prob = FALSE, main = "Histogram of Exp(4)" )
#### Note the warning
#### The default is to have the areas in the plot correspond to the frequency of data
#### in the bin
x11()
hist(t, xlim = c(0,max(t)), breaks = v,  main = "Histogram of Exp(4)" )


####  Use plot = F to return the counts for the bins.
####  Any parameters that are used purely for plots will generate a warning
####  For example, using xlim or xlab will give a warning

bin.count = hist(t, breaks = 10, plot = FALSE )
####  It returns a lot of information
names(bin.count)
bin.count$breaks
bin.count$mids
bin.count$counts

###### Now lets talk about q<dist>. This is the inverse of p<dist>
###### These numbers should be familiar
print(qnorm(0.95))
print(qnorm(0.975))

#### The composition of a function and its inverse should get you back
#### to where you started.
print(qnorm(pnorm(0.2)))

#### Indeed, it does.


#############################
#   More probability
###############################

#  we have the choose function
n = 10; k = 4
choose(n,k)   # gives 10 choose 4

#  and the factorial function
factorial(10)/(factorial(10-4)*factorial(4))

# and of course you can use gamma with an integer argument to
# save typing factorial
gamma(9)
factorial(8)

### how many zeros are at the end of 28!


permn(4)

#####   generating combinations
x = 1:5
combn(x,2)
combn(x,3)

#   x does not have to be a sequence of the first n integers
x = c(1,5,8,9,12)
combn(x,2)

#   we can also use an integer
combn(5,2)

# notice the above is equivalent to combn(x,2) when x = 1:5

# generating permutations

permn(3)

install.packages('combinat')

library(combinat)

permn(3) # creates a list. uggh!

search()
#    we will look in combinat befor we look in utils
#    the search() function tells you the order of search.
#    notice that combn from package utils is masked.

combn(5,2)  # this combn function is from combinat

x = c(4,6,3,8)
combn(x,3)

#   looks like combn from combinat package works like the utils package version

utils::combn(x,3)  # put in the package followed by '::', followd by function name
# to get the masked function

ls(2)     # let's see what is in combinat package

fact(6)
# great! we don't need to type factorial
nCm(6,2) # gives same result as choose(6,2)

#####  how to find out what is in the utils package

temp = search()
utils.position = which( temp == 'package:utils')
print(utils.position)
ls(utils.position)

####  well, the name indicates it has utility functions

####   a note on combn. We can apply a function to each combination

combn(6,3)
combn(6,3,fun=median)
x = c(5,9,11,34,6,12,6)
combn(x,3)

#  a permutation test can easily be done using sum as the function
x1 = c(3.4,4.5,6.9)
x2 = c(4.8,6.5,10.2)
x  = c(x1,x2)
t.sum = combn(x,3,sum)
print(t.sum)
num = which(t.sum <= sum(x1))
print(num)
length(num)/choose(length(x),length(x1))

#######################################################
#
#      using the sample function
#
########################################################

x = 1:50
y = sample(x,20,replace = T) # pick 20 samples from an urn
# containing 1-50 with replacement
print(y)
length(unique(y))
y = sample(x,20,replace = F) # same except no replacement
print(y)
length(unique(y))

y = sample(x,length(x),replace = F) # how to get a permutation of x
print(y)
print(sum(y)-sum(x)) # should be 0 if y is a permutation of x

# now generate many permutations
n = 30
x = 1:8
y = matrix( rep(0,n*length(x)), nrow = n)
for ( i in 1:n ) { y[i,] = sample(x,length(x),replace = F) }

###   each row of y contains a permutation of x


###    simulate 10 throws of a die. 
sample(1:6,10,replace = TRUE)

###    do we get a reasonable result?
mean(sample(1:6,10000, replace = TRUE))

###   So far we have sampled from a vector with the probability being equally
###   likely we choose any element of x

###   We can weight the probailities

x = c(1,2)
y = numeric(20)
for ( i in 1:20)
{
  y[i] =sample(x,1,prob = c(5,1))
}

###  a loaded die
v = c(2,1,1,1,1,1)
mean(sample(1:6,10000,prob = v,replace = T))
sum( 1*2/7 + 2*1/7 + 3*1/7 + 4*1/7 + 5*1/7 + 6*1/7)

##### simulate drawing a poker hand

sample(0:51,5, replace = FALSE)

# or

sample(1:52,5, replace = TRUE)


# An urn contains 5 red and 2 blue balls
x = c(rep('R',5),rep('B',2))
print(x)

##### What is the probability the second ball drawn is blue
##### if we do not replace the balls?
n = 10000
num.b = 0
for ( j in 1:n)
{
  d.1 = sample(x,1)
  if (d.1 == 'R')
  {
    d.2 = sample(c(rep('R',4),'B','B'),1) # 4 red and 2 blue
  }
  else
  {
    d.2 = sample(c(rep('R',5),'B'),1) # 5 red and 1 blue
  }
  if ( d.2 == 'B' ) { num.b = num.b + 1}
}
sprintf("P(B_2) = %8.7f",num.b/n)

####  looks like 2/7

#  P(B_2 | B_1)*P(B_1) + P(B_2 | R_1)*P(R_1)
#  (1/6)*(2/7) + (2/6)*(5/7) = 2/7



##################################################################
#
#     problems with runif()
#
##################################################################

install.packages('SoDA')
library(SoDA)

options(digits = 16)

x = runif(100)
binaryRep(x)

#  how random does the bit pattern look?
#  32 bits are OK. The last 32 bits are not

#  rexp will use runif and then use - log(u) or -log(1-u) to generate
#  an exponential
# if u is unif(0,1) that is fine
# if u is uniform(epsilon,1-epsilon), and epsilon is big, that is bad.

# Biggest u:
powers = 2^-(1:32)
u.max = sum((rep(1,32))*powers)
binaryRep(u.max)
print(u.max)
min.exp = -log(u.max)
print(min.exp)
# smallest u
u.min = 2^-32
print(u.min)
max.exp = -log(u.min)
print(max.exp)
# next smallest u
u = 2^-31
print(-log(u))
u = u + 2^-32
print(-log(u))
u = u + 2^-32
print(-log(u)) 
u = u + 2^-32
print(-log(u))
u = u + 2^-32
print(-log(u))
u = u + 2^-32
print(-log(u))
u = u + 2^-32
print(-log(u))
u = u + 2^-32
print(-log(u))

#   This shows that when rexp() generates a number bigger than 20,
#   there are only 8 numbers to choose from. This is fairly coarse.


#   rexp() will generate numbers in the range -log(u.max) to -log(u.min)

1 - exp(-min.exp)   # probability cut off at start
exp(-max.exp)       # probaility cut off at right tail

####   furthermore we have only 2^32 values in that range.

####   What if we used 53 bits?


# Biggest u:
powers = 2^-(1:53)
u.max = sum((rep(1,53))*powers)
binaryRep(u.max)
min.exp = -log(u.max)
print(min.exp)
# Smallest u:
u.min = 2^-53
print(u.min)
max.exp = -log(u.min)
print(max.exp)


1 - exp(-min.exp)   # probability cut off at start
exp(-max.exp)       # probaility cut off at right tail

#####  this is much more acceptable

#####  also we have 2^21 times more representable numbers.
#####  the result of rexp is not so coarse as we get using the\
#####  default runif

u = 2^-32
-log(u)
u = u + 2^-53
-log(u)
u = u + 2^-53
-log(u)
u = u + 2^-53
-log(u)
u = u + 2^-53
-log(u)
u = u + 2^-53
-log(u)
u = u + 2^-53
-log(u)
u = u + 2^-53
-log(u)

##     notice the values generated using a uniform random number
##     generator that makes use of all 53 bits will generate
##     from a much denser set of numbers.

##     We can combine the 32 bits of one runif() call
##     and extract the 21 MSb's from another runif() call.
##     The 21 bits from the second runif call are shifted and added
##     to create a 53 bit random number in the range (0,1)
x.hi  = runif(100)
x.low = runif(100)
x.low = 2^21*x.low 
binaryRep(x.low[1:6])
temp  = floor(x.low)
binaryRep(temp[1:6])
x.all = x.hi + 2^-53*temp
binaryRep(x.hi[1:6])
binaryRep(x.all[1:6])

x.hi  = runif(1000000)
x.low = runif(1000000)
x.low = 2^21*x.low 
temp  = floor(x.low)
x.all = x.hi + 2^-53*temp

mean(x.all)
var(x.all)

###    to free up memory
gc()   # gc() is the garbage collection function

rm(x.all,x.hi,x.low,temp) # this merely removes your ability to
# reference (or access) x.all,x.hi,x.low,temp
gc()   # this frees up the memory

#####     runif() has other various problems.

x = runif(1000000)
length(unique(x))
x = runif(100000)
length(unique(x))
####   77164 is the length of x, when the probability of a duplicate
####   exceeds 0.5

x = runif(1000000)
x = sort(x)
d = x[2:1000000] - x[1:999999]
length(unique(d))

###  this function allows you to change the algorithm used by runif()
RNGkind(kind = 'Wich') # choose Wichmann-Hill

x = runif(10)
binaryRep(x) # uses all the bits
x = runif(1000000)
length(unique(x))
x = sort(x)
d = x[2:1000000] - x[1:999999]
length(unique(d))






