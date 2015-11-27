#Navdeep Gill
#Assignment 5

#1
#Write a function to find out if points are inside a circle. The function prototype is 
#inside.circle <- function( center, radius, p). Here center is a vector of length 2, which contain the 
#coordinates of the center of the circle. The radius argument is a number which gives the radius. 
#The p argument is a matrix of n rows and 2 columns. The p matrix contains the coordinates of n 
#separate points. The function returns the row numbers of p for all points of p that are inside the 
#circle. The function also generates a plot containing the circle, and all the points of p. Those 
#points of p inside the circle are printed in red, and those points of p outside the circle are 
#printed in blue.

inside.circle = function(center, radius, p)
{#Begin Function
  
  #Error Checks
  
  if ((length(center)) !=2) 
  {stop ("First argument must be a vector of length two.")}
 
  if ( radius<=0 )
  {stop ("Second argument is not a positive number. Radius must be positive.")}

  if ( (length(radius)) !=1 )
  {stop ("Second argument must contain only 1 element.") }
  
  #Create lengths for later use.
  p.1 = length(p[,1])
  x.coord = numeric(p.1)
  y.coord = numeric(p.1)
  
  #Below will calculate the distance using the distance formula and check if it is within the circle. 
  #It will iterate through p[i,1] and p[i,2] and check the distance across these points and evaluate via
  # the if() statement.If the if() is true, x.coord and y.coord will take on those points and they will 
  #represent the points in the circle. 
  
  for (i in 1:p.1)
  {#for
    #In an x-y Cartesian coordinate system, the circle with centre coordinates (a, b) and radius r is the set 
    #of all points (x, y) such that:
    if ((p[i,1] - center[1])^2 + (p[i,2] - center[2])^2 <= radius^2)
    {#if
      #Allocatio of points in circle.
      x.coord[i] = p[i,1]
      y.coord[i] = p[i,2]
    }#if
  }#for
  
  
  #Get valid values and cbind to get vector of points in circle.
  x.coord = x.coord[x.coord != 0]
  y.coord = y.coord[y.coord != 0]
  coordinates = cbind(x.coord,y.coord)
  
  #Get plot values and the parameters for the equation of a circle.
  theta = seq(0,2*pi,length = 2000)
  a = center[1]
  b = center[2]
  x = a + (radius*cos(theta))
  y = b + (radius*sin(theta))
  
  #Plot cirlce and add points 
  plot(x,y, type = 'l', xlim = c(0,max(p[,1])), ylim = c(0,max(p[,2])), main = "Plot of circle with given parameters", ylab = "Y", xlab = "X")
  points(p[,1], p[,2], col = "blue")
  
  #The points inside the cirlce are red.
  points(x.coord,y.coord, col = "red")
  
  return(coordinates)
  
}#End Function

#2
#Write a function that looks at all the files in the current working directory. The user provides a 
#character string giving an extension. The function will return the number of bytes used by all 
#files with the extension given by the user. The function prototype is 

ext.size <-function(suffix)
{#Begin Function
  
  #Error Checks
  
  if ( is.numeric(suffix) ) { stop("parameter must be string") }
  
  #Get working directory
  WD <- getwd()
  
  #Make a list of all files in working directory
  directory <- list.files(WD)
  
  #Change value input
  foo<-substitute(suffix)
  
  #Add $ to end of argument for valid search
  suf<-paste(foo,"$",sep="")
  
  #Use grep to get a hold of relevant files based on what is inputted as "suffix".
  location <-grep(suf,directory,val=TRUE)
  
  #Obtain file info
  info<-file.info(location)
  
  #Get total byte size
  total.bytes = sum(info$size)
  
  #Return byte size
  return(total.bytes)
  
}#End Function

#3. Write a function that searches all files in the current directory and returns a vector 
#with the names of all files that are dated AFTER a user specified date (which consists of 
#a year, month, and day, which are all numeric). The user can also specify whether the mtime, 
#ctime, or atime should be used. The default is mtime. Use "m" to specify mtime, "c" to specify ctime, 
#and "a" to specify atime. The function prototype is:
#files.after <-function(year,month,day,time.type = "m").

files.after <- function(year,month,day,time.type="m")
{#Begin Function
  
  #Error Checks
  
  if(!is.numeric(year)){stop("Year input must be numeric")}
  if(!is.numeric(month)){stop("Year input must be numeric")}
  if(!is.numeric(day)){stop("Year input must be numeric")}
  if((month > 12 | month < 1)){stop("Month must fall between 1-12")}
  if((day > 31 | day < 1)){stop("Day must fall between 1-31")}
  if(!(time.type == "m" || time.type == "c" || time.type == "a")){stop("Time type must
                                                                       equal m,c, or a")}
  
  #This code will take the input and  make it the same format as the dates in mtime,atime, and ctime.
  #However, note that mtime,atime, and ctime have a time stamp at the end. Since the input does not have
  #a time stamp, we need to get rid of it.
  new.date<-as.Date( paste( year , month ,day, sep = "." )  , format = "%Y.%m.%d" )
  
  #Making a numeric will make it into seconds compared to a reference in R. R references
  #1/1/1970. We can compare the number calculated below to the number that will be eventually calcuated 
  #in the same fashion for mtime, atime, or ctime. If one of the numbers is larger than what is inputted, 
  #then it is after the date. 
  compare.date<-as.numeric(new.date)
  
  #Get working directory
  WD <- getwd()
  
  #Make a list of all files in working directory
  directory <- list.files(WD,full.name=TRUE)
  
  #Get info
  info <- file.info(directory)
  
  #Get date field and omit NA
  date.m<-na.omit(c(info$mtime))
  date.a<-na.omit(c(info$atime))
  date.c<-na.omit(c(info$ctime))

  #Convert date fields to numeric
  num.date.m <- as.numeric(as.Date(date.m))
  num.date.a <- as.numeric(as.Date(date.a))
  num.date.c <- as.numeric(as.Date(date.c))
  
  #Only need one allocation vector since they will all be the same length. 
  a<-numeric(length(num.date.m))

  if(time.type=="m")
  {#if
    
    for(i in 1:length(num.date.m))
    {#for
      a[i] <- num.date.m[i]>compare.date
    }#for
    
  }#if
  
  else if(time.type=="a")
  {#elseif
    
    for(i in 1:length(num.date.a))
    {#for
      a[i] <- num.date.a[i]>compare.date
    }#for
    
  }#elseif
  
  else if(time.type=="c")
  {#elseif
    
    for(i in 1:length(num.date.c))
    {#for
      a[i] <- num.date.c[i]>compare.date
    }#for
    
  }#elseif
  
  #a will be a vector of 0's or 1's since we are doing a comparison. Now,
  #we have to revert back to directory and get the valid file names.Note, when a=1, then 
  #the date is after.
  vec.dir <-numeric(length(directory))
  for(i in 1:length(a))
  {#for
        if(a[i]==1)
        {#if
        vec.dir[i] <- directory[i]
        }#if

  }#for
  vec.dir = vec.dir[vec.dir!=0]
  
  return(vec.dir)
}