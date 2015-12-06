####################################
#
#     Elementary Plotting
#
####################################



v = runif(12) # create  vector to plot
u = rnorm(14) 

plot(v)

plot(u)

#### Notice the second plot overwrote the first plot

#### Use dev.new() before the plot command in order to keep the old plot

#          Note the different size of the points
#          The cex parameter gives the magnification parameter
#          relative to the default
dev.new()
plot(v, cex = 2.4)
dev.new()
plot(u, cex = 0.4)

######  Note that cex can be used to affect the size of the point

######   To make a better plot

#   main    gives a title to the plot
#   sub     gives a secondary title to the plot (appears at bottom of plot)
#   xlab    gives a label for the x-axis
#   ylab    ditto for the y axis
#   xlim    a vector that sets the limits plotted on the x-axis
#   ylim    ditto
#   type    lines or points are the most common. points is the default
#           Use ?plot to see other values for type

#            type = 'l'  gives a line
#            type = 'p'  gives a point (this is the default)
#            type = 'l'  gives a line
#            type = 'o'  gives points and lines
#            type =  h   gives a vertical line from x axis to the data point
#            type = 's'  gives stait steps
#            type = 'n'  gives nothing
#           
#   lty     Can be used for lines
#   pch     can be used for points
#   col     use different colors

x = 1:12
y = x^2 - 3
dev.new()
plot(x,y, main = "Quadratic function", sub = 'Experiment 1', 
     xlab = "Hours",
     ylab = "Concentration (g/cc)")

###  We can choose colors for various pieces of the graph

dev.new()
plot(x,y, main = "Quadratic function", sub = 'Experiment 1', 
     xlab = "Hours",
     ylab = "Concentration (g/cc)",
     type = 'o',
     col.lab = 'red',
     col.main = 'blue',
     col.axis = 'green',
     col = 'brown',
     cex.lab = 1.5,       # control size of xlab,ylab
     col.sub = 'yellow')

#             type = 'h'
dev.new()
plot(x,y, main = "Quadratic function", sub = 'Experiment 1', 
     xlab = "Hours",
     ylab = "Concentration (g/cc)",
     type = 'h')

# type = 's'
dev.new()
plot(x,y, main = "Quadratic function", sub = 'Experiment 1', 
     xlab = "Hours",
     ylab = "Concentration (g/cc)",
     type = 's')





##   To save your file for inclusion in a document, bring the mouse
##   over the plot and right-click the mouse and you can save the plot
##   in a variety of formats, and later insert into your document

##  you can also do

#   pdf('plot1.pdf')
#
#   enter plot commands here
#  dev.off()

dev.new();plot(x,y, main = "Quadratic function", 
               xlab = "Hours",
               ylab = "Concentration (g/cc)",
               type = "l")
grid()                      ## we can add a grid


dev.new();plot(x,y, main = "Quadratic function", 
               xlab = "Hours",
               ylab = "Concentration (g/cc)",
               type = "b")   # both points and lines

dev.new();plot(x,y, main = "Quadratic function", 
               xlab = "Hours",
               ylab = "Concentration (g/cc)",
               type = "l",
               col = 'blue')   ## note we can use ' or "
## now we add points
points(x,y, col = "red")

###  notice the points are placed on the previously active graph
###  this feature allows us to plot multiple funcions or data sets
###  on one plot


dev.new();plot(x,y, main = "Quadratic function", 
               xlab = "Hours",
               ylab = "Concentration (g/cc)",
               xlim = c(4,9) )   # use xlim

##### Another example

x1 = 1:20
y1 = runif(20,-5,10)

x2 = 1:30
y2 = rnorm(30)

##   You can clculate what the limits should be
##   In this exmple we want to plot two sets of points
##   so we take the union of these points to calculate 
##   our limits
total.x = c(x1,x2)
total.y = c(y1,y2)
x.axis = c( min(total.x) - 1, max(total.x) + 1)
y.axis = c( min(total.y) - 1, max(total.y) + 1)

dev.new();plot(x1,y1,
               xlim = x.axis, ylim = y.axis,
               xlab = "Number of Fish",
               ylab = "Number of Goats",
               main = "Group 1 (Red) Group 2 (Blue)",
               col = "red")

points(x2,y2, col = 'blue')

### we can also put lines through the points
lines(x1,y1)
lines(x2,y2)

abline(v = 8.3, col = "green") # add vertical line
abline(h = 0, col = "brown")   # add horizontal line

abline(-2,3)    # add straight line with intercept -2 and slope 3
# This is useful to fit a regression line on to your data

#####   If points are permuted...

x = c(4,7,9,11,3,6,2,-1,7)
y = x^2
dev.new(); plot(x,y,type = 'l')

