######################################
#
#   Numerical and Data Storage Issues
#
######################################

# First we look at some computations


sqrt(-3)

####  the NaN means "not a number". This is produced when the
####  computer cannot give a numerical result. Here it is trying
####  to stay in the real number system, and can't calculate an
####  answer.

sqrt(as.complex(-3))


2^1023

# that is a big number. What about twice that number?

2^1024

# Inf denotes infinity
# Wow!  So 2*2^1023 is infinity.
# Well, of course it is no nearer infinity than 1 is.
# But we have a largest representable number, and if the calculation
# exceeds that largest representable number, we get Inf as the
# answer

# It is interseting that we can do logical operations such as

a = (Inf > 2)
print(a)

a = (Inf > 2^1024)
print(a)

a = (Inf == 2^1024)
print(a)

#  recall that sqrt(-3) is Nan

a = (Inf >= sqrt(-3))
print(a)
mode(a)

#   So variables with mode of logical can take on TRUE, FALSE, and NA
#   as values


### R can print numbers to varying degrees of precison
options( digits = 7 )  # this is the default
sqrt(2)

pi


#### note that options ( digits = n ) only controls how
#### many digits are displayed on the console. It does
#### NOT affect the number of digits used by the computer
#### for its calculations

options(digits = 16)

sqrt(2)

pi

### Suppose we want EXTREME precision

options(digits = 50)

### oh, we do not have that much precision

options( digits = 22)

pi
# Actually the first digits of pi are 3.1415926535 8979323846 2643383279 

# So we see there is a limit to the accuracy of the computer

####    Almost all computers use the IEEE 754 standard for storing
####    floating point numbers. Doubles use 64 bits. One bit tells
####    the computer the sign of the stored value (1 in the sign bit
####    implies a negative number). Then there are 11 bits that
####    store the exponent. Finally we have 52 bits to store the
####    significant digits (significand). An internet search on
####    IEEE 754 will allow you to find out all the details.

####    Suppose computers used decimal numbers. We have dits instead of
####    bits. Suppose we have two dits for the exponent and 5 dits for
####    the signicand. Then we could store  12345X10^99, for example by
####    putting 99 in the exponent dits, and 12345 in the significand dits.
####    how can we store the number 123.0? We coud put 0 into the exponent
####    field, and 00123 into the significand; or we could put -3 into the
####    exponent field, and 12300 into the significand.

####    The latter is preferred. We want the most-significant digit to be
####    non-zero. That is called a normalized floating point number.

####    Returning to bits, we want the most significant bit to be 1. That
####    is a normalized binary floating point number. Since "all" doubles
####    are stored in normalized form, we know the most significant bit is
####    1. In the 1970's, a computer company that had glorious days ahead of
####    it (and a brutal death in the 1990's) decided not to store a bit that
####    is always 1. So when it moves a double into the ALU for processing,
####    it always puts a 1 in the most significant bit.This gives a little
####    extra precison for free. The IEEE 754 standard uses this trick.

####    Now 2^-10 = 1/ 1024  so 10 bits gives roughly 3 digits of accuracy.
#       So 53 bits give roughly (1/1024)^5*(1/8) and this is roughly
#       16 bits of accuracy. You can think of a double precision number
#       as having 16 (or so) decimal digits.

#       Intel CPUs have 8 floating point registers with 80 bits instead
#       of 64 bits. If we load our 64-bit double to one of these registers,
#       and then perform arithmentic on it, we have roughly the equivalent
#       of 22 decimal digits. 

#       The catch is that we start with 64 bits, so a truncated value
#       is moved into the floating point register, and then when we
#       store the register value back into memory, we must truncate
#       to 64 bits. Alas.

######    Let's explore a bit

options( digits = 16 )

a = 0.1    # what could go wrong?
print(a)
print(10^6*a)

#   Everything looks good.


### Now let's add up the number a 1000000 times.
### We don't want to write a+a+a+a+a... 1000000 times
### Here is where for loops come in handy

b = 0; for ( i in 1:10^6) { b = b + a }

## The first time in the loop b = 0. then we compute
## b+a. This is 0 + 0.1. We store the result in b.
## The second time in the loop we compute b + a, or 0.1 + 0.1;
## and store the result in b. We do this 10^6 times.
## Our answer should be 100000.0000000
## Is it?

