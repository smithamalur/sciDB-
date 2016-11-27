fluidPage(
          textInput("username", label = h3("Enter Username")),
          textInput("password", label = h3("Enter Password")),
          actionButton("add", "Create Account", class = "btn-primary"),
          actionButton("login", "Log in", class = "btn-primary"),
          actionButton("logout", "Log out", class = "btn-primary"),
          tabPanel("User Table", tableOutput("table"))
         )
                  
    
        