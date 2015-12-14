###################
#
#   odds and ends
######################

## Another distinction between && and &
## or || or |

## We have seen that & and | work on vectors
## and produce a vector result. Another distinction is
## that && and || are short circuit operators.


## If you use && instead of &, the second condition
## is not evaluated if the first condition is false

x = -1
if ( (x > 0) && (log(x) > 1) ) { printf("if") } else { print("else") }

if ( (x > 0) & (log(x) > 1) ) { printf("if") } else { print("else") }

##   We could achieve the same effect with
if ( x > 0 )
  {
     if ( log(x) > 1 ) { print('if') } else { print('else') }
  }

###   

##   Look at
##   if ( c1 || c2 || c3 )
## Suppose c1 is FALSE. Then we have to look at c2. If c2 is TRUE
## we know c1 || c2 || c3 must be TRUE, so there is no need to evaluate c3.

## There is a similar short-circuit or (||)
## if the first condition is true, do not evaluate the second

######################################
#   notes on syntax.
#
#   An if or for or while does not need to have braces following it provided 
#   the body controlled by for, if, while, or else is one statement.

x=0
for ( i in 1:10 )
  x = x + 1
print(x)


#### Note the print statement executes once only.
y = -1
z = -2

print(x)
if ( x > 3000 )
  y = 5
  z = 3
print(y)
print(z)

if ( x > 1 )
  y = 5
  z = 20
print(y)
print(z)



####### The indentation can be misleading

print(x)
if ( x > 3000 )
  {
  y = 50
  z = 30
  }
print(y)
print(z)

###  I believe it is good programming practice to always put in
###  {  }, even when there is only one statement.
###  Code maintenance is an important task. this means modifying or fixing
###  bugs of code written long ago.

###  Suppose that originally this code was just fine:

x = 0
for ( i in 1:10)
  x = x + i^2

###   Later you wish to add y = y + i to the body of the for loop.

y = 0
x = 0
for ( i in 1:10)
  x = x + i^2
  y = y + i

####  You make the changes above. All looks well. You're in a hurry.
####  It doesn't work. You go back and look, and still can't see why.

x = 0
for ( i in 1:10)
  {
     x = x + i^2
  }

###  Look at the above code. The chances of you doing

y = 0
x = 0
for ( i in 1:10)
  {
     x = x + i^2
  }
  y = y + i

###  are very remote.

#####    vector recycling

a = c(1,2,3,4)
b = c(10,11)
c = a + b
print(c)

#### c[1] = a[1] + b[1]
#    c[2] = a[2] + b[2]
#    c[3] = a[3] + b[1]  we ran out of b, so we start over at the first element of b
#    c[4] = a[4] + b[2]  we recycle the shorter vector

d = a + 1  
print(d)
# 1 is a vector of length 1. When we recycle it, since it has length 1,
# a + 1 just adds 1 to each element of a, and we store the result in d

e = c(30,31,32)
f = a + e
print(f)
#   note the warning. e was not recycled an integral number of times.
#   we were part way through e when we reached the end of a

#  If you want your vector additions to behave in a mathematically correct way
#  you must write your own function. You would check that the lengths of your
#  vectors are equal, or throw an error.

g = c(5,6,7,8)
print(a*g)

##   note that multiplication is element by element.


################    unique ############################

## unique removes duplicates

x = c(1:20,15:25)
print(x)
u = unique(x)
print(u)

#####  which gives locations #############################

m1 = which(x == 18)
print(m1)

m0 = which(x > 1000)
print(m0)
mode(m0)
4 + m0
m0 == 0
length(m0)
storage.mode(m0)

###   Suppose you want to remove all entries greater than 100

x = c(3,105,23,56,110,67)
y = x[-which(x > 100)]
print(y)

###   Now suppose you want to remove elements greater than 200
y = x[-which(x > 200)]
print(y)

###  What happened? 
length(which(x > 200))

###  So the exclusion operator ( a - following [ ) does not work if you do not
###  have anything to exclude
###  

###  The fix:

{
if ( length(which(x > 200)) > 0 ) 
  { 
    y = x[-which(x > 200)] 
  } 
else 
  { 
    y = x  # nothing to exclude
  }
}
print(y)


###  A safe way to remove all NA and NaN values

x = c(NA,3)
is.na(x)
x = c(NaN,3)
is.na(x)

###   is.na returns TRUE for NA and NaN

x = c(54,12,34,-6,7.8,NA,54)

if ( length(which(is.na(x))) > 0 ) { y = x[-which(is.na(x))] } else { y = x }
print(y)

x = c(23,-8,22,67)
if ( length(which(is.na(x))) > 0 ) { y = x[-which(is.na(x))] } else { y = x }
print(y)



m2 = which( (x == 18) & (u == 18) )    #### note the recycling
print(m2)

m3 = which( (x == 18) | (u == 18) )    ##### and here
print(m3)

### now try &&

which( x == 18 && u == 18 )

####  && does not work on vectors whose length is greater than 1

##### The && only looks at the first x and first u
which( x == 1 && u == 1)

y = c(3,9,4,-6,0,5,9,6,-1)
which.max(y)
which.min(y)

#### notice which.max and which.min do not tell you how many max/min
#### there may be

### here is a little function I wrote to return indices of all
### the values equal to the maximum
where.max <- function(x) 
{ # begin where.max
   return( which(x == max(x)) )
} # end where.max