print(b)


## Close, but not exact. We have only 11 accurate digits.
## In fact, we see that n*a is not equal to adding up a
## n times. This would not happen in the real number system.
## Not all the laws of arithmetic hold when you calculate on
## the computer.

(delta = 2^-53)


### let's add delta to 1 six times in two different ways.

((((((1 + delta) + delta) + delta) + delta) + delta) + delta)

(1 + (delta + (delta + (delta + (delta + (delta + delta))))))

### We see that arithmetic is not associative! 

### Let us add 100000*delta to 1 using addition
###      method 1
b = 1; for ( i in 1:100000) {b = b + delta}
b


###       method 2
###   First we add delta to itself many times. Then we add the 1.
sum_delta = 0; for ( i in 1:100000) { sum_delta = sum_delta + delta }
1 + sum_delta

###  Which answer do you believe?

b + 100000*delta


#### In fact we could change 100000 in the for loop limit
#### to any number, even 10^20 for example, and method 1
#### would still give 1 as the answer

#### Moral of the story: If you are adding numbers that vary
#### greatly in magnitude, then add the small numbers together
#### first.


###   By far the biggest practical problem is subtracting
###   two numbers which are nearly equal

 (123.4567890987654) -  (123.4567890987653)

### true answer is 1e-13. 

### The real problem is that even if we obtained the true
### answer, we have lost many significant digits. So, for example,

round( (123.4567890987654) -  (123.4567890987653), 13)

# The answer is correct, but we have only 1 significant digit.
# And in a general compution, we would not know how much we should
# round.

### Let's look at the calculation of a derivative at a single
### value of x.
### Recall f'(x) = lim as h->0 of ( f(x+h) - f(x) )/h
### So if we let h get smaller and smaller, we dhould get a
### better (more accurate) calculation of the derivative.
### Let's see.

### f(x) = arctan(x) implies f'(x) = 1/(x^2 + 1)
### numerically compute f'(x) at x = 4.1
x.0 = 40
true.value = 1/(x.0^2 + 1) 
sprintf("%1.16e",true.value)

### now lets try some different values of h

h = 1.0e-2; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### 3 correct digits

h = 1.0e-4; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### 5 correct digits

h = 1.0e-6; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### 7 correct digits

h = 1.0e-8; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### 4 correct digits

h = 1.0e-9; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### 4 correct digits

h = 1.0e-10; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### 2 correct digits

h = 1.0e-12; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### 1 correct digit

 h = 1.0e-13; d.num = ( atan(x.0 + h) - atan(x.0) )/h 
sprintf("%1.16e",d.num)
### Disaster!!

### The purpose of these demos is to illustrate that when
### you calculate on a computer, you are not using the real
### number system. You have to exercise some care in the
### way you do your calculations

### If you remember ONLY ONE THING, remember this.
### The most common problem in practical computations
### is the subtraction of two nearly equal numbers.

### In our derivative example, as h -> 0, we will have
### f(x+h) nearly equal to f(x). There are good ways
### to calculate derivatives; you just can't apply directly
### the derivative definition from your calculus text.

####  Other anomolies
#     Very often x^2 - y^2  does NOT equal (x+y)*(x-y) 
#     (x+y)*(x-y) is the more accurate calculation

n = 10000

#  x and y are in (-1000,1000)
x = runif(n,-1000,1000)
y = runif(n,-1000,1000)

u = x^2 - y^2
v = (x+y)*(x-y)

z = u - v    # z should be all zeros
length(which(z != 0 ))
max(z)
min(z)
dev.new();plot(z)

#  repeat with x and y in (0,1)

x = runif(n)
y = runif(n)
 
u = x^2 - y^2
v = (x+y)*(x-y)

z = u - v    # z should be all zeros
length(which(z != 0 ))
max(z)
min(z)
dev.new();plot(z)

###   Storage

#  first, look at characters

#  Today "all" computers use ASCII to store characters. ASCII
#  requires one byte for each character.
ch = "a" # store the character "a" into the object ch
mode(ch)
storage.mode(ch)

####   Some characters can be converted to numeric.

ch5 = "5"
mode(ch5)
storage.mode(ch5)

convert.to.numeric.5 = as.integer(ch5)
mode(convert.to.numeric.5)
storage.mode(convert.to.numeric.5)
3 + convert.to.numeric.5

