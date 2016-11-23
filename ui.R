#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
?numericInput

# Define UI for application that draws a histogram
shinyUI(fluidPage(titlePanel("BC Liquor Store prices"),
                  sidebarLayout(
                    sidebarPanel(
                      sliderInput("priceInput", 
                                  "Price", 
                                  min = 0, 
                                  max = 100,
                                             
                                  value = c(25, 40), 
                                  pre = "$"), 
                      radioButtons("typeInput", 
                                   "Product type",
                                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                                   selected = "WINE"),
                      selectInput("countryInput", 
                                  "Country",
                                  choices = c("CANADA", "FRANCE", "ITALY")),
                      textInput("username", label = h3("Enter Username")),
                      textInput("password", label = h3("Enter Password")),
                      actionButton("add", "Create Account", class = "btn-primary"),
                      actionButton("login", "Log in", class = "btn-primary"),
                      actionButton("logout", "Log out", class = "btn-primary")
                      ),
                    mainPanel(
                      tabsetPanel(
                        tabPanel("Home", "graph will go here or something"),
                        tabPanel("User Table", tableOutput("table"))
                      )
                    )
                  ))
    
        
        
  
  # Application title
  #titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  #sidebarLayout(
    #sidebarPanel(
      # sliderInput("bins",
                  # "Number of bins:",
                 #  min = 1,
                   #max = 50,
                  # value = 30)
   # ),
    
    # Show a plot of the generated distribution
    #mainPanel(
     #  plotOutput("distPlot")
   # )
#  )
#))
)
