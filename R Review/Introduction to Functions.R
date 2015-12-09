 ########################
#   Intro to functions
#########################

##   a trivial example.
##   Here the function name is f
##   it has one formal argument, x.
f <- function(x)
{ # begin function body

   a   = x + 1
   b   = x - 1
   return(a*b)
} # end function body

# Once the function has been loaded into the workspace, we
# may invoke it

h = f(4)
sprintf("h = %9.4f",h)

y = 3

r = f(y)
sprintf("r = %9.4f", r)

######  note that in the funcion definition the x is a formal
######  argument. You do not have to call f with an argument named z
######  We called it with a constant, and with a variable named y.
######  Here, the actual arguments were the constant 4 and the variable y.

######  When you call the function, the actual arguments are bound to the formal
######  arguments. The VALUE of the actual argument is passed to the function.

######  Example 2
rm(list = ls())   #### have an empty workspace
ls()
y = 8  ### note this y is defined in the workspace,
       ### but not inside the function
f2 <- function(x)
{ # begin function body
  print("f2: value of actual argument is")
  print(x)
  y = x^2    #####  this y is a local variable defined inside the function
  print("f2: y ="); print(y)

  z = y + 2   #### z is local to the function also
  x = x - 1
  print("f2: new value of actual argument is"); print(x)

  return(y - x + z)
  
} # end function body 

######  When the function is called a new environment is created. Any new objects
######  created in the function are local to that function. 

print(y)
print(x)
print(z)
print(f2)

###  We have only defined the function thus far. We have not called it, or invoked it.

a1 = 5

##  Now we invoke it. a1 is the actual argument. 
r  = f2(a1)

####### When the function returns, its environment and all local values go away

print(r)   # the output of the function
print(a1)  # the actual argument is not changed
print(y)   # the assignment of the local y inside the function
           # did not affect the value of y defined outside the f2.
print(z)   # z is only local to the function f2.It disappears when f2 finishes.

#####  think of a Venn Diagram

#
#      ----------------------------------------------------------
#      |     environment from which we call (invoke) f2          |
#      |                                                         |
#      |   y exists here with value 8                            |  
#      |   a1 also exits with value 5                            |
#      |                                                         |
#      |   the function definition of f2 exists here also        |
#      |    So we can invoke f2                                  |
#      |   with r = f2(a1)                                       |
#      |        ------------------------------------------       |
#      |        |  the environment in which f2 executes   |      |
#      |        | Now we are in this environment          |      |
#      |        |  the value of a1 is bound to the value  |      |
#      |        | of the fromal argument x. So x has 5    |      |
#      |        | for a value. That value is printed.     |      |
#      |        | Next y is assigned x^2, or 25. This y   |      |
#      |        | is local to the f2 execution environment|      |
#      |        | It has nothing to do with the y in the  |      |
#      |        | environment that invoked f2.            |      |
#      |        | Then another local variable z is        |      |
#      |        | created. Then the value of the f2       |      |
#      |        | argument is changed. Note the value     |      |
#      |        | printed. Finally we return y - x + z    |      |
#      |        | as the function result. After we execute|      |
#      |        | the return, this environment and all    |      |
#      |        | local variables (here, y and z) go away.|      |
#      |        |                                         |      |
#      |        -------------------------------------------      |
#      |                                                         |
#      |                                                         |
#      -----------------------------------------------------------
##########  functions can call other functions


##########  When R sees a variable inside a function, (1) if the
##          variable is a formal parameter its value is the value
##          of the actual parameter. But you can change this value
##          with an assignment.
##          (2) if it is a local variable (meaning it is NOT a formal
##              parameter), then it is created with an assignment. If the
##              name of the local parameter conflicts with the name of a
##              parameter in the workspace, or the value of any variable in
##              the chain of functions that called it, the locally defined
##              version of that function is used. 

f3 <- function(in1)
{ # start f3

   y = in1 -1;
   print("f3: y =");print(y);
   x = f2(in1)                   # we call f2
   return(x + 1)
} # end f3

#### In the call below, note the prints from f2, which is called by f3.
r2 = f3(1)

sprintf("r2 = %9.4f",r2)

################################################################################
###
###    We can also define a function INSIDE another function. In this case the function 
###    defined inside is NOT visbible outside the environment of the parent
###    function.
#################################################################################

