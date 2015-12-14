#########################################
#
#     Data Frames
#
##########################################

# Data frames are a list of equal length
# vectors. The vectors can be thought of
# as a column of a data set. The columns contain
# measurements (or names) of certain attributes.
# The rows of a data frame can be thought of as
# the observations.

# An example of a data frame
head(mtcars)
class(mtcars)
str(mtcars)
object.size(mtcars)

# Another data frame
head(siwss)
str(swiss)

# Now might be a good time to mention that many data sets are available
# in R. Many packages have datasets included.

search()
#   to see the data sets available in the package data sets
#   just type data()
data()  

# to obtain more information on the meaning of the data type
# the help command with the dataset in question as the argument.
# Example:   
help(swiss)

# As an example, the package lmtest also has datasets.
require(lmtest)

data(package = 'lmtest')


# We can refer to elements in a data frame as if they were a matrix
row.names(mtcars)  # the row names. 
head(mtcars)
x = mtcars[,1]
is.vector(x)
is.data.frame(x)
print(x)
x = mtcars[,1,drop = FALSE]
is.data.frame(x)

# If we grab a single attribute it will be a vector.
# If we want that single attribute to be a data.frame
# we use drop = FALSE

# or we can use mtcars$mpg
mtcars$mpg


#  gets an attribute from the first observation
mtcars[1,2]

#  gets all the attributes of the first observation
mtcars[1,]

# or
mtcars['Mazda RX4',]
# gets first three attributes from first four observations
t = mtcars[1:4,1:3]  
is.data.frame(t)
print(t)     

# but we can't use names to grab multiple attributes

mtcars[,'$mpg':'$cyl']

# this doesn't work either
mtcars[,'mpg':'cyl']

rm(list=ls())

x1 = runif(10)
x2 = rnorm(10)
x3 = rexp(10,1)
x4 = rbinom(10,20,0.5)
x5 = c('a','b','c','d','e','f','g','h','i','k')


df = data.frame(x1,x2,x3,x4,x5)  # create a data frame
print(class(df))
print(mode(df))
print(object.size(df))
print(names(df))
colnames(df)
rownames(df) # note the default

# again, we can use column name for selection
df$x4
df$x5
is.factor(df$x5) # character columns default to factors

# If we want to override the default ...
df.2 = data.frame(x1,x2,x3,x4,x5,stringsAsFactors = FALSE)
is.factor(df.2$x5)
df.2$x5

# Later, if we wish to consider it a factor
f = as.factor(df.2$x5)
is.factor(f)

#  Note that one can convert a matrix to a data.frame
#  using as.data.frame()
#  One can also convert a data frame to a matrix using
#  as.matrix(). In this case, the columns will be converted
#  to one type

#  Note that here all columns are converted to character variables
#  because x5 is character

as.matrix(df)

#  note the difference when we only convert numeric columns
as.matrix(df[,1:4])

#######################################################
#
#    with
#
#######################################################



# This saves typing
with(mtcars,{y = mpg + cyl}) # mpg and cyl refer to mtcars$mpg, mtcars$cyl
print(y)

# y is local to the with environment
# if you are plotting, and wish to save typing, or just
# printing out results you do not want to save, or reference
# for a later computation, then this use of with works fine.

ls()
with(mtcars,
  {
    y = mpg + cyl
    print(y)
   } )


with(mtcars,
  {
    cat(ls(),'\n')     
    y  = mpg + cyl
    y1 = x1 + x2      # it can 'see' x1 and x2
    cat(ls(),'\n')    
    print(y1)
   } )
# note that y and y1 are added to the ls() output

# now look at ls() outside of with()
ls()  
w = x1 - y1   # that is why y1 is not found

# So with is like a function call as far as the scope of variables
# is concerned. New variables created inside with() disappear when
# you leave with()

# You cannot try to use with when you want two different data frames.
with(df,mtcars {
                 print(x1-x2)
                 mpg+cyl
               }
     )


