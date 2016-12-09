# Add dependencies here
library(shiny)
library(dplyr)
library(radarchart)
library(plotly)
# Initialize all required dataframes here, then pass them to a function in your sourced script. Doing so will keep this code very clean.
players_organized <- read.csv("data/players_organized.csv")
teamData <- read.csv("data/team_revised.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # Creating a summary paragraph of the player comparison page
  output$text1 <- renderText({ 
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
  
  # Creating a summary paragraph of the attribute comparison page
  output$text2 <- renderText({ 
    paste("This graphic represents an attribute comparison that shows the
          relationship between two selected attributes. Users select two 
          attributes as well as the axis, and a graph will show the correlation
          between the two attributes and their respective values based on one
          another.")
  })
  
  # creating a summary sentence of the best/worst player page
  output$text3 <- renderText({ 
    paste("This graphic allows users to select an attribute and find out
          which player has the best & worst rating for that attribute.")
  })
  
  
  # creating a summary paragraph of the team skill changes & comparison page
  output$text4 <- renderText({
    paste("This graphic has two options. One, it can compare a team's 
          stats & attributes between two different years in that team's
          history. It can also compare the stats & attributes between two
          chosen teams. This can be very useful to find out which team is
          better between two teams of modern day, or in history.")
  })
  
  # Source the chart scripts
  source("scripts/radarchart.R")
  source("scripts/CreateScatter.r")
  source("scripts/bestWorstComparison.R")
  source("scripts/teamFilter.R")
  
  # Call the CreateRadarChart function, providing the players_organized dataframe and input as parameters. This function returns a radarChart.
  output$radarchart <- CreateRadarChart(players_organized, input)
  
  # ***Add your server code below this line***
  output$scatter <- CreateScatter(players_organized, input)
  
  output$maxMin <- renderText({
    record(players_organized, input$select)
  })
  
  output$teamPlot <- renderPlotly({
    team(teamData, input$choice, input$first, input$teamSelected)
  })
})