g <- function(x,y)  # we can have multiple formal parameters
{ # begin function g
  g.inside <- function(a)
  { # begin g.inside
      b = c(1,2,3)    # create a local variable
      return(a*b)     # we can return a vector
  } # end g.inside

  #####   main code for g ################

  #### check input parameters
 
  if ( !is.numeric(x) )
     { stop("first parameter to g is not numeric") 
  } else {
     n = length(x)
     if ( n != 1 ) { stop("length of parameters must be 1") }
  }

  if ( !is.numeric(y) )
     { stop("second parameter to g is not numeric") 
  } else {
     n = length(y)
     if ( n != 1 ) { stop("length of parameters must be 1") }
  }

  m    = max(x,y) 
  temp = g.inside(m)+ c(0,1,-1)

  return(temp)
} ## end function g

  
x = 4
y = 3
g(y,x)   #### The first actual arg is y, and second actual arg is x

g(x,y)

g(0,1)

g.inside(4)   #### cannot be found

g(c(6,7),9)

######  A possbilbly useful function (except for the bug)

max.2 <- function(x)
{ # begin function max.2

   if ( !is.vector(x) )  { stop("parameter must be a vector") }
   if ( !is.numeric(x) ) { stop("parameter must be numeric") }
   if ( length(x) < 2 )  { stop("minimum length of paramter is 2") }

   y = unique(x)         # y is a vector of all unique values in x
                         # (or y is the vector you get when duplicates are removed)
   z = y[ y < max(y) ]   # eliminate all instances of max value of x
   return(max(z))        # a bug is here. What is it?
} # end function max.2

x = c(5,4,7,2,5)
max.2(x)

x = c(3,7,2,9,10,4,10,5,10,9,5,-3)
max.2(x)

#  Find an input vector that makes max.2 not work


#   A function can see variables that exist in the parent (invoking)
#   environment, even if that value is not passed as an argument.

#   As they say in Oceana, this is a double plus ungood feature.

rm(list=ls())

f1 <- function(x1,y1)
  { # begin f1 body

    a = (x1 + y1)^2 # a is local to f1
    b = a + d       # b is local to f1, but d is not an argument
                    # nor has it been created as a local variable for f1
    print("invoking ls() inside f1 body")
    ls()
    print("end of ls() invocation inside f1 body")
    return(b)
  } # end f1 body


u = 3
v = 4
ls()
z = f1(u,v)
ls()
#  You see we run into trouble because d does not exist. Note that z does not exist
#  because f1 aborted.

#  now we create d

d = 10

z = f1(u,v)
ls()
print(z)

#  note the function successfully executed.
#  Also note the print statements execute inside f1, and THEN
#  the output of ls() is printed.
#  You really cannot rely on print statements in R for debugging.

#  But note that inside f1, f1 can see d. Now d was created in the parent environment.
#  This really is a bad thing. If your function relies on d, then it should be passed
#  as an argument.

#  A function should be a blackbox. The arguments are a well defined input interface
#  to the caller (or user or customer) of the function. The return values of the
#  function are the way the function gives its result to the caller.

#  functions see not only the parent environment, but also the grandparent
#  environment, and so on right to the global environment (which is what is created
#  when you start R)


rm(list=ls())

f1 <- function(x1,y1)
  { # begin f1 body

     #####  defintion of f2
     f2 <- function(x2,y2)
       { # begin f2 body
          l2.1 = x2 - y2
          l2.2 = l1.1 + 1           # l1.1 is in the f1 environmnet
          l2.3 = 5 + a              # a is in the grandparent environment
          return(l2.1+l2.2 + l2.3)
       } # end f2 body

     #########

     l1.1  = x1 + y1     # f2 will use l1.1
     l1.2  = f2(l1.1,1)
     print('f1 ls() just before return'); ls()
     return(l1.1 + l1.2)
  } # end f1 body

a = 3
r = f1(4,5)
print(r)
ls()


####   always remember that the NAMES of formal arguments (used when we define
####   the function), and the names of actual arguments (used when we call the function)
####   have no relationship to each other.

rm(list=ls())

f <- function(x,y)
  { # body of f

     return(x - y)
   } # body of f

x = 9
y = 5

