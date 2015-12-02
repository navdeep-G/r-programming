#############   Brief introduction to variables
#############      and vectors

############################################
#######   variables
############################################

#   One can think of a variable as a name for a chunk
#   of memory. In many progamming languages one must declare
#   all varaibles before using them. This is especially true
#   for languages that are compiled. The compiler allocates 
#   memory for each declared variable. Then the code is translated
#   to the instruction set used by the computer. This is the executable code. 
#
#          example using C language syntax
#    double x,y;   <the declarations>
#
#    x = 3.0;     /* the executable code */
#    y = 2*x;
#
#    z = x;       /* causes a compilation error. code will not run*/
#
#    in R (and Fortran) you don't have to declare a variable before
#    using it. 

#  We simultaneously allocate memorey for x, and assign a value to x.  
x = 3.0 
print(x)

#    Here we note the above is called "an assignment statement"
#    The RHS is evaluated, and the value is stored in a memory
#    chunk called x. We can later read the value stored in x, and
#    use it in an assignment statement.
#    If we can evaluate the RHS of an assignment, we can save the
#    evaluation in a new variable.

y = 2*x
print(y)

#    For completeness, we add that instead of "=", we can use
#    "<-" in assignment statements. 

z <- exp(1)   # z gets the value of e = 2.718281828......
sprintf("z = %8.5f",z)    # a fancier way to print that
# gives you more control. For
# more info, type ?sprintf
sprintf('z = %1.11e',z)   # prints value is exponential notation.


### Take care. If you accidently type < - (space between < and -)
z < - exp(1)     # z is not less than -exp(1) 

#    Some people prefer "<-" for aesthetic reasons.
#    Some people also prefer "<-" because "=" and "=="
#    are easy to confuse. One types "=" when meaning "==",
#    for example. More about "==" later.

#    We can also use "->" for an assignment statement.
#    Now the LHS is evaluated and stored in the RHS.
#    I strongly recommend you NEVER do this. It is quirky,
#    and has no advantage. It makes your code harder to read.

5 -> w
sprintf("%d",w)  # %d for integers

#    From now on, we only use "=" or "<-" for assignments.


#    You cannot use a variable that has not been used before
#    on the RHS of an assignment statement. 

#    Here no value is known for the (non-existing) variable
#    a.b.c

x = 2*y + a.b.c    # note we can use "." as part of the name

#    This is a sensible reaction, because how does R know how
#    to calculate the RHS when it doesn't know the value of a.b.c?

#    Variable names 

#    Ordinary variables start with a letter (a-z,A-Z). R is case
#    sensitive. After the letter, we may append as many other letters,
#    numerals (0-9), underscore (_), or dots (.) as we please.

0x = 4
_x = 4


#    This is a sensible reaction, because how does R know how
#    to calculate the RHS when it doesn't know the value of a.b.c

#    An important warning. The ability to assign a new variable that
#    has not been declared can lead to didastrous results. When we
#    discuss loops we will show how this once led NASA to lose a rocket

#    example:

a.very.long.name = 3*cos(x)

#
#    suppose there is a lot of intervening code here
#

a.very.long.nme = log(y)  # you meant a.very.long.name = log(y)
x               = 2*a.very.long.name

#    At this point x does not have the value you intended.
#    This will lead to incorrect results, and then you must debug.
#    Since you are not a computer, when you scan your code
#    it is VERY likely (do trust me on this) you will not notice
#    the typo.

#    An aside on your workspace before we debug. If you want to
#    know the variables in your workspace use

ls()

#    We can remove a vasriable. For instance,

rm(w)   # Important note: rm(w) removes the assignment to the
# object w; it does not delete the memory for the object.
# (John Chambers, Software for Data Analysis, p.472)
# R will run garbage collection when it feels like it
# to free this memory up

#   In fact, when we use an assignment statement, such as a = 5,
#   a is a pointer to the chunk of memory that holds the value of a.
#   A pointer is a variable that contains an address of a memory location.
#   The C language alllows pointer variables, and R is essentially a C 
#   program that interprets R statements. In R we cannot directly perform
#   pointer operations. You could write code in R and be blissfully unaware 
#   that a is a pointer to a chunk of memory that contains the variable a.
#   One thing this shows is that R uses more memory than necessary. 

