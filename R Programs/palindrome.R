###  Code for Checking Numerical Palindromes.
num.string.rev <- function(x)
{
    paste(substring(x, nchar(x):1, nchar(x):1),
          collapse = "")
}

get.digits <- function(n)
{
    as.numeric(num.string.rev(as.numeric(n)))
}

is.palindrome <- function(n)
{
    n[1] == get.digits(n[1])
}
is.palindrome(123)
is.palindrome(121)
  