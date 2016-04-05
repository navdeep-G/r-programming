library(pryr)

mypid = Sys.getpid()
proc_stat_name = paste0("/proc/", as.character(mypid), "/stat")

get_rss_mb <- function() {
  rssdf <- read.table(proc_stat_name)
  rss_mb <- rssdf$V24 / 1024 * 4096
  rm(rssdf)
  return(rss_mb)
}

X <- function(i, category = "general", subcategory = "") {
  rss_mb <- get_rss_mb()
  gc()
  m <- mem_used()
  delta <- m - X.last
  delta_rss_mb <- rss_mb - X.last_rss_mb
  X.last_rss_mb <<- rss_mb
  X.last <<- m
  cat(sprintf("MEM TRACE: %d,%d,%s,%s,%s,%s,%d,%d\n",
              X.iter, i, category, subcategory,
              as.character(m), as.character(delta),
              rss_mb, delta_rss_mb))
}