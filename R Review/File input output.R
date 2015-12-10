#####################################################
#
#     File I/O
#
######################################################

getwd() # returns the current working directory

#   when performing file I/O you can give a complete pathname
#   for the file you are reading from (or writing to).
#
#   Or you can specify the pathname relative to the current directory.

#   You can obtain file information

#   below are the arguments to 3 useful functions
if (0)
{ # start "comment" 
list.files(path = ".", pattern = NULL, all.files = FALSE,
           full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = FALSE)

dir(path = ".", pattern = NULL, all.files = FALSE,
           full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = FALSE)

list.dirs(path = ".", full.names = TRUE, recursive = TRUE)
} # end "comment"

# list.files() and dir() give the same information.
# Note the default path is "." This indicates file information
# is gathered with respect to the current working directory.
# If you specify a full pathname, you can obtain information
# with respect to another directory.
#
# Suppose you have a directory named Project1 in the current 
# working directory, and you want to obtain information on files
# in that directory.
# Use
# list.files(path = "Project1")
#
# You can use pattern to filter the files you want to list.
# pattern = <regular expression>
# list.files(pattern = "*.txt")
# This will list all files with names ending in ".txt"

# recursive = TRUE will list all files in the current directory
# and in any directory below the current directory.

# file.info provides information on files
# file.info("<filename>") gives information on the specified file
# file.info("proj1.txt","proj2.txt") gives information on both files
# file.info(dir()) gives information on all files in the current directory

# information returned is
# size     in bytes
# isdir    a logical value which is TRUE if it is a directory
# mode     octal representation of permissions similar to unix
# mtile    modification time
# ctime    creation time
# atime    last access time
# exe      a logical value which is true if the file is executable

# You could parse these times with string commands, and process only
# files that were created since a certain date if you like.
# The date is in POSIX format, so you need to do something like

# a = file.info("file.txt")
# ctime = strsplit(as.character(a$ctime),split = "-",fixed = TRUE)
# This will split out the year and month
# You need to do another strsplit() to get the day of the month
# and the hour, minute and second
# you can also use setwd() to set the working directory.
# setwd(<complete path name>)  you can specify a complete pathname
# setwd("..") will move the working directory up one level in the directory
#             hierarchy
# setwd("Porject1") will move the working directory down one level
#                   this assumes Project1 is a directory contained in
#                   the durrent working directory
# setwd("../Data")  will go up one level and then go down one level
#                   this assumes Data is a directory in the parent directory
#                   that contains the working directory


# if you run R interacxtively you can conveniently change the working 
# directory with


# setwd(choose.dir())

# This will cause a window to pop up which you can navigate to the
# desired directory.

#           Other file utilities

# file.rename(from,to)
example(file.rename)    # see an example
# file.remove()
example(file.remove)
# file.append(fil1,file2) # try to append file2 to file 1
# file.copy(from,to, overwrite = recursive, recursive = FALSE, copy.mode = TRUE)
#   use recursive = TRUE if you want to copy all files below
example(file.copy)
# Note that by default cat() will print a string to the R console
# But if you use cat("some string",file = <filename>) the output
# of cat will be put into the file.

# file.show("<filename>") will cause an R "informnation window" to pop up
#                         and displays the file there

# dir.create() to create a directory
# file.exists()  does the file exist?
# file.access("<filename>", mode = 0)  
#       mode   0     does file exist?
#              1     what is the execute permission?
#              2     what is the write permission?
#              4     what is the read permission?

#   You can also construct a vector containing several filenames
#   and call file utility functions with that vector instead of a
#   single filename.

# to save data in the R environment to a disk file use
# write.table() or write.csv()

d = c(3.4,5,7.8,12.3,-4.5,5.6)
write.csv(d,file="d1.csv")
# d1.csv can be opened in Excel

d.in = read.csv(file = "d1.csv")
str(d.in)
# note d.in is a data frame


# If you save an Excel spreadsheet as a .csv file, you can read that
# .csv file into R using read.csv

x1 = rnorm(50)
wt = runif(50)
x3 = rexp(50)
x4 = rnorm(50)
m  = cbind(x1,wt,x3,x4)

