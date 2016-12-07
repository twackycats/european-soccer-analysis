# Add dependencies here
library(shiny)
library(dplyr)
library(radarchart)
library(plotly)
# Initialize all required dataframes here, then pass them to a function in your sourced script. Doing so will keep this code very clean.
players_organized <- read.csv("data/players_organized.csv")
teamData <- read.csv("data/team_revised.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  # Source the radarchart.R script
  source("scripts/radarchart.R")
  source("scripts/CreateScatter.r")
  source("scripts/bestWorstComparison.r")
  source("scripts/teamFilter.R")
  # Call the CreateRadarChart function, providing the players_organized dataframe and input as parameters. This function returns a radarChart.
  output$radarchart <- CreateRadarChart(players_organized, input)
  
  # ***Add your server code below this line***
  output$scatter <- CreateScatter(players_organized, input)
  
  outList <- c("X_Value", "Y_Value", "players", "select")
  #************** IF ADDING MORE INPUTS FROM UI.R PLS 
  #ADD THE INPUT NAME TO THE LIST ABOVE *************** 
  
  output$maxMin <- renderText({
    record(players_organized, input)
  })
  output$teamPlot <- renderTable({
    team(teamData, input, outList)
  })
})