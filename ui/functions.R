#library(shiny)

# Define UI for dataset viewer application
fluidPage(
  
  fluidRow(
    column(3,
           selectInput("dataset", "Choose a dataset:",choices = 'users',selected = NULL),
           checkboxGroupInput('checkbox', 'Select attributes',
                              choices = c('Pending Upload')),
           verbatimTextOutput("value3"),
           numericInput("obs", "Number of observations to view:", 10)),
    
 column(4,offset=1,
        selectInput("functions", "Choose a function:",
                    choices = c("count","cumulative","aggregate_avg","aggregate_sum","aggregate_prod",
                                "aggregate_sum","bernoulli","filter","join","apply"))),
 column(3,offset=1,
        checkboxGroupInput('check_func', 'Arrays',
                           choices = c('Valid for join function'))
 ),
 column(8, offset=1,h4("Functions"),
        verbatimTextOutput("Functions"),
        textInput("func_param",label = "Enter function parameters when required"),
        actionButton("Save", label="Save to profile", class="btn-primary")
 ),
 
 column(8,offset=1,h4("Observations"),
        tableOutput("view"))
  )
 
)
     
      #,verbatimTextOutput("value4")
      
    
    
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.
