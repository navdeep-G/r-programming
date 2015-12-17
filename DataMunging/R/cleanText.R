clean.text <- function(x, lowercase=TRUE, numbers=TRUE, punctuation=TRUE, spaces=TRUE)
{
  # x: character string
  
  # lower case
  if (lowercase)
    x = tolower(x)
  # remove numbers
  if (numbers)
    x = gsub("[[:digit:]]", "", x)
  # remove punctuation symbols
  if (punctuation)
    x = gsub("[[:punct:]]", "", x)
  # remove extra white spaces
  if (spaces) {
    x = gsub("[ \t]{2,}", " ", x)
    x = gsub("^\\s+|\\s+$", "", x)
  }
  # return
  x
}
