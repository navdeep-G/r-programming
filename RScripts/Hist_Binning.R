#Input: a numerc data vector called x, and another vector named bounds. The bounds vector is
#numeric, and strictly monotonic. We want to bin the data in vector x based on bounds. This is what you would do if you are creating a histogram.
#Output: a vector named bin.count, which contains the count of how many elements of x are in each bin.
#Example: bounds = c(0,2.5,10). The bins are (-Inf,0),[0,2.5),[2.5,10), and [10,Inf). We return a vector of length 4. The first element of the return vector gives a count of how many x entries are in the interval (-Inf,0), the second element of the return vector gives a count of how many x entries are in the interval [0,2.5), etc. Here “[“ indicates a closed bound and “)” indicates an open bound. Check the input argument for validity. If x = c(-4,10,5,24,12,34), then bin.count should equal c(1,0,1,4)
#Check that bounds is actually strictly monotonic. If it is not, print an error message.
hist <- function(x,bounds)
{
  n = diff(bounds)
  
    if(!(all(n>=0)) || !(all(!n<0)))
    {
      print("Error! Bounds is not strictly monotonic.")
    }
    else if(all(n>=0))
    {
      #Bin vector x by vector bounds
      bounds1<<-append(-Inf,bounds)
      bounds2<<-append(bounds1,Inf)
      bin = cut(x,bounds2,right=FALSE)
      bin.table <<- table(bin)
      bin.count<<- unname(bin.table)
    }
    else if(all(n<0))
    {
      #Bin vector x by vector bounds
      bounds1<<-append(-Inf,bounds)
      bounds2<<-append(bounds1,Inf)
      bin = cut(x,bounds2,right=FALSE)
      bin.table <<- table(bin)
      bin.count<<- unname(bin.table)
    } 
}
