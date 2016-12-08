# Add dependencies here
library(shiny)
library(dplyr)
library(radarchart)
library(ggplot2)
# If your UI code requires a dataframe, initialize it here.
# read in the player.csv file and create a vector containing all player names for use in the selectizeInput
player <- read.csv("data/player.csv")
player_organized <- read.csv("data/players_organized.csv")
player_names <- as.vector(as.matrix(select(player, player_name)))

# Gets the numerical attributes on the data
player_num_attributes <- c(colnames(player_organized)[6:7], 
                           colnames(player_organized)[10:11], 
                           colnames(player_organized)[15:47])
teams <- read.csv("data/team_revised.csv", stringsAsFactors = FALSE)
team_names <- unique(teams$team_long_name)

# Define UI for the European Soccer Analysis application
shinyUI(fluidPage(theme="bootstrap.css",
  # Create a navbarPage
  navbarPage("European Soccer Analysis",
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
                                multiple = TRUE),
               textOutput("text")), #writing in text from text variable created in server.R file.
               mainPanel(
                 chartJSRadarOutput("radarchart"),
                 width=7))
    ),
    
    # ***Add your tab panels below these two comments***
    # (Note: A comma is required after each one, except for the last. You will need to put in a comma above when adding the next tabPanel)
    
    # Create a tabPanel for the 
    tabPanel("Attribute Comparison Scatter Plot",
             titlePanel("Attribute Comparison w/ Density"),
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
    tabPanel("Team Skill Changes and Comparisons", 
             #Creates a   sidebar layout
             sidebarLayout(
               sidebarPanel(
                 #Adds a radio button chooser for team comparison mode. 
                 radioButtons("choice", label = h3("Select a mode: "), choices=c("Inspect Team History (Uses first selection from Team choices below)"=FALSE, "Compare"=TRUE), selected = "FALSE"),
                 #Adds a selectInput to specifically choose main team to look at in general
                 selectInput("first", label = h3("Select a main team: "), choices=team_names, selected = team_names[1]),
                 #Adds other teams that could be used in conjunction to the chosen compare option from the radio selector
                 selectizeInput("teamSelected", label=h2("Other Teams (optional)"), choices = team_names, selected = team_names[2], team_names[3], multiple = TRUE)
               ),
               #in which the main part of the shiny app
               mainPanel(
                 #is the output of the comparison of the currently best and worst European Soccer players 
                 plotlyOutput("teamPlot")
               )
             )
    )
  )
))
