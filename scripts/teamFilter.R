library(dplyr)
library(shiny)
library(plotly)

##This file is made by Kevin Tran (nfsrun). 

team <- function(df, choice, first, teamsSelected){
  
  #Removes unneeded columns that are worded
  df[,27] <- NULL
  df[,26] <- NULL
  df[,24] <- NULL
  df[,22] <- NULL
  df[,20] <- NULL
  df[,19] <- NULL
  df[,17] <- NULL
  df[,15] <- NULL
  df[,13] <- NULL
  df[,12] <- NULL
  df[,10] <- NULL
  df[,8] <- NULL
  
  #If the radar button from server is false, it means that the user is requesting a historical 
  #skill change of the team. 
  if(choice==FALSE){
    use2 <- df %>% arrange(date) %>% filter(team_long_name==first)
    #saves dates before it gets eliminated
    dates <- use2$date
    #Removes so it can easily process for the coming for loop
    use2[,1:6] <- NULL
    nameS <- colnames(use2)
    
    #Saves two pieces of data that will be used to plot onto the graph
    one <- c()
    second <- c()
    for(i in nameS){
      one <- c(one, eval(parse(text=paste0("use2$", i, "[1]"))))
      second <- c(second, eval(parse(text=paste0("use2$", i, "[2]"))))
    }
    
    #Creates a bar graph of a given team's stats between two dates
    p <- plot_ly(x=nameS, y = one, type = 'bar', name = paste0('Old Data: ', dates[1]), alpha=0.6) %>% 
      add_trace(y = second, name = paste0('Newest Data: ', dates[2])) %>% 
      layout(title = paste0('Historical Stats Comparison for ', first), barmode = "overlay")
    return(p)
    
    #Separate case: Compare between teams using newest data. 
  }else{
    if(length(teamsSelected)==0){
      return()
    }else{
      
      use <- df %>% arrange(desc(date)) %>% filter(team_long_name == first | team_long_name %in% teamsSelected)
      use <- subset(use, !duplicated(use[,4]))
      teamList <- use$team_long_name
      dates <- use$date
      
      use[,1:6] <- NULL
      nameS <- colnames(use)
      temp <- c()
      for(i in nameS){
        temp <- c(temp, eval(parse(text=paste0("use$", i, "[", 1, "]"))))
      }
      p <- plot_ly(type = 'bar', x=colnames(use), y=temp, name = paste0(teamList[1], ' Data: ', dates[1])) %>%
        layout(barmode = "stacked", xaxis = list(title = 'Skill Type'), title = 'Team Comparisons')
      
      for(j in 2:length(teamList)){
        temp <- c()
        for(i in nameS){
          temp <- c(temp, eval(parse(text=paste0("use$", i, "[", j, "]"))))
        }
        p <- p %>% add_trace(y=temp, name = paste0(teamList[j], ' Data: ', dates[j]))
      }
      
      #Creates a bar graph of the data
      return(p)
    }
  }
}