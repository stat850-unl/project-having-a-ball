library(shiny)
library(tidyverse)
library(DT)

#Read in data, cast as tibble
pitchers <-  read_csv("CSVs/stats.csv")
pitchers <- tibble(pitchers)

pitchers <- pitchers %>% mutate(name=paste(first_name, last_name))

pitchers <- pitchers[order(pitchers$player_age),]

pitchers <- pitchers[order(pitchers$name),]

emptycolumn <- c("Years_In_Pitching")
pitchers[ , emptycolumn] <- NA


pitchers$Years_In_Pitching[1]<-1

i<-2
while (i < length(pitchers$Years_In_Pitching)){
  if(i==1){
    pitchers$Years_In_Pitching[i]=1
    i=i+1
  }
  else if(pitchers$name[i]==pitchers$name[i-1]){
    pitchers$Years_In_Pitching[i]=pitchers$Years_In_Pitching[i-1]+1
    i=i+1
  }
  else if(pitchers$name[i]!=pitchers$name[i-1]){
    pitchers$Years_In_Pitching[i] = 1
    i=i+1
  }
}

Qualifiedpitchers <- pitchers %>% filter(Years_In_Pitching > 5)


# Define UI for application that draws a histogram
# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

ui <- fluidPage(
  titlePanel("Pitcher Performance"),

  # Create a new Row in the UI for select Inputs
  fluidRow(
    column(4,
           selectInput("player",
                       "Pitcher:",
                       c("All",
                         unique(as.character(pitchers$name))))
    ),
    column(4,
           selectInput("yearInLeague",
                       "Year:",
                       c("All",
                         unique(as.character(pitchers$year))))
    ),
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table"),
  
  plotOutput("bar")
  

)


library(ggplot2)



server <- function(input, output) {

  #Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- pitchers
    if (input$player != "All") {
      data <- data[data$name == input$player,]
    }
    if (input$yearInLeague != "All") {
      data <- data[data$year == input$yearInLeague,]
    }
  }))

  
  output$bar <- renderPlot ({
    pitchers %>% dplyr::filter(name == input$player, 
                    # year == input$yearInLeague
                    ) %>% 
     ggplot(aes(x = Years_In_Pitching, y = on_base_percent)) + 
      geom_bar(stat = "identity", show.legend = FALSE) +
      ggtitle("Career OBP ")
  })
  
  
  
}

# Run the application
shinyApp(ui = ui, server = server)
```

