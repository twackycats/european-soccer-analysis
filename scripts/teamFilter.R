library(dplyr)
library(shiny)
library(stringr)

team <- function(df, filters, outList){
  df <- df %>% arrange(desc(date)) 
  #df <- subset(df, select = -player_fifa_api_id)
  df <- subset(df, !duplicated(df[,4]))
  print(colnames(filters))
  for(i in colnames(filters)){
    print("for")
    if(!(i %in% outList) && "All"!=eval(parse(text=paste0("filters$", i)))){
      print("help")
      df <- df %>% filter(i==eval(parse(text=paste0("filters$", i))))
    }
  }
  
  return(df$team_long_name)
}
