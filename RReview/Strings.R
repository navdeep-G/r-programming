##########################################
#
#     String Processing
#
##########################################

####   ascii table

###############  this shows the "alphabetical" order of single characters
" " < "1"
"+" > "0"
"3" < "a"
"B" < "a"
" " < "a"
" dream" < "a"
"a" < "A"


####################### nchar
s = c("abc d")
# nchar gives the number of characters
nchar(s)
# length gives the number of elements in the vector s
length(s)
is.vector(s)

t = c("a","bc","Chicago")
n = nchar(t)
print(n)
is.vector(n)
length(t)

# grep is for finding regular expressions
grep("[A-Z]",t)

r = c("a_B_3","quick","mouse","4","lm","mmm")
grep("[0-9]",r)
sub("m","M",r)    # substitute "M" for "m" (only first m changes in each vector element)
                  # Note that "mmm" becomes "Mmm"
gsub("m","M",r)   # change all m's
                  $ See the difference between sub and gsub?
toupper(r)        # change lower case to upper case
                  # there is also a tolower() function

###  character translation

print(r)
chartr("m","Z",r) # character translation
chartr("A-Z","a-z",r) # change to lower case
x = c("abc txt")
chartr(" ",".",x)

x = c("f1.docx","f1.dat","f2.txt","f3.csv","f3.pdf","f4.extra.dat")


#  split a string using a regular expression
strsplit(x, split='[0-9]')

#  fixed = TRUE means use a literal for the split
suff = strsplit(x,split=".",fixed=TRUE)
suff

v = c("a = b + c")
strsplit(v, split = "[=,+]")

####   find all the .dat files
n = length(suff)
for ( i in 1:n )
  {
    last = length(suff[[i]]) #account for possibility of multiple dots(.)
    if ( suff[[i]][last] == 'dat' )
      {
         print(x[i]) # we could process the file
      }
  }

x = c("it is getting late")
words = strsplit(x,split=" ",fixed=TRUE)
is.list(words)
words
num.words = length(unlist(words))  # gives a word count
print(num.words)
w = unlist(words)
caps=""
for ( i in 1:num.words)
  {
    w[i] = paste(toupper(substr(w[i],1,1)),substr(w[i],2,nchar(w[i])))

    w[i] = sub(" ","",w[i])
    caps = paste(caps,w[i])
  }
caps

##  in a regular expression ^ denotes beginning of string
caps = sub("^ ","",caps) # remove leading space
caps
####
count.spaces = 0
temp = x
while ( length(grep(" ",temp)) != 0 )
  {
     temp = sub(" ","",temp) # remove space
     count.spaces = count.spaces + 1
  }
    
count.spaces
temp

########  convert character to number

num = "236.89"

num.split = strsplit(num, split = ".", fixed = TRUE)
str(num.split)

if ( length(num.split[[1]]) > 2 ) { print("error.\n") }


left = num.split[[1]][1]
right = num.split[[1]][2]

dig.check = grep("[^0-9]",left)
if ( length(dig.check) > 0 ) { cat("Non digit character found.\n") }


dig.check = grep("[^0-9]",right)
if ( length(dig.check) > 0 ) { cat("Non digit character found.\n") }


m = nchar(left)
int.part = 0
if ( m > 0 )
  { # we have integer part
    for ( i in 1:m )
      {
          new.num = substr(left,i,i)
          new.num = as.integer(new.num)
          int.part = 10*int.part + new.num
      }
  } # we have integer part
int.part


m = nchar(right)
frac.part = 0
if ( m > 0 )
  { # we have integer part
    for ( i in 1:m )
      {
          new.num = substr(right,i,i)
          new.num = as.integer(new.num)
          frac.part = 10*frac.part + new.num
      }
  } # we have integer part
frac.part = frac.part*10^(-m)

(num.num = int.part + frac.part)

######   The previous code was to give you an example of coding
######   In R we can use
num
as.numeric(num)

num = "3.456e-03"
as.numeric(num)


######  If you want to become proficient with string
######  processing you must learn about regular expressions

t = c("remember","rabbit","ore","someday","weekday","daylight")

grep("r",t)

grep("^r",t)    # anchor r at start of string

grep("day",t)

grep("day$",t)  # anchor day at end of string

t = c("123256","2456.7","three","over","Ab","aA","AC","AAA","2222","22 222")

grep("[a-z]",t)
grep("[0-9]",t)


grep(".",t)
grep("e.",t)
grep("32.",t)

grep("\\.",t)   # find literal dot

grep("2*",t)    # not what you might expect

grep("2+",t)   #This is the wildcard. Similar to what you might do in unix. 

grep("2{4}",t)  #Match exactly 4 two's.

grep("[^A]",t)

r = c("wherever","sunny","everywhere","somewhere","screech","bookkeeper","someday",
       "s is the sum")

grep("e{2}",r)    #match ee

grep("e+",r)      # one or more e's

grep("a*o+",r)    # zero or more a's, one or more o's



grep("^s+",r)

grep("^s*",r)

grep("^s+.m",r)   # start with s, any single character, then m

grep("^s+.+m",r)

grep("^s+(..)+m",r) # start with s, at least two characters, then m











