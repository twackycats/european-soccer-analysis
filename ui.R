# Add dependencies here
library(shiny)
library(dplyr)
library(radarchart)

# If your UI code requires a dataframe, initialize it here.
# read in the player.csv file and create a vector containing all player names for use in the selectizeInput
player <- read.csv("data/player.csv")
player_names <- as.vector(as.matrix(select(player, player_name)))

# Define UI for the European Soccer Analysis application
shinyUI(fluidPage(
  # Create a tabsetPanel
  tabsetPanel(
    selected = "Player Attribute Radar Chart",
    # Create a tabPanel for the Player Attribute Radar Chart
    tabPanel("Player Attribute Radar Chart",
             titlePanel("Player Attribute Comparison"),
             sidebarLayout(
               sidebarPanel(
                 selectizeInput("players",
                                label=NULL, 
                                choices = player_names, 
                                selected = c("Alessio Scarpi","Lionel Messi"), 
                                multiple = TRUE,
                                options = list(maxItems = 2))),
               mainPanel(
                 chartJSRadarOutput("radarchart"),
                 width=12))
             )
    
    # ***Add your tab panels below these two comments***
    # (Note: A comma is required after each one. You will need to put in a comma above when adding the second tabPanel)
    
    )
  ))
