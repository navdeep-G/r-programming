has_factors <- function(x) {
  if (is.data.frame(x) | is.list(x)) {
    factors = unlist(lapply(x, is.factor))
    if (sum(factors) > 0) TRUE else FALSE
  } else FALSE
}