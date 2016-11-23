#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
print(str(bcl))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  output$table <- renderTable({
    user_data()
  })
  
  
  login <- eventReactive(input$login, {
    check_login(input$username, input$password)
  }) 
  
  logout <- eventReactive(input$logout, {
    input$label = ""
  }) 
  
  check_login <- function(username, password) {
    library("scidb")
    scidbconnect()
    user = scidb("user")
    attemptedUsername = subset(x[], usernames == username)
    successfull = attemptedUsername["passwords"] == password
    if (successfull) {
      input$label = username
    }
    else {
      input$label = ""
    }
  }
  
  
  user_data <- eventReactive(input$add, {
    load_user_data(input$username, input$password)
  })  
  
  load_user_data <- function(username, password) {
    library("scidb")
    scidbconnect()
    usernames = username
    passwords = password
    array = " "
    df = data.frame(usernames, passwords, array)
    df = as.scidb(df)
    x <- scidb("user")
    usernameInUse = x[]["usernames"] == username
    if (any(usernameInUse)){
      
    }
    else {
      data <- rbind(x[], df[])
      keeps <- c("usernames", "passwords", "array")
      newDF = data[keeps]
      newDF
      x <- as.scidb(newDF,name="user")
    }
    return(x[])
  }
  
})