where.max(y)

###  many times you see people write R code with expressions like
###  which(x == max(x)) without telling you what is going on. And there
### are many more complicated ways of combining R functions that do very
### nice and useful things.

### the intent of these complicated expressions should be put in comments
### if you find yourself using one of these useful, but tricky, things
### you might make it into a function with a meningful name, and this
### will make your code easier to understand

### unique does not give us a count for its entries. R can do it nicely

### recall u has the unique elements of x

count = numeric(length(u))
for ( i in 1:length(u) )
   {
       count[i] = length(which(x == u[i]))
   }
### is our answer right?
( sum(count) == length(x) )
( sum(x) == sum(u*count) )

print(count)

### note that in R the u*count is element by element multiplication
### R was written by statisticians, not by numerical linear algebraicists


#####  %in%      ##################################

( 13 %in% x )   # is 13 in x?
( 1.5 %in% seq(0,4,0.5) )
( 1:10 %in% c(4,5,6,9,12) )

##### match
##### match(x,y,nomatch = z)
####  this looks in y for first matching value of x
####  if there is no match, then z is returned. You can
####  leave out the nomatch, and then NA is returened for no match

a = c(1,3,5,7,8,9,10,11,3)
b = c(3,6,8,9,13)
match(a,b)
match(a,b,nomatch = -1) 

### just what you expect
union(a,b)
intersect(a,b)

##### One general note. There is no uniformity in R about the treatment
##### of NA and NaN values. Some funtions will not distinguish between
##### NA and NaN, but some will.

#### any and all

if ( any(a %% 5 == 0) ) {print("a has multiples of 5")}
if ( all(a %% 5 == 0) ) {print("a has only multiples of 5")}
if ( all(a > 0) ) {print("a has only positive values")}

### we can accomplish the last with
if ( min(a) > 0 ) { print("a has only positive values") }

##### there are many ways to accomplish the same thing in R

##### I will suggest that if you have many of the unique, which,
##### %in%, etc combined in one statement you may get it to work
##### once, but even the next day you won't understsand it.

##### For clarity I suggest breaking it into multiple statements
##### with pertinet comments

u = 4
v = 2.6
ifelse( u>v,2*u,2*v) # if condition is true first is done, else second
v = 10
ifelse( u>v,2*u,2*v)
### but ...
a = c(1,2,3)
b = c(-1,1,5)
ifelse(u > 0,a+b,a-b) 
##### u > 0, but it only adds the first elements of a+b.
#####        it does not add the whole vector
d      = numeric(length(a))
d[1:3] = ifelse(u > 0,a+b,a-b) 
print(d)
###  not what one might expect. The problem is the condition
###  has length 1, So the first result was recycled into
###  d[2] and d[3].
u = c(-1,0,1)
d[1:3] = ifelse(u > 0,a+b,a-b) 
print(d)





##### Now for a quick introduction to matrices

##### first way

x = 1:10
y = 101:110
z = 201:210

m = cbind(x,y,z)  # combines vectors of equal length into a matrix
                  # x becomes the first column, y the second, etc.
print(m)          # note the column names
dim(m)            # gives dimension. just like length for a vector
dim(m)[1]         # number of rows
dim(m)[2]         # number of columns
is.matrix(m)
m[2,3]          # reference one element
m[,2]           # reference column 2. The "," means let the first index
                # range form first row to last row
m[,"z"]         # access column named z
sum(m[,1])
m[3,]           # access the third row
length(m[,1])   # if you forget about dim

nrow(m)
ncol(m)
##### second way

mr = rbind(x,y,z)   # bind the vectors by row
print(mr)
dim(mr)

##### a third way
m.new = matrix( c(x,y,z), nrow = length(x)) # do not need to specify num.
                                            # of columns 
print(m.new)
m.row = matrix( c(1,2,3,4,5,6,7,8,9), nrow = 3) # default is to fill by col
print(m.row)
m.row = matrix( c(1,2,3,4,5,6,7,8,9), nrow = 3, byrow = TRUE)
print(m.row)

########  The switch statement

#   switch(expression,s1,s2,s3,s4,s5) for example
#   if expression = 1, then s1 is executed.
#   if expression = 2, then s2 is executed, etc.
#   expressn should evaluate to an integer

n = 2
a = switch(n,
           3*n,
           3^n,
           3/n,
           3 + n)
print(a)
n=4
a = switch(n,
           3*n,
           3^n,
           3/n,
           3 + n)
print(a)

n = 6
a = switch(n,
           3*n,
           3^n,
           3/n,
           3 + n)
print(a)

###      Equivalent code

###    if ( n == 1 )
#        { a = 3*n )
#      elseif ( n == 2 )
#        { a = 3^n }
#      elseif ( n == 3 )
#        { a = 3/n }
#      elseif ( n == 4 )
#        { a = 3 + n }
#      else
#        { a = NULL }

####   if you want to do more than 1 thing
n = 3 
a = switch(n,
           c(3*n,exp(n)),
           c(3^n,sin(n)),
           c(3/n,5),
           c(3+n, n^2))
print(a)

#   or if you want to do something very complicated
#   you could write a function for each case.
#
#    a = switch(n,
#               f1(n),
#               f2(n),
#               f3(n) )