write.table(m,file = 'tempdata.dat')

dir()
m.in = read.table(file = 'tempdata.dat')
str(m.in)
head(m.in)

####  note the header is in the file

write.table(m,file = 'temp.noheader.dat',col.names = FALSE, row.names = FALSE)

m.nohead = read.table(file = 'temp.noheader.dat')
str(m.nohead)
head(m.nohead)

# Note the old column names are lost. R then adds its own column names V1, V2, etc.
dir()
# rename a file
file.rename(from = "temp.noheader.dat", to = "temp2.dat")
dir()
# now remove the file
file.remove("temp2.dat")
dir()


#
#    For interactive sessions, when reading a file we can use file.choose()
#    instead of a filename. This causes a dialog box to appear. You can navigate
#    the file directory structure and select the desired file.

# Another way to delete a file or directory is the unlink() function
# unlink(x, recursive = FALSE, force = FALSE)
# x is the name of a file or directory
# if recursive equals TRUE, then everything beneath x is deleted
# if force = TRUE, R will change permissions if possible and delete
# a file which does not have write permission set

# see section 10.1 of the text for use of the scan() function
# here we see scan() documentation
?scan


##   writing and reading  binary files

x = rnorm(1000)

fn = file("db.dat",open = 'wb')
if ( isOpen(fn) )
  {
     writeBin(x, con = fn)
   }
close(con = fn, type = 'wb')

write.csv(x,file="d2.csv")

###   We have written 1000 doubles to disk in two different ways:
####  a binary file, and a csv file
####  What are the respective sizes, in bytes?
file.info("db.dat")
file.info("d2.csv")

x.csv = read.csv(file = "d2.csv")
str(x.csv)
d = x - x.csv$x
max(abs(d))      # interesting


fn = file("db.dat",open = 'rb')

# if the file does not exist, or if we specified an incroeect path
# or if getwd() gives us a directory different from the directory
# in which the file resides we could have an error opening the file.
# Use isOpen() to make sure the file has been successfully opened.
if ( isOpen(fn) )
  {
     x.b = readBin(con = fn, what = 'double', n = 1000)
     close(con = fn, type = 'rb')
   }
else
   {
      cat("File did not open\n")
   }


####  If you do not know the size of your file, you can read in
####  one value at a time. The value for what specifies if the binary data should
####  be interpreted as "double" or "integer" or "complex", or another
####  choice.
str(x.b)
is.vector(x.b)
d.b = x - x.b
max(abs(d.b))

##  If you send a binary file from one computer to another, you must beware
##  of the "endian" of each computer system. Is it "little endian" or "big endian"?

.Platform    # $endian gives endian
             # $OS.type gives the operating system
             # $r_arch  gives the architecture (instruction set)


###### Suppose we set n larger than 1000


fn = file("db.dat",open = 'rb')
if ( isOpen(fn) )
  {
     x2.b = readBin(con = fn, what = 'double', n = 2000)
   }
close(con = fn, type = 'rb')
length(x2.b)
head(x2.b)
head(x)


##   Now we read in the file one double each readBin()
##   This will be much slower
x3.b = numeric(10000)
fn = file("db.dat",open = 'rb')
if ( isOpen(fn) )
  { 
     i = 1
     notEOF = TRUE 
     while( notEOF )
       {
          temp = readBin(con = fn, what = 'double', n = 1)
          if (length(temp) == 0 )
            {
               notEOF = FALSE
            }
          else
            {
               x3.b[i] = temp
               i       = i + 1
            }
        } # while notEOF
   } # if isOpen
close(con = fn, type = 'rb')
x3.b = x3.b[1:(i-1)]  # i incremented 1 too many
length(x3.b)

if ( !isOpen(fn) ) { cat("fn is not open\n") }

# We can determine the size of the file

fn.size = file.info("db.dat")$size
print(fn.size)
num.doubles = fn.size/8
print(num.doubles)
# Hence we know the number of data points (doulbes)
# We could use this to determine the size of n in readBin

# If your file is really large, you may want to read the file in
# chunks of size 100,000 or 1,000,000. If you can do your necessary
# computations having only one chunk in memory at any given time,
# you can process a large file in R.



