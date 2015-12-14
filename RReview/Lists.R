#########################################
#    Lists
########################################

#  Lists are something like vectors, but
#  do not have the restriction that all
#  elements must have the same mode.

#  A vector must have all its elements be numeric, or character,
#  or logical, etc.

#  Example

x = c(1,2,3,4)
y = c("ab","fgh")
z = c(TRUE,FALSE)
f <- function(x) { return(sin(2*x)) } # f(x) = sin(2x)

mode(x)
mode(y)
mode(z)
mode(f)

a = list(x,y,z,f)
mode(a)
print(a)
print(length(a))    # length is the number of 'things' in the list

#    systematically find the mode of the 'things' in a
for ( i in 1:length(a))
  {
     cat(sprintf("Item i has mode %s\n",mode(a[[i]])))
  }

#  str() gives the "structure" of its argument
str(a)

#  Note the [[1]], [[2]], [[3]]
#  The double brackets [[i]] refer to the ith "thing" in the list.

print(a[[2]])

#  How do we access individual elements of the ith 'thing'?

b = a[[2]][2]
print(b)

b = a[[1]][3]
print(b)

print(a[[4]](pi))     # execute the function in the list
                      # note the shocking round-off error

v = seq(0,pi, by = 0.01)
plot(v,a[[4]](v), type = 'l')

graphics.off()        # kill all plots

b = a[c(1,3)]     # select first and third things from list a
mode(b)           # it is a list since it is a selection of 'things' from a list
print(b)

b = a[-4]        # this works to delete 4th item from a vector
                 # and from a list
print(b)

#  b = a[[i]] is not a list. It is an element of a list.
#  b = a[i]   is a list. 
#             So a[i] and a[[i]] really contain the same information
#             but they have different modes and classes
mode(a[[1]])
mode(a[1])
print(is.vector(a[[1]]))
print(is.vector(a[1]))
print(is.list(a[[1]]))
print(is.list(a[1]))
print(is.numeric(a[[1]]))
print(is.numeric(a[1]))

#    We can give names to the 'things' in the list
b = list( first = x, second = c(12,67,1), third = z )
mode(b)
print(b)

print(b["second"])   # you need to use "
print(b[second])     # causes an error
print(mode(b['second']))  # You can also use ' instead of "
                          # but you need to use only one
print(mode(b[['second']]))  # double [[   ]]
print(mode(b['second']))    # single [  ]
print(is.vector(b['second']))    #  [   ]
print(is.vector(b[['second']]))   #  [[  ]]
print(is.vector(b['second']))    #  [   ]

print(b$second[2])   # Use $ to access a thing by name

#   We can add names to a list
#   As a reminder
print(a)

names(a) = c('x','y','z','sin(2x)')
print(a)
print(a[[1]][3])   # we do not need to use names
print(a$x[3])      # but we can

names(a) = c('x','y','z','f') # we can change the names
print(a)

#  We can also remove the names
names(a) = NULL
print(a)

# We can have lists inside lists
d = list(a,b)
print(d)
print(mode(d))           # d is a list
print(mode(d[[1]]))      # a list
print(mode(d[[2]]))      # a list
print(d[[1]][[2]][1])    # [[1]] gets us into the first thing (which is a list)
                         # of d. [[2]] gets us into the second thing
                         # of d (which is a vector). Then [1] gets us
                         # the first element of that vector

print(mode(d[[1]][1]))        # a list, because of second [  ]
print(mode(d[[1]][[1]]))      # not a list, because of second [[ ]]
print(is.vector(d[[1]][1]))   # but it is a vector
print(is.vector(d[[1]][[1]])) # it is a vector

print(names(d))                # names from second list within d do
                               # not percolate up to d
print(names(d[[2]]))           # but arte still in second list of d

names(d) = c("list1","list2")
print(d)
print(d$list2$second)          # we can use names to traverse the list
                               # down to the item we want
print(d$list2[[2]])            # or we can use a hybrid of names and numbers

#    We can also use names in vectors
v = c( "num1"=6, "num2" = 22, "num3" = 4, "num4" = 9)
print(v)
print(sort(v))   # notice the names get moved with the elements
print(mode(v))
print(names(v))
print(names(sort(v)))

print(b)   # a reminder of b
b.1 = b[2]
print(mode(b.1))   
print(names(b.1)) # the names are carried along with the numbers
print(b.1)

b.2 = b[[2]]      # b.2 is not a list
print(mode(b.2))
print(names(b.2)) # names are not carried with it
print(b.2)

####  one use of a list is to have one function return many
####  things of different size. lm() is a good example

#     Here we have a simplified lm-type function

x = c( 1, 0, 2, 0, 3, 1, 0, 1, 2, 0)
y = c(16, 9,17,12,22,13, 8,15,19,11)
regress <- function(y,x)
  { # begin regress
 
    stopifnot(length(y)  == length(x));
    stopifnot( is.numeric(x) & is.numeric(y) )
    b1 = sum((x-mean(x))*y)/sum( (x-mean(x))^2 )
    b0 = mean(y) - b1*mean(x)
    coeffs   = (c(b0,b1))
    fits     = b0 + b1*x
    resid    = y - fits
    l        = list( coeffs, resid, fits)
    names(l) = c("coeffs","resid", "fits")
    return(l)
  } # end regress 
m = regress(y,x)
print(mode(m))
print(m)
res = m$res      # if we use names to select from a list
                 # we only need to use as many letters as necessary
                 # to make it unambiguous
print(res)

##     notice use of stopifnot()

y1 = c(3,4)
regress(y1,x)

#  note that stopifnot does not allow you to put in a message
#  you want. stop() can do that.

#  Use of with
#  with is one way to allow you acces to 'things' in lists
#  without $ or [[ selection
with(m,mean(fits))

mean(m$fits)        # does the same thing as the line above

#  Suppose you had an object named fits in your environment.
#  Using with means you will get fits from m. There is no ambigutity.

##    There are a family of apply functions
#     lapply will apply the named function to the list elements
#     The results of lapply() are returned as a list
lapply(m,mean)      # find the means
mode(lapply(m,mean))

lapply(m,prod)      # find the product
lapply(m,length)    # find the length
lapply(m,mode)      # find the mode
lapply(m, function(x) 2+x) # apply a user-defined function
                           # this is an anonymous function
lapply(m, function(x) z = 2 + x; z^2) # user defined function cannot be elaborate
                                      # It cannot require more than one statement
                                      # hence the error
t = lapply(m, function(x) x > 0 )
print(t)

#  Try to use t for selection
m.p = m[[t]]
#  No luck

#  Whereas for vectors...
u = runif(20,-1,1)
sprintf("%4.2f",u)
t = sapply(u, function(x) x > 0)
v = u[t]
sprintf("%4.2f",v)

#  sapply will return the answer in a vector, if possible
t = sapply(m,mean)
mode(t)
length(t)
print(t) 

###   Back to lapply
#    Recall the contents of list a
print(a)
lapply(a,mean)
#    Note we get NA where we cannot apply the mean

