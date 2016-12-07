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
player_attributes <- c(colnames(player_organized)[6:7], colnames(player_organized)[10:11], colnames(player_organized)[15:47])
teams <- read.csv("data/team_revised.csv", stringsAsFactors = FALSE)

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
                 plotlyOutput('scatter')
               )
             )
    ),
    tabPanel("Best/Worst Comparison", 
             #Creates a sidebar layout
             sidebarLayout(
               sidebarPanel(
                 #Weight and height are removed from choices as we want users to retrieve concise 
                 #comparisons to skills in this simple part of the app. 
                 selectInput("select", label = h3("Select an attribute: "), choices=player_attributes[-c(1, 2)])
               ),
               #in which the main part of the shiny app
               mainPanel(
                 #is the output of the comparison of the currently best and worst European Soccer players 
                 textOutput("maxMin")
               )
             )
    ),
    tabPanel("Team Chooser", 
             #Creates a sidebar layout
             sidebarLayout(
               sidebarPanel(
                 
                 selectInput("buildUpPlayDribblingClass", label = h3("Build Up Play Dribbling"), choices = c("All", unique(teams$buildUpPlayDribblingClass))),
                 selectInput("buildUpPlayPassingClass", label = h3("Build Up Play Passing"), choices = c("All", unique(teams$buildUpPlayPassingClass))),
                 selectInput("buildUpPlayPositioningClass", label = h3("Build Up Play Positioning"), choices = c("All", unique(teams$buildUpPlayPositioningClass))),
                 selectInput("buildUpPlaySpeedClass", label = h3("Build Up Play Speed"), choices = c("All", unique(teams$buildUpPlaySpeedClass))),
                 selectInput("chanceCreationCrossingClass", label = h3("Chance Creation Crossing"), choices = c("All", unique(teams$chanceCreationCrossingClass))),
                 selectInput("chanceCreationPassingClass", label = h3("chance Creation Passing"), choices = c("All", unique(teams$chanceCreationPassingClass))),
                 selectInput("chanceCreationPositioningClass", label = h3("Chance Creation Positioning"), choices = c("All", unique(teams$chanceCreationPositioningClass))),
                 selectInput("chanceCreationShootingClass", label = h3("Chance Creation Shooting"), choices = c("All", unique(teams$chanceCreationShootingClass))),
                 selectInput("defenceAggressionClass", label = h3("Defence Aggression"), choices = c("All", unique(teams$defenceAggressionClass))),
                 selectInput("defenceDefenderLineClass", label = h3("Defence Defender Line"), choices = c("All", unique(teams$defenceDefenderLineClass))),
                 selectInput("defencePressureClass", label = h3("Defence Pressure"), choices = c("All", unique(teams$defencePressureClass))),
                 selectInput("defenceTeamWidthClass", label = h3("Defence Team Width"), choices = c("All", unique(teams$defenceTeamWidthClass)))
                 
               ),
               #in which the main part of the shiny app
               mainPanel(
                 #is the output of the comparison of the currently best and worst European Soccer players 
                 tableOutput("teamPlot")
               )
             )
    )
  )
))
