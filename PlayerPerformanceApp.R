library(shiny)
library(tidyverse)
library(DT)

#Read in data, cast as tibble
pitchers <-  read_csv("stats.csv")
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
      ggtitle("OBP ")
  })
  
}


# Run the application
shinyApp(ui = ui, server = server)

# library(shiny)
# library(tidyverse)
# library(DT)
# 
# dataframe1 <- data.frame(Player = rep(c("Lebron", "Steph", "Harden",
#                                         "Giannis"), each = 30),
#                          Game = rep(1:30, 4),
#                          Points = round(runif(120, 15, 40), 0))
# 
# ui <- fluidPage(
#   sidebarPanel(
#     selectInput("player",
#                 "Select a player",
#                 choices = unique(dataframe1$Player))
#   ),
#   
#   mainPanel(
#     dataTableOutput("average")
#   )
# )
# 
# server <- function(input, output, session){
#   playerFilt <- reactive({
#     dataframe1 %>%
#       filter(Player == input$player)
#   })
#   
#   output$average <- renderDataTable({
#     datatable(playerFilt() %>%
#                 summarise(PPG = sum(Points) / n()), rownames = FALSE, selection = 'none',
#               callback = JS("table.on('click.dt', 'td', function() {
#                                Shiny.onInputChange('click', Math.random());
#                 });"))
#   })
#   
#   # define modal
#   plotModal <- function() {
#     modalDialog(
#       plotOutput("ptdist")
#     )
#   }
#   
#   observeEvent(input$click, {
#     print("Clicked!")
#     removeModal()
#     showModal(plotModal())
#   })
#   
#   output$ptdist <- renderPlot({
#     playerFilt() %>%
#       ggplot() +
#       geom_histogram(aes(x = Points),binwidth = 2.5, fill = "skyblue", color = "black") +
#       theme_bw()
#   })
# }
# 
# shinyApp(ui, server)
# 


# data = data.frame(Population=sample(1:20,10),Households = sample(1:20,10), year=sample(c(2000,2010),10,replace=T))
# 
# ui <- fluidPage(
#   titlePanel(title = h4("Hillsborough County Population by Census", align="center")),
#   sidebarPanel(
#     
#     radioButtons("YEAR", "Select the Census Year",
#                  choices = c("2000", "2010"),
#                  selected = "2000")),
#   
#   
#   mainPanel(
#     plotOutput("bar",height = 500))
# )
# 
# server <- function(input,output){
#   
#   reactive_data = reactive({
#     selected_year = as.numeric(input$YEAR)
#     return(data[data$year==selected_year,])
#     
#   })
#   
#   output$bar <- renderPlot({
#     
#     color <- c("blue", "red")
#     
#     our_data <- reactive_data()
#     
#     barplot(colSums(our_data[,c("Population","Households")]),
#             ylab="Total",
#             xlab="Census Year",
#             names.arg = c("Population", "Households"),
#             col = color)
#   })
# }
# shinyApp(ui=ui, server=server)