#   To remove everything from your workspace type: rm(list=ls())
#   Don't worry now why this command works. 
#   The best way to track down the problem of mistyped
#    variables is:
#    clear your workspace 
rm(list=ls())  # this removes all variables.

#   Rerun your code
x = 3.0
y = 2*x
z <- exp(1)

a.very.long.name = 3*cos(x)

#
#    suppose there is a lot of intervening code here
#

a.very.long.nme = log(y)  # you meant a.very.long.name = log(y)
x               = 2*a.very.long.name

#  now issue
ls()

# Now look for variable names you do not expect. Then you can use
# an editor to find where the misspelling occurred.

# Nicely organized code is easier to read and debug. When I have
# several assignment statements occur consecutively I find it
# much easier to line up the "=" sign. Remember that when you
# enter code, you type it once, but you read it hundreds of times.

#       Example

#     a.factor = 2*cos( 3*asin(y^2) )
#     a.much.bigger.var = a - b + exp(sqrt(y))
#     j = 3
#     very.important = floor(a.factor -j)
#     do.not.forget.this.ever = log(1-x)

#     a.factor                = 2*cos( 3*asin(y^2) )
#     a.much.bigger.var       = a - b + exp(sqrt(y))
#     j                       = 3
#     very.important          = floor(a.factor -j)
#     do.not.forget.this.ever = log(1-x)

#     Which code would you rather read?

#     Also be liberal in the use of spaces

#     2*sqrt(3+log(y-atan(4*uvw))+ cos(theta))   
#     2*sqrt( 3 + log( y - atan(4*uvw) )+ cos(theta) )

#    or    a+abc*de-f    vs.    a + abc*de - f   


# Another insidious problem for which there is no easy solution:
# Suppose you have variables named v.1, v.2, v.3, and v.4

# Some of your code will be simlar so you cut and paste the following code

#     a.1 = 3*v.1
#     b.2 = 6 - v.1*v.2

# after cutting and pasting, and making what you think are
# the necessary changes you get

#     a.3 = 3*v.3
#     b.4 = 6 - v.1*v.4

# You wanted

#     a3 = 3*v.3
#     b.4 = 6 - v.3*v.4

# You get an error and need to debug. If you can't find the
# bug quickly, 
# You have to slow down. Don't scan your code. A human being
# is intelligent (aren't we?),and makes inferences. Your natural
# reaction is to read the code as you read anything. You will
# interpret what you read to be intelligible. Make a conscious
# effort to mimic a computer. Don't read a variable, or a line
# of code, quickly. 
# Read your code one CHARACTER at a time, as a computer does. Stop
# after each character, and ask yourself "Is this what I wanted?"
# This is what you must do if you get syntax errors from the R
# interpreter.If you read "b.4 = 6-v.1*v.4" one character
# at a time, you are much more likely to notice the incorret v.1


# Read the next two lines at your normal speed

#               Paris  in
#             in the spring

#  Most people think it reads "Paris in the spring".

################################################
#
#          vectors
#
################################################

#### you can create a vector in many ways.

x = c(1,2,3,4,5,6,7,8,9,10)
print(x)
is.vector(x)


y = 5.6
is.vector(y)

##     even y is a vector

##   We would ordinarily think y is a scalar, but in R it is a vector.
#    We do not officially have scalars in R, but a vector of length 1 can
#    be treated as a scalar for all practical purposes.


n = 20
z = 11:n     # 1:n is a way to create a sequence

s = x + z    # example of vector addition
print(s)  

s1  = 2*x    # each element is doubled
print(s1)

s2  = x^2    # each element is squared
print(s2)

sum(x)       # all elements are summed together
# notice there is no assignment
# the result is printed, but lost
# We have to recalculate it if we want it

mean(x)      # there are many useful functions available
var(x)

