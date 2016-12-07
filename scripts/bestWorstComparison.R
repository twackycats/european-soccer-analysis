library(dplyr)
library(shiny)

record <- function(use, input){
  #Uses a csv file that reflects current data
  use <- use %>% group_by(player_fifa_api_id) %>% top_n(n=1, wt = date)
  
  #best player with complete relevent information at hand
  use <- use %>% select_("player_name", input)
  use <- subset(use, select = -player_fifa_api_id)
  colnames(use) <- c('name', 'var')
  best <- use %>% top_n(n=1, wt=var)

  #worst player with complete relevent information at hand
  worst <- use %>% arrange(var) %>% head(1)
  
  ret <- paste0("The best ", input, " player was: ", best$name, " while the worst was: ", worst$name, ". ")
  
  return(ret)
}