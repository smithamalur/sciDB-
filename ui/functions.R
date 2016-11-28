#library(shiny)

# Define UI for dataset viewer application
fluidPage(
  
  # Application title.
  #titlePanel("More Widgets"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("dataset", "Choose a dataset:",choices = 'users',selected = NULL),
      checkboxGroupInput('checkbox', 'Select attributes', 
                         choices = c('Pending Upload')),
      verbatimTextOutput("value3"),
      numericInput("obs", "Number of observations to view:", 10),
      selectInput("functions", "Choose a function:", 
                  choices = c("count","cumulative","subset"))
      #,verbatimTextOutput("value4")
      
    ),
    
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.
    mainPanel(
      h4("Functions"),
      verbatimTextOutput("Functions"),
      h4("Observations"),
      tableOutput("view")
    )
  )
)