library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Select options to view your data."),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput('check3', 'Select array', choices = c('users')),
      radioButtons('check2', 'Select attributes(Only integer attributes)', choices = c('Loading')),
      radioButtons("graphType", "Choose plot type:", list("Histogram", "BarChart", "PieChart"))
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Graph")
    )
  )
))