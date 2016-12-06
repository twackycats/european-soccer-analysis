# Add dependencies here
library(shiny)
library(dplyr)
library(radarchart)
library(plotly)

# If your UI code requires a dataframe, initialize it here.
# read in the player.csv file and create a vector containing all player names for use in the selectizeInput
player <- read.csv("data/player.csv")
player_organized <- read.csv("data/players_organized.csv")
player_names <- as.vector(as.matrix(select(player, player_name)))
player_attributes <- colnames(player_organized)[6:42]

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
                 width=7))
             ),
    
    # ***Add your tab panels below these two comments***
    # (Note: A comma is required after each one, except for the last. You will need to put in a comma above when adding the next tabPanel)
    tabPanel("Attribute Comparison",
              titlePanel("Attribute Relationships"),
              sidebarLayout(
                sidebarPanel(
                  selectInput("X_Value", label = h2("X Variable"),
                             choices = player_attributes,
                             selected = player_attributes[1]),
                  selectInput("Y_Value", label = h2("Y Variable"),
                             choices = player_attributes,
                             selected = player_attributes[2])
                 ),
                 mainPanel(
                   plotOutput('scatter')
                 )
               )
             )
    )
    ))
