library(dplyr)
library(shiny)

record <- function(use, input){
  #Uses a csv file that reflects current data
  use <- use %>% group_by(player_fifa_api_id) %>% top_n(n=1, wt = date)
  
  #best player with complete relevent information at hand
  use <- use %>% select_("player_name", input)
  # this is a bit hacky, but it was necessary since regular filter statements weren't working (even with non-standard eval). 
  # The columns had to be renamed in order to be referenced
  use <- subset(use, select = -player_fifa_api_id)
  colnames(use) <- c('name', 'var')
  best <- use %>% top_n(n=1, wt=var)

  #worst player with complete relevent information at hand
  worst <- use %>% arrange(var) %>% head(1)
  
  ret <- paste0("The best ", input, " player was: ", best$name, " while the worst was: ", worst$name, ". ")
  
  return(ret)
}