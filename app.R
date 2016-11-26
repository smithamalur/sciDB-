library(shiny)
library(scidb)
scidbconnect()
ui <- mainPanel(
    titlePanel("Web Analytics"),
    
  # include the UI for each tab
  tabsetPanel(
    tabPanel(
      "Create Arrays",
      source(file.path("ui", "mainpage.R"))),
    tabPanel("Add Functions")
  )
  
  
  #  ,source(file.path("ui", "tab1.R"))

)

server <- function(input, output, session) {
  # Include the logic (server) for each tab
  source(file.path("server", "tab.R"),local = TRUE,echo = TRUE)
  
}

shinyApp(ui = ui, server = server)
