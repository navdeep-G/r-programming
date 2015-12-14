###########################################
#
#     Bit operations
#
##########################################

#  note there is a library 'bitwise' which is probably better
#  may work for R 3.0 and later, or R 2.14 and earlier
#  I don't know. One of the lovely features of R

install.packages('bitops')
library(bitops)

i = 0x37a    # enter number in hex
is.integer(i)
print(i)
print(3*16^2 + 7*16 + 10*1)

####  We want integer representation


i = 0x37aL    # enter number in hex
is.integer(i)
print(i)
print(3*16^2 + 7*16 + 10*1)

j = bitAnd(i,0xfffL)
j
j = bitAnd(i,0xf08)
j

is.integer(j)

j = as.integer(bitAnd(i,0xf08))
j
is.integer(j)

########################################################
#
#     get bits
########################################################

get.bits <- function(n)
{ # get.bits
    if (.Machine$integer.max != as.integer(2^31-1) )
      {
         stop("This code is made for 32 bit integers.\n")
      }
      one = 0x1L
      bits = numeric(32)
      for ( i in 1:32 )
        {
           bits[i] = bitAnd(n,one)
           n       = bitShiftR(n,one)
        }
      return(bits[32:1])
  
} # get.bits


get.bits(i)
get.bits(0xf08)
get.bits(j)

k = as.integer(bitOr(i,0x33020L))

get.bits(i)
get.bits(0x33020L)
get.bits(k)

######  Or with 0 does not change the bit
######  Or with 1 forces bit to be 1

######  And with 1 does not change the bit
######  And with 0 forces bit to 0


k = as.integer(bitXor(0xfaL,0x35L))

get.bits(0xfaL)
get.bits(0x35L)
get.bits(k)

######  Xor (exclusive or) also called modulo-2 addition
######  Xor with 0 leaves bit as is
######  Xor with 1 flips the bit

######  Pack data to save space
#
#    let bits 1-3 hold data in range 0 to 7. call it ed.level
#    let bits 4-11 hold bits in range 0 to 255 (2^8-1) call it sugar level
#    let bit  12   hols data in range 0 to 1    call it gender

ed.level    = as.integer(4)
sugar.level = as.integer(105)
gender      = as.integer(1)

####   shift values to proper place
shift.sugar = as.integer(bitShiftL(sugar.level,3))
shift.gender= as.integer(bitShiftL(gender,11))
data        = 0

####   place data fields with OR
data        = as.integer(bitOr(shift.gender,data))
data        = as.integer(bitOr(shift.sugar,data))
data        = as.integer(bitOr(ed.level,data))

get.bits(ed.level)
get.bits(sugar.level)
get.bits(gender)

get.bits(data)

###############  Now extract the fields

temp   = as.integer(bitShiftR(data,11))
gender = as.integer(bitAnd(temp,0x1L))


temp        = as.integer(bitShiftR(data,3))
sugar.level = as.integer(bitAnd(temp,0xffL))

ed.level    = as.integer(bitAnd(data,0x7L))


ed.level
sugar.level
gender

####   we correctly extracted the data

get.bits(5)

get.bits(-1)
get.bits(1)

get.bits(-300)
get.bits(300)

t = bitXor(300,0xffffffff)
get.bits(t)
get.bits(t+1)
get.bits(-300)

#####   To negate an integer (in two's complement)
#####   flip all bits, than add 1









