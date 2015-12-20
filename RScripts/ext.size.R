#A function that looks at all the files in the current working directory 
#and returns the number of bytes used by all 
#files with the extension given by the user.
#The user provides a character string giving an extension. 

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
