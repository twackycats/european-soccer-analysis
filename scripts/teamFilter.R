library(dplyr)
library(shiny)
library(plotly)
library(stringr)

team <- function(df, choice, teamSelected){
  use <- df
  use[,27] <- NULL
  use[,26] <- NULL
  use[,24] <- NULL
  use[,22] <- NULL
  use[,20] <- NULL
  use[,19] <- NULL
  use[,17] <- NULL
  use[,15] <- NULL
  use[,13] <- NULL
  use[,12] <- NULL
  use[,10] <- NULL
  use[,8] <- NULL
  if(choice==FALSE){
    use <- use %>% arrange(date) %>% filter(team_long_name==teamSelected[1])
    use[,1:6] <- NULL
    nameS <- colnames(use)
    print(as.vector(use[1,]))
    p <- plot_ly(y=nameS, x = as.vector(use[1,]), type = 'bar', name = "Old Data") %>%
      add_trace(y=nameS, x = as.vector(use[2,]), name = 'Newest Data') %>%
      layout(title = paste0('Historical change of stats for ', teamSelected[1]), xaxis = list(title = 'Skill Type'), barmode = 'group')
    
    return(p)
  }else{
    use <- df %>% arrange(desc(date)) 
    use <- subset(use, !duplicated(use[,4]))
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
    use[,1:6] <- NULL
    p <- plot_ly(alpha = 0.6) %>%
      add_histogram(data = use[1,]) %>%
      add_histogram(data = use[2,]) %>%
  layout(barmode = "group", title = paste0('Historical change of stats for ', teamSelected[1]))

    return(p)
  }
}
