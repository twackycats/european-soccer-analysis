library(dplyr)
library(shiny)
library(plotly)

team <- function(df, choice, first, teamSelected){
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
  if(choice==FALSE){
    use2 <- df %>% arrange(date) %>% filter(team_long_name==first)
    dates <- use2$date
    use2[,1:6] <- NULL
    nameS <- colnames(use2)
    first <- c()
    second <- c()
    for(i in nameS){
      first <- c(first, eval(parse(text=paste0("use2$", i, "[1]"))))
      second <- c(second, eval(parse(text=paste0("use2$", i, "[2]"))))
    }
    print(first)
    print(second)
    p <- plot_ly(x=nameS, y = first, type = 'bar', name = paste0('Old Data: ', dates[1])) %>% 
      add_trace(y = second, name = paste0('Newest Data: ', dates[2])) %>% 
      layout(title = paste0('Historical change of stats for ', first), xaxis = list(title = 'Skill Type'), barmode = 'group')
    return(p)
  }else{
    #use <- df %>% arrange(desc(date)) %>% subset(df!duplicated(df[,4]))
    use[,1:6] <- NULL
    p <- plot_ly(alpha = 0.6) %>%add_histogram(data = use[1,]) %>%add_histogram(data = use[2,]) %>%
      layout(barmode = "group", title = paste0('Historical change of stats for ', teamSelected[1]))
    return(p)
  }
}



# 
# selectInput("buildUpPlayDribblingClass", label = h3("Build Up Play Dribbling"), choices = c("All", unique(teams$buildUpPlayDribblingClass))),
# selectInput("buildUpPlayPassingClass", label = h3("Build Up Play Passing"), choices = c("All", unique(teams$buildUpPlayPassingClass))),
# selectInput("buildUpPlayPositioningClass", label = h3("Build Up Play Positioning"), choices = c("All", unique(teams$buildUpPlayPositioningClass))),
# selectInput("buildUpPlaySpeedClass", label = h3("Build Up Play Speed"), choices = c("All", unique(teams$buildUpPlaySpeedClass))),
# selectInput("chanceCreationCrossingClass", label = h3("Chance Creation Crossing"), choices = c("All", unique(teams$chanceCreationCrossingClass))),
# selectInput("chanceCreationPassingClass", label = h3("chance Creation Passing"), choices = c("All", unique(teams$chanceCreationPassingClass))),
# selectInput("chanceCreationPositioningClass", label = h3("Chance Creation Positioning"), choices = c("All", unique(teams$chanceCreationPositioningClass))),
# selectInput("chanceCreationShootingClass", label = h3("Chance Creation Shooting"), choices = c("All", unique(teams$chanceCreationShootingClass))),
# selectInput("defenceAggressionClass", label = h3("Defence Aggression"), choices = c("All", unique(teams$defenceAggressionClass))),
# selectInput("defenceDefenderLineClass", label = h3("Defence Defender Line"), choices = c("All", unique(teams$defenceDefenderLineClass))),
# selectInput("defencePressureClass", label = h3("Defence Pressure"), choices = c("All", unique(teams$defencePressureClass))),
# selectInput("defenceTeamWidthClass", label = h3("Defence Team Width"), choices = c("All", unique(teams$defenceTeamWidthClass)))
# 
