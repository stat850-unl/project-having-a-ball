library(shiny)
library(tidyverse)
library(Lahman)

head(Fielding)

# Define UI for application that draws a histogram
# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

ui <- fluidPage(
  titlePanel("Insert Baseball Title Here"),
  
  # Create a new Row in the UI for select Inputs
  fluidRow(
    column(4,
           selectInput("catch",
                       "Catcher:",
                       c("All",
                         unique(as.character(Fielding$playerID))))
    ),
    column(4,
           selectInput("team",
                       "Team:",
                       c("All",
                         unique(as.character(Fielding$teamID))))
    ),
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)


library(ggplot2)



server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- Fielding 
    if (input$catch != "All") {
      data <- data[data$playerID == input$catch,]
    }
    if (input$team != "All") {
      data <- data[data$teamID == input$team,]
    }
    data
  }))
  
}


# Run the application
shinyApp(ui = ui, server = server)
