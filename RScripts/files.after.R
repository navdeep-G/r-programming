#A function that searches all files in the current directory and returns a vector 
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