#This function will take in a date field and extract out the month, day, and year & then remove the date column if specified.
#Date fields contain rich information and they must be extracted for modern machine learning exercises. 

get.date.feat = function(df, date.field, remove.date = F){
  
  #TODO: Error Checking
  #TODO: How will this handle data.table frames?
  
  #Extract month,day and year from date field
  df[,date.field] = as.Date(df[,date.field])
  df$Date = format(df[,date.field], "%d")
  df$Month = format(df[,date.field], "%m")
  df$Year = format(df[,date.field], "%Y")
  df$Day = weekdays(df[,date.field])
  
  #Removing the unnecessary original quote date if specified
  if(remove.date == T){
    df[,date.field] = NULL
  }else{
    df[,date.field] = df[,date.field]
  }

}