print(f(x,y))

print(f(y,x))

print(f(4,1))

u = 4.5
v = 1

print(f(u,u))
print(f(u,x))

####   To see why the results are what they are:
#     evaluste the first argument and the second argument.
#     f refers to the first argument with the name "x", and the
#      second argument with the name "y". But when f executes it
#     is in its own environment. It does not care what the caller
#     used as the NAME of the first and second argument. It only
#     cares about the VALUE of the arguments.
#     It then executes the body of the code for f, and the value
#     passed to each argument is used to execute the function body.

#     As we saw in an early example, the function body can change the
#     value of the argument inside the function f, but this has no effect on
#     the arguments that exist in the caller's environment.

#     Think of it this way. When the caller used the arguemts f(y,x) then
#     y from the casller's environment (which has value 5) is copied to a location
#     where the function f will find its first argument. See, the argument itself
#     cannot be accessed by f, only a COPY of the first argument is accessed by f. The
#     same thing happens for the second argument.

#     So when we do f(<arg 1>,<arg 2>), where <arg 1> and <arg 2> stand for any
#     argument, this is what happens.

#     <arg 1> and <arg 2> must be accessible by the calling environment. A copy of the
#     argument values is stored in a particular location that the function f will look
#     for the first and seconf argument.
#     Then CPU will start execting the body of the code associated with function f.
#     f will just grab its arguemts when it needs them (so if a statement in the body
#     of function f refers to x (the first argument of f), it looks in the location
#     it knows the caller is supposed to put the value of the first argument. Since
#     the caller put the value of <arg 1> in that location, everuthing is fine.
#     The function f does not care what name the caller used, it just wants to access
#     the value of <arg 1>. The function f can access this value, but it does not
#     know the name used by the caller of the function. It does not need to know the
#     name. it just needs the value.
#     Therefore, if the function f changes the value of the first argument, it just
#     changes the value stored in the memory location where the caller stored a COPY
#     of the actual argument.

#    Example (note that this simplifies what actually goes on, but the fine
#        details of what actually happens would take us far afield):

#    Suppose the caller has an environment where x has value 9, and is stored at memory
#    location 100, and y has value 5, and is stored at memory location 138.
#    Now the caller invokes f with
#
#    r = f(y,x)

#    Now suppose f expects the first argument to be put in memory location 1000,
#    and the second argument to be put into memory location 1001.
#   Then R sees that the first actual argument is y, and it knows the location of
#   y is memory location 138. It goes to memory location 138, and copies that value
#   to memory location 1000. It then sees the second argument is x, and it knows x is
#   at memory location 100. It goes to memory location 100, and copies the value to
#   memory location 1001. It then calls (gives control to) the function f. One other
#   thing to note is the caller has to know where f will place the return value.
#   Now f starts executing. The statement it executes is
#
#   return(x-y). 
#   So f knows it must go to memory location 1000 to get the value of x (the frist argument),
#   and it must go to memory location 1001 to get the second argument. It then performs
#   the indicated subtration. It places the result of the subtration in the memory location
#   expected by the caller. Then the function f returns control to the caller.

#   The caller grabs the returned value and copies the returned value to a location in
#   memory that the caller has designeted to have the name "r".

#   The function f does not care if the caller is in the global environment (the one that
#   is created when R starts a session), or if the caller is an an environment associated
#   with any other function.

#   When the function f is in control, it has its own environment. In that environment,
#   all refences to x refer to location 1000 (the location f expects the first argument
#   to be). And y refers to memory location 1001. In more complicated functions local
#   variables might be created (e.g.   a = x^2 + y). If a local variable is created, then
#   some memory location is reserved for that local variable.

#   When the called function returns to the caller, not only does the called function
#   place the return value in the specified location, but it also deallocates the
#   memory used for local variables. So when the caller resumes control, it cannot
#   access the local variables created by the called function.

#   As I said, this is a simplification of what really happens, but remember that when
#   you first learn physics you do not start with quantum mechanics or general relativity.
#   And indeed, few who start to learn physics ever get there.

#   Details of the mechanism by which functions are called and return to the caller
#   differ from one comouter system to another. But you should know it is a bit
#   complicated, and the overhead of a function call can be more time-consuming than
#   the execution of the function code.