x5[1] = 'z'  # change x5 slightly
print(x5)
print(df$x5) # did not change x5 witin df
search()
with(df, 
  {
    u  = x5          # x5 refers to df$x5
    x5 = rep("a",10)
    v  = x5          # now x5 refers to the local x5
    print(u)         # first element of u is "a", not "z"
    print(v)
    search()         # search path is not affected
  } )
print(df) # df is unchanged

with(df,
  {
    x2[1] = 0   # only affects a local x2
                # but notice other elements of x2 are same as df$x2
    print(x2)
    print(df)
   } )
print(df)

x1 = rep(-1,10)
x2 = rep(1,10)
a1 = rep(2,10)
ls()
with(df,
  {
     y <<- x1 + x2 # superassignment
     cat(ls(),'\n') # no y
     z = y + a1      # but we can access it and a1
     print(z)
     cat(ls(),'\n') # but we get z on the list
  } )
print(y)  # note that x1 and x2 inside with are df$x1 and df$x2
print(df)
# now x1 and x2 do not refer to columns in df since we outside the with()
print(x1+x2) 

# note the superassignment creates y in the global environment
# also note that x1 and x2 were obtained from df$x1 and df$x2

with(df,
  {
    x1 <<- rep(0,10)      # does NOT refer to df$x1
    df$x2 <<- rep(1,10)   # this changes df
    df#x3 <-   rep(2,10)  # this does not change df
  } )
print(x1)
print(df)

#  If you want to save your work that you did inside with()
#  you must use the superassignment 

#######################################################
#
#     attach 
#
#######################################################


####    start over

rm(list=ls())

x1 = runif(10)
x2 = rnorm(10)
x3 = rexp(10,1)
x4 = rbinom(10,20,0.5)
x5 = c('a','b','c','d','e','f','g','h','i','k')

df = data.frame(x1,x2,x3,x4,x5)  # create a data frame

rm(x1,x2,x3,x4,x5)

y = x1 + x2 # causes an error

ls()
attach(df)

y = x1 + x2 # attach allows us to use x1 instead of df$x1
print(y)

search() # note the attach() causes a new entry in the search path
ls()

x1[1] = 0 # on LHS x1 does not change df contents
print(x1)
print(df)
ls()

y.2 = x1   # this x1 is not from df
print(y.2)
ls(1)      
ls(2)      # elements of df
ls()
print(x2)    # from df
print(df$x1) # from df
detach(df)   # removes df from search path
search()
print(x2)    # no longer on search path


#####  each attach adds to the search path

attach(df)
attach(df)
attach(df)
search()
detach(df)
detach(df)
detach(df)
search()

#####  So, you must match each attach with a detach.
#####  One detach will not do the job

rm( list = ls() )

y    = matrix( 1:10,ncol = 5)
y.df = data.frame(y)

print(y.df)
# Notice the default column names
ls()
y1 = X1 + X2  # not found

attach(y.df)
ls(1)
ls(2)
y1 = X1 + X2
print(y1)     # now we find X1 and X2
X3 = X1 - X2
print(X3)     
ls(1)
ls(2)
print(y.df)   # y$x3 not changed

#  note X3 is located twice in the search path. But X3
#  in the data frame is in second place on the search list

y3 = y.df$X3  # but we can access X3 from y.df
print(y3)

#   If we wanted X3 = X1 - X2 to affect y.df
y.df$X3 = X1 - X2
print(y.df)

detach(y.df)

#   When you attach, be sure to look for a message saying
#   a variable is masked

rm( list = ls() )

x1 = 1:5
x2 = 6:10

df = data.frame(x1,x2)

attach(df)

##   this message tells you that a name conflict exists, and that
##   the name in the attached data frame will not be referenced
##   unless you use the standard long reference:
##   <data frame name>$<name>

##   The only purpose of attach is to save you some typing.
##   Well, that is justification enough. If there are no name
##   clashes, then you are OK. But remember, if you tey to change
##   the data frame contents after using attach, you MUST use
##   the long name on the LHS of your assignment statement.
##   If you just use the column name without the data frame name,
##   a NEW variable is created and receives the assignment. Your
##   data frame will not be changed.