n = as.double(ch5)
storage.mode(n)

ch2 = "36.7"
as.double(ch2)
as.integer(ch2)

x = 45.789
ch.x = as.character(x)
ch.x

x = exp(1)
ch.x = as.character(x)
print(ch.x)
print(x)

#  note the subtle differnce of x and ch.x





#####     Example of a double
a = 0.1;  # our old friend
mode(a)
storage.mode(a)


b.int = 3691L;  # note the L at the end. This is the C language
                # way of saying "long integer". R is actually
                # a C program behind the scenes
mode(b.int)
storage.mode(b.int)

####     In most languages you cannot do arithmetic operations
####     on two operands with different storage mode. If you
####     want to add a and b.int, you have to convert the integer
####     to a double. But in R you don't have to worry

a + b.int


####     Can we add a character mode variable to a double?

a + ch

####     No. That is a good thing.
####     You can test the mode of a variable

is.numeric(a)
is.numeric(ch)
is.numeric(b.int)

is.character(ch)
is.character(a)

is.integer(a)
is.integer(b.int)

#####  We can see the binary representation of doulbes


####    There are two ways:
library(SoDA);
binaryRep(a)

####    or, in hexadeciaml, with trailing zeros not printed
sprintf("%a",a)


##### examples

a1 = 0.5
binaryRep(a1)

a2 = 0.875  # 7/8
binaryRep(a2) 

delta = 2^-53
binaryRep(delta)

binaryRep(1)

binaryRep(1+delta)


####  Consider adding two numbers expressed in scientific notation,
####   such as 2.3 X 10^4 and 1.5 X 10^5
####   We cannot add 2.3 and 1.5. We change the first to have 10^5
####   in the exponent. We then must shift 2.3 into 0.23
####   We get 1.73 X 10^5
####  
####  It works the same way in binary. 1 has an exponent of +1
####  and delta has an exponent of -52. As the hardware shifts the
####  signifcand to the right by 53 bits, it makes the exponent +1.
#### Now the two numbers have the same exponent, so we can add the
#### significands. Unfortunately, the "1" bit in delta's significand
#### got shifted out. We are adding 0 to 1. The result is 1 (naturally).

# Now look at 
binaryRep(1 + (delta+delta)) # add the delta's first

# Notice the 1 at the far right. That stays in the result because

binaryRep(delta+delta)

### has an exponent of -51. So when we shift by 52 bits, we do not
### lose our precious numbers


### Now let's look at the derivative calculations
x.0 = 40;
true.value = 1/(x.0^2 + 1) 
binaryRep(true.value)

h = 1.0e-6; temp.1 = atan(x.0 +h); temp.2 = atan(x.0)
            diff = temp.1 - temp.2

binaryRep(temp.1)
binaryRep(temp.2)
binaryRep(diff)

####              Notice that diff has lost many significant digits
####              All those zeros at the end are garbage. They are
####              not accurate.
binaryRep(diff/h)  ## our computed derivative


h = 1.0e-12; temp.1 = atan(x.0 +h); temp.2 = atan(x.0)
            diff = temp.1 - temp.2

binaryRep(temp.1)
binaryRep(temp.2)
binaryRep(diff)  

####              Notice that diff has lost many significant digits
binaryRep(diff/h)  ## our computed derivative

#### Use .Machine to make your code portable


.Machine

#####      Look at $double.xmax, and compare to 2^1023 and 2^1024



######   Lastly
v = c(1,2,3,4,5,6,7,8,9,10)
storage.mode(v)
object.size(v)  # needs 8*10 = 80 bytes for the data


v.int = as.integer(v)
storage.mode(v.int)
object.size(v.int)

####  So it appears that if you know your data are integers, you
####  can save substantial storage by storing them as integers
####  instead of as doubles

p = 0.5
storage.mode(p)  
object.size(p)   # needs 8 bytes for the data

ch = "a"
storage.mode(ch)
object.size(ch)   # needs 1 byte for the data

######    Notice the bloat!!! p only needs 8 bytes. What IS going on?
######    Answer: Everything in R is an "object". That means it stores
######    a lot of extra information aside from the data. It stores
######    the mode. Is it numeric or character? When you call is.numeric(p)
######    it needs some way of knowing. It is difficult to know just how
######    much bloat there will be.



