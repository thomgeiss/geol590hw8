#########
# Shiny App for chick weights (hw8)
#########

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
         sliderInput("chick.age.adjuster",
                     "Chick age (days):",
                     min = min.age,
                     max = max.age,
                     value = c(min.age, max.age))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("chicks_plot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  d_filt <- reactive({
    low.age <- input$chick.age.adjuster[1]
    hi.age <- input$chick.age.adjuster[2]
    
    ChickWeight %>%
      filter (Time >= low.age) %>%
      filter (Time <= hi.age)
  })
   
   output$chicks_plot <- renderPlot({
      ggplot(d_filt(), aes_string(x = "Time", y = "weight", color = "Diet")) + 
       geom_point() + labs(title = "Chick Weight and Diet", x = "Time (days)", y = "Weight (grams)")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