###############################  experiment with lty
###                              no need to look it up
####                             I don't know how many there are,
####                             but we can find out
x.axis = 1:20
y.axis = 1:20
x      = 1:20
dev.new();plot(x,x, main = 'lty values')
for (i in 1:20) { lines(x,x+i, lty = i) }

############################# repeat for pch
dev.new();plot(x,x, type = "l", main = 'pch values')
for (i in 1:15) { points(x,x+i, pch = i) }

####  to see available colors

colors()

#  You can use a number ( col =652) or characters (col = 'yellow')

####  Graph a circle

theta = seq(0,2*pi,length = 2000)
x     = cos(theta)
y     = sin(theta)

dev.new()
plot(x,y)

dev.new(); plot(x,y, type = 'l')

dev.new(); plot(x+2,y-3,type = 'l', xlim = c(-10,10), ylim = c(-10,10))

lines(3*x+5,3*y, col = 'red')
lines(4*x,4*y, col = 'blue')
abline( h = 0)
abline( v = 0)

###### Lets have some action
dev.new();plot(x[1],y[1], xlim = c(-1,1), ylim = c(-1,1), col = 'red')
for ( i in 2:2000 ) 
{ plot(x[i],y[i], xlim = c(-1,1), ylim = c(-1,1), col = 'red')}


x.b = c(0,1,1,0)
y.b = c(0,0,1,1)
box = rbind(x.b,y.b)

theta = pi/200
r   = matrix(c(cos(theta),sin(theta),-sin(theta),cos(theta)),2,2)

dev.new();plot(c(box[1,],box[1,1]),c(box[2,],box[2,1]), type = 'l', 
               col = 'blue', xlim = c(-2,2),ylim = c(-2,2))
b = box

for ( i in 1:400 )
{
  b = r %*% b
  plot(c(b[1,],b[1,1]),c(b[2,],b[2,1]), type = 'l', 
       col = 'blue', xlim = c(-2,2),ylim = c(-2,2))
}

####################################################
#
#    eject a ball with a given velocity and angle,
#    will it go over a fence of a given height located
#    a given distance from the ball?

throw <-function(v,theta)
{
  v.y   = v*sin(theta)
  v.x   = v*cos(theta)
  g     = 32   # units are feet
  t     = seq(0,2*v.y/g,length = 100)
  
  y     = v.y*t - (0.5*g)*t^2
  x     = v.x*t
  return(cbind(x,y))
}
over.the.fence <- function(v,theta,dist,ht)
{ # begin over.the.fence
  if ( theta > pi/2 ) { stop("theta must be less than pi/2") }
  fence  = cbind( c(dist,dist), c(0,ht) )
  traj   = throw(v,theta)
  x.span = c(traj[,1],dist+2)
  x.lim  = c(0, max(x.span))
  y.span = c(traj[,2],ht+2)
  y.lim  = c(0, max(y.span))
  
  ###  find out how high the ball is when its horizontal distance puts it at the fence
  ###  If it hits the ground before getting to the fence its height will be negative
  time.to.fence = dist/(v*cos(theta))
  ht.at.fence   = v*sin(theta)*time.to.fence - 16*time.to.fence^2 # 16 = g/2
  over = FALSE  # assume false
  if ( ht.at.fence >= ht )
  {
    over = TRUE
  }
  
  dev.new()
  plot(fence[,1],fence[,2], col = 'blue',type = 'l',
       xlab = 'ft', ylab = 'ft', 
       xlim = x.lim, ylim = y.lim)
  m = length(traj[,1])
  if ( over == TRUE )
  { # makes it over
    for ( i in 1:m )
    {
      points(traj[i,1],traj[i,2], col = 'red')
      slow = sort(rnorm(125000)) # slow down the plot. we need to build suspense
    }
  } # makes it over
  else
  { # doesn't make it over
    for ( i in 1:m )
    { # for i
      if ( traj[i,1] >= dist)
      { # x dist is at or beyond fence 
        text(traj[i,1],traj[i,2],"Boom")    
        break; # we hit the fence 
      } # x dist is beyond fence 
      points(traj[i,1],traj[i,2], col = 'red')
      slow = sort(rnorm(125000)) # slow down the plot. we need to build suspense 
    } # for i    
  } # doesn't make it over 
} # end over the fence


over.the.fence(50,pi/3,8,12)

over.the.fence(50,pi/3,60,15)


# to kill all open plots use graphics.off()
# to kill only the currently open plot use dev.off()

dev.off()
dev.off(0
        graphics.off()
        
        
        ###  Two very nice places to go to see R plot capabilities
        
        #  http://www.harding.edu/fmccown/r/
        
        #  Also you can look at the Quick-R website on basic graphics
        
        #  http://www.statmethods.net/graphs/index.html
        
        
        