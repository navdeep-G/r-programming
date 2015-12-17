#This function will take in a dataframe and search through columns to see if any have NA's
#and print those column names to the console:

get.na = function(df){
  
  #TODO: Error checking
  
  #Get fields bases on data type (numeric or character):
  df_num <- df[,names(df)[which(sapply(df, is.numeric))], with = FALSE]
  df_char <- df[,names(df)[which(sapply(df, is.character))], with = FALSE]
  
  #Find out which ones have NA's and bind together
  num_na = sapply(df_num, function(x) sum(is.na(x)))
  char_na = sapply(df_char, function(x) sum(is.na(x)))
  all_na = rbind(data.frame(count_na=num_na, type="Numerical"), 
                 data.frame(count_na=char_na, type="Character"))
  
  #Get fields with > 0 NA and print out to console
  all_na = all_na[all_na$count_na>0,]
  cat("The following fields have NA's:\n")
  return(all_na)
}