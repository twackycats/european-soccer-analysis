library(dplyr)
library(shiny)

record <- function(use, input){
  #Uses a csv file that reflects current data
  use <- use %>% arrange(desc(date))
  use <- na.omit(use)
  use <- subset(use, !duplicated(use[,4]))
  
  #best player with complete relevent information at hand
  best <- use %>% filter(input==max(input))
  #worst player with complete relevent information at hand
  worst <- use %>% filter(input==min(input))
  
  merged <- data.frame(best)
  merged[2,] <-worst
  
  ret <- paste0("The best ", input, "player was: ", merged[1,4], " while the worst was: ", merged[2,4])
  
  return(ret)
}