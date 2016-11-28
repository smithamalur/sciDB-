library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Select options to view your data."),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons('check3', 'Select array', choices = c('Loading')),
      radioButtons('check2', 'Select dimensions(Only integer attributes)', choices = c('Loading')),
      radioButtons("graphType", "Choose plot type:", list("Histogram", "BarChart", "PieChart"))
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Graph")
    )
  )
))