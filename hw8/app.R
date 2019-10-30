#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

min.age <- min(ChickWeight$Time)
max.age <- max(ChickWeight$Time)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Chick Weight Data Viewer"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("chicks_plot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$chicks_plot <- renderPlot({
      ggplot(ChickWeight, aes(x = ChickWeight$Time, y = ChickWeight$weight, color = ChickWeight$Diet)) + geom_point()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

