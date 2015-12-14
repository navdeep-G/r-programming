#####     How data is stored   

#####    This script demonstrates how data is stored on a
#####    computer, and how R uses the data

#####    We will mainly be concerned with how numbers are stored.

#####    Computers have an ALU (arithmetic and logic unit), an
#####    instruction set, a CPU, and memory.

#####    The CPU will fetch instructions from memory and execute them.
#####    The details differ from computer to computer, but "all" computers
#####    have an ALU that can perform operations on integers (usually
#####    called fixed point) and floating point numbers. Integers are 
#####    usually stored in 32 bits (4 bytes - a byte is a unit of
#####    storage that contains 8 bits). Floating point numbers usually
#####    come in two flavors:  single precision (occupying 32 bits) and
#####    double precision (occupying 64 bits). For completeness, we add
#####    that "all" computers store character data using the ASCII code.
#####    Each character occupies 1 byte. There is also a character code
#####    called unicode, which uses two bytes to store a single character.
#####    Why use unicode? Think of all the alphabets used throughout
#####    the world. If you are using Roman script, ASCII will save you 
#####    space.

#####    The R language does not use single precision floating point numbers.
#####    It uses integers and double precision numbers. For example

#####    Example of a character
ch = "a" # store the character "a" into the object ch
mode(ch)

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

####     Just what we want.

a + ch

####     Can we add a character mode variable to a double?

a + ch

####     No. That is a good thing.
####     You can test the mode of a variable

is.numeric(a)
is.numeric(ch)
is.numeric(b.int)

is.character(ch)
is.character(a)

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

####    Hence we really have 53 bits in the significand. (Do you recall
####    an example where 2^-53 played a starring role?). Now let us look
####    at how 0.1 is stored.

####    There are two ways:
library(SoDA);
binaryRep(a)

####    or, in hexadeciaml, with trailing zeros not printed
sprintf("%a",a)

####    notice the difference. The binaryRep and sprintf use
####    binary points that are different by one position. Hence
####    the difference in the exponents they display.

####    Now in binary one-tenth does equal
####    0.00011001100.... (the pattern 1100 repeats forever)
####    This is like 1/3 repeating forever in decimal. So natually
####    we cannot store 1/10 exactly. 

####    So we cannot store 0.1 exactly in the computer! Note that since
####    we have 64 bits for a double, we can only store 2^64 numbers
####    exactly. And 1/10 is not one of them. The numbers we can store
####    exactly have a power of two in the denominator. So 5/32 or
####    19/1024 can be stored exactly. And it is good that all integers
####    can be stored exactly in double format.

####    Now we see why we had a problem adding up 0.1 100,000 times.
####    The number stored in a was actually a little more than 0.1

##### examples

a1 = 0.5
binaryRep(a1)

a2 = 0.875  # 7/8
binaryRep(a2) 

delta = 2^-53
binaryRep(delta)

binaryRep(1)

binaryRep(1+delta)

binaryRep(1 + 2^-52)

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

### Now consider the finite geometric series. Can you see that
### if we add in the forward direction we eventually add a small
### number to one that is much larger than itself? When this occurs
### we have the same effect as if we were adding 0 instead of a small
### number (small relative to the other operand)

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

#####      1/8 < 1/10 < 1/16
#####      1/8 uses 3 bits   and 1/16 uses 4 bits
#####      This means that somewhere between 3 and 4 bits
#####      give us 1 decimal digit of accuaracy. 
#####      53 bits give us approximately 16 decimal digits of
#####      accuracy.

#####      Finally, you may someday work on a strange machine, or
#####      there may be a new standard replacing IEEE 754. If you want
#####      to know details of your machine precison type

.Machine

#####      Look at $double.xmax, and compare to 2^1023 and 2^1024

######   Lastly
v = c(1,2,3,4,5,6,7,8,9,10)
storage.mode(v)
object.size(v)  # needs 8*10 = 80 bytes for the data

###### now convert v to integer representation
v = as.integer(v)
storage.mode(v)
object.size(v)  # needs 4*10 = 40 bytes for the data

#### If your data really is integer, you can save storage
#### by explicitly making it integer. This can be important
#### for long arrays.

v = c(1:11)
storage.mode(v)
object.size(v)  # needs 4*11 = 44 bytes for the data

v = c(1:12)
storage.mode(v)
object.size(v)  # needs 4*12 = 48 bytes for the data

ab = rep(1L,1)
object.size(ab)

ab = rep(1L,2)
object.size(ab)

ab = rep(1L,3)
object.size(ab)

ab = rep(1L,4)
object.size(ab)

ab = rep(1L,5)
object.size(ab)

#####   Hard to predict how much storage is required.

#####   But for longer arrays...

ab = rep(1L,1000)
object.size(ab)

ab = rep(1L,100000)
storage.mode(ab)
object.size(ab)

ab = rep(1,100000)
storage.mode(ab)
object.size(ab)

####  there seems to be a fixed overhead of 24 bytes for vectors

m = matrix( rep(1,100), ncol = 10)
storage.mode(m)
object.size(m)

m = matrix( rep(1,1000), ncol = 4)
storage.mode(m)
object.size(m)

####  looks like matrices have a fixed overhead of 112 bytes


ch = "a"
storage.mode(ch)
object.size(ch)   # needs 1 byte for the data

######    Notice the bloat!!! p only needs 8 bytes. What IS going on?
######    Answer: Everything in R is an "object". That means it stores
######    a lot of extra information aside from the data. It stores
######    the mode. Is it numeric or character? When you call is.numeric(p)
######    it needs some way of knowing. It is difficult to know just how
######    much bloat there will be.
