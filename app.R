library(shiny)
#install.packages("shinydashboard")
library(shinydashboard)
#install.packages("shinyjs")
library(shinyjs)
#install.packages("shinythemes")
library(shinythemes)
library(cluster)
#install.packages("scatterplot3d")
library(scatterplot3d)
#install.packages("rgl")
library(rgl)
library(plotrix)
library(scidb)
scidbconnect()
css <- "
.shiny-output-error { visibility: hidden; }
.shiny-output-error:before {
  visibility: visible;
  content: 'An error occurred. Please check your input values.'; }
}
"
ui <- mainPanel(
  tags$style(type="text/css", css),
   fluidPage(theme = shinytheme("cerulean"),
  titlePanel("Scilyses"),
  fluidRow(
    column(3, align="left", offset = 0,
    h3("Welcome")),
    column(4, align="left", offset = 0,
    textInput("userlabel",label = '',value = "Login first..")
    
    #tags$style(type="text/css", "#userlabel { height: 25px; width:100%; text-align:left; font-size: 15px; display: block;}")
    )),
    # include the UI for each tab
  tabsetPanel(
    tabPanel(
      "Login page",
      source(file.path("ui", "login.R"))),
    tabPanel(
      "Create Arrays",
      source(file.path("ui", "mainpage.R"))),
    tabPanel("Add Functions",
             source(file.path("ui", "functions.R"))),
    tabPanel("Graphs",
             source(file.path("ui", "graphs.R"))),
    tabPanel("Clustering",
             source(file.path("ui", "visualization.R")))
  )
  
  )
  #  ,source(file.path("ui", "tab1.R"))

)

server <- function(input, output, session) {
  # Include the logic (server) for each tab
  hide("userlabel")
  source(file.path("server", "tab1.R"),local = TRUE,echo = TRUE)
  source(file.path("server", "tab.R"),local = TRUE,echo = TRUE)
  source(file.path("server", "tab2.R"),local = TRUE,echo = TRUE)
  source(file.path("server", "tab3.R"),local = TRUE,echo = TRUE)
  source(file.path("server", "tab4.R"),local = TRUE,echo = TRUE)
  
}

shinyApp(ui = ui, server = server)
