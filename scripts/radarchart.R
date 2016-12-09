library(radarchart)
library(dplyr)
library(tidyr)

# Returns a radarchart comparing two players based on all of their attributes
CreateRadarChart <- function(df, input){
  return(
    renderChartJSRadar({
      # select the most recent records for each player and select their name and their stats
      latest_stats <- df %>% group_by(player_fifa_api_id) %>% top_n(n=1, wt = date) %>% select(player_name, 15:47)
      # remove player_fifa_api_id separately to prevent R from "Adding missing grouping variables"
      latest_stats <- subset(latest_stats, select = -player_fifa_api_id)
      # Don't try to create that chart if no players are selected
      if(length(input$players)==0){ return() }
      # combine the records of the players into a dataframe using rbind
      # start with a base dataframe containing the stats for one of the players
      
      radar_stats <- filter(latest_stats, player_name == input$players[1])
      # add additional rows for the rest of the players in input$players
      for(player in input$players[-1]){
        radar_stats <- rbind(radar_stats, filter(latest_stats, player_name == player))
      }
      
      # prepare the dataframe for the chartJSRadar function
      radar_stats <- gather(radar_stats, key=Label, value=Score, -player_name) %>% spread(key=player_name, value=Score)
      
      # create a radar chart of the radar_stats dataframe
      chartJSRadar(scores = radar_stats, maxScale = 100, showToolTipLabel = TRUE)
    })
  )
}