sum( (x - mean(x))^2 )  # this is a fast way to get something useful

x.2 = c(1+3,5,6/0)  # We can have Inf values
print(x.2)
mean(x.2)


s.3 = 2^(x)  # R is VERY powerful
print(s.3)

s.4 = log2(s.3)
print(s.4)

###   We can build new vectors from old ones

a.new = c(x,z)
print(a.new)
a.new = c(a.new,0,0,1,s2) # redefine a.new
print(a.new)

a.new = seq(from = 1, to = 200, by = 1)
a.new[3]
a.new = seq(1,10,2)  # do not need "from". etc.
print(a.new)



###   apply operations to a vector

v = c(2,3,5,6,8)
print(v^2)

###   apply a vector to a function
v = c(0,pi/4,pi/2,3*pi/4,pi)
sin(v)

# note the value for sin(pi). 

###  Note seq is very useful. Type "?seq" or
###  help(seq) for more information.
###  This applies to all the functions in R

###  Two helpful hints.
###  (1) Sometimes you will forget the exact name of a 
###      function, but know it contains a certain character
###      string. Suppose you know it has "lin" in its name.
###      use (apropos("lin"). This prints all functions
###      containing tha string.

apropos("lin")

###  hint (2). The documentation for most R functions
###  contain examples.You can run the examples for the seq
### function by typing

example(seq)

####### note the seq> prompt from this command
####### One last seq example from John Chambers
seq(-0.45,0.45,0.15)

#### better to do it this way
seq(-3,3,1) * 0.15

a.new = runif(20000) # this generates 20000 values
# from a uniform distribution.
# We will cover random number
# generation in detail later.

length(a.new)        # how long is it?
# If we have a long vector and do not want to
# list the whole thing, but want a glimpse of it

head(a.new)     # prints first 10 elements by default
head(a.new,15)  # use a second argument to specify how
# many elements you want printed
# or use
tail(a.new)  # to see the last elements

# You can also create a vector by reading a file.
# We will cover that soon.

#### One of the most useful and powerful things in R
#### is the way we can select vector elements

#####   examples

v = seq(1,30)
print(v)

v[6:10]

######   how many elements are there in v[6:10]
######   many think it is 5
length(v[6:10])

n = 7;
v[3:n+1]

####  v[3:n+1] does not do what most expect because of the
####  operator precedence. We expect n+1 to be evaluated to 8,
####  then used as the endpoint in 3:8. In fact the sequence
####  3:7 is generated and finally 1 is added to make 4:8
####  So use parentheses
v[3:(n+1)]

v[30:1]   # we can reverse the order

temp = v[28:32]  # we can access elements beyond the end
# of the array
print(temp)

temp = v[-(1:5)]        # a minus sign means remove these
print(temp)

s = c(1,5,7,8,11)
v[s]      # we can select elemnts based on any subset
# of the integers from 1 to 30 from v
v[-s]     # or deselect

s = c(1,5,7,15,2,4,1)  # the set can be "out of order"
v[s]

v[(v > 23)]  

v[(v>23) & (v<26)]   # note the "&"   (and)

v[(v>23) & (v<12)]
length( v[(v>23) & (v<12)] )
object.size( v[(v>23) & (v<12)] )  # everything is an object
v[(v<3) | (v>29)]              #  note the "|"  (or)

v[log10(v) <= 1.0]


v.2 = rep(1:10, 3)
print(v.2)

v[ v.2 == 7 ]         # we can even do this

##   note that we are using the contents of the vector v.2 to select
##   entries from v, which is a different vector.

v[ (v %% 10) == 7 ]   # use modulo

##### rep is also very powerful
example(rep)

#  c() is the concatenate function

#  Study these examples of c()
x = c(3,4,6,3,2)
y = c(100,104,401)

print(x)
print(y)

z = c(x,y)
print(z)

z = c(z,-5,y) 
print(z)

#  you can call functions inside c(). Here we call cos(), log(),
#  and rnorm. rnorm generates normal random vaiables.
t = c(cos(3),log(3),rnorm(5))


