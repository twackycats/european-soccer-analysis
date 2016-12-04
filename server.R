library(shiny)
# Initialize all required dataframes here, then pass them to a function in your sourced script. Doing so will keep this code very clean.
players_organized <- read.csv("data/players_organized.csv")

shinyServer(function(input, output) {
  # Source the radarchart.R script
  source("scripts/radarchart.R")
  # Call the CreateRadarChart function, providing the players_organized dataframe and input as parameters. This function returns a radarChart.
  output$radarchart <- CreateRadarChart(players_organized, input)
  
  # ***Add your server code below this line***
  
})
