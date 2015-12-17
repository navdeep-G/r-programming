#This function will look for columns with constant values and remove as they provide no variability in model building
get.const.val = function(df){
  
  #TODO: Error checking
  
  col_ct <- sapply(df, function(x) length(unique(x)))
  colCnt.df <- data.frame(colName = names(df), colCount = col_ct)
  cat("\nNumber of columns with constant values: ",sum(col_ct==1))
  cat("\nName of constant columns: ", names(df)[which(col_ct==1)])
  
  cat("\n\nRemoving the constant fields from dataframe....")
  df <- df[, names(df)[which(col_ct == 1)] := NULL, with = FALSE]
  cat("\ndf dimensions: ", dim(df))
  
  #Print out numeric and character columns
  df_num <- df[,names(df)[which(sapply(df, is.numeric))], with = FALSE]
  df_char <- df[,names(df)[which(sapply(df, is.character))], with = FALSE]
  cat("Numerical column count : ", dim(df_num)[2], 
      "; Character column count : ", dim(df_char)[2])
}
