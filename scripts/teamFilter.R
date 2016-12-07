library(dplyr)
library(shiny)


team <- function(df, filters, outList){
  df <- df %>% arrange(desc(date)) 
  #df <- subset(df, select = -player_fifa_api_id)
  df <- subset(df, !duplicated(df[,4]))
  for(i in colnames(filters)){
    if(!(i %in% outList)){
      print
      df <- df %>% filter(eval(parse(text=i))==eval(parse(text=paste0("filters$", i))))
    }
  }
  
  return(df$team_long_name)
}
