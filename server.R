# Add dependencies here
library(shiny)
library(dplyr)
library(radarchart)
library(plotly)
# Initialize all required dataframes here, then pass them to a function in your sourced script. Doing so will keep this code very clean.
players_organized <- read.csv("data/players_organized.csv")
teamData <- read.csv("data/team_revised.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # Creating a summary paragraph of the displayed graphic.
  output$text <- renderText({ 
    paste("This is a player attribute comparison radar chart between 
          two players. The default chosen players are Alessio Scarpi 
          & Lionel Messi. Looking at the chart alone, we can predict
          the position of Scarpi as a goalie, because his goalie
          attributes are significantly high, compared to Messi's 
          low goalie attributes. We can tell that Messi is an offensive
          player due to his high ball control, passing, and shooting
          attributes. Messi's offensive stats are significantly higher
          than Scarpi's in every offensive category. However, there are
          a few attributes where they are about equal, such as jumping,
          strength, & marking. Ultimately, it is hard to determine
          who is the more skilled player due to their strengths in 
          different categories, however the radar chart helps us determine
          which player plays which position the best.")
  })
  
  # Source the radarchart.R script
  source("scripts/radarchart.R")
  source("scripts/CreateScatter.r")
  source("scripts/bestWorstComparison.R")
  source("scripts/teamFilter.R")
  # Call the CreateRadarChart function, providing the players_organized dataframe and input as parameters. This function returns a radarChart.
  output$radarchart <- CreateRadarChart(players_organized, input)
  
  # ***Add your server code below this line***
  output$scatter <- CreateScatter(players_organized, input)
  
  outList <- c("X_Value", "Y_Value", "players", "select")
  #************** IF ADDING MORE INPUTS FROM UI.R PLS 
  #ADD THE INPUT NAME TO THE LIST ABOVE *************** 
  
  output$maxMin <- renderText({
    record(players_organized, input$select)
  })
  output$teamPlot <- renderTable({
    team(teamData, input, outList)
  })
})