library(shiny)
#install.packages("shinydashboard")
library(shinydashboard)
#install.packages("shinyjs")
library(shinyjs)
library(scidb)
scidbconnect()
ui <- mainPanel(
    titlePanel("Web Analytics"),
    h4("Welcome"),
    textInput("userlabel",label = "",value = "Login first.."),
    
    # include the UI for each tab
  tabsetPanel(
    tabPanel(
      "Login page",
      source(file.path("ui", "login.R"))),
    tabPanel(
      "Create Arrays",
      source(file.path("ui", "mainpage.R"))),
    tabPanel("Add Functions"),
    tabPanel(
      "View Graph",
      source(file.path("ui", "graph.R")))
  )
  
  
  #  ,source(file.path("ui", "tab1.R"))

)

server <- function(input, output, session) {
  # Include the logic (server) for each tab
  hide("userlabel")
  source(file.path("server", "tab1.R"),local = TRUE,echo = TRUE)
  
   source(file.path("server", "tab.R"),local = TRUE,echo = TRUE)
  source(file.path("server", "tab2.R"),local = TRUE,echo = TRUE)
  
}

shinyApp(ui = ui, server = server)
