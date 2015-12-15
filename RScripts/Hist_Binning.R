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