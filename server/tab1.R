  observeEvent(input$login, {
    check_login(input$username, input$password)
  }) 
  
  observeEvent(input$logout, {
    updateTextInput(session,"userlabel",value = "")
    # input$userlabel = ""
  }) 
  
  check_login <- function(username, password) {
  #  library("scidb")
  #  scidbconnect()
    user = scidb("users")
    usernameInUse = user[]["usernames"] == username
    if (any(usernameInUse)){
    attemptedUsername = subset(user[], usernames == username)
    successfull = attemptedUsername["passwords"] == password
    if (successfull) {
      updateTextInput(session,"userlabel",value = username)
      #input$userlabel = username
    }
    }
    else {
      updateTextInput(session,"userlabel",value = "Invalid login")
      
        #input$userlabel = ""
    }
  }
  
  
  observeEvent(input$add, {
    load_user_data(input$username, input$password)
  })  
  
  load_user_data <- function(username, password) {
 #   library("scidb")
 #    scidbconnect()
    usernames = username
    passwords = password
    arrays = 'users'
    df = data.frame(usernames, passwords, arrays)
    df = as.scidb(df)
    x <- scidb("users")
    usernameInUse = x[]["usernames"] == username
    if (any(usernameInUse)){
      
    }
    else {
      data <- rbind(x[], df[])
      keeps <- c("usernames", "passwords", "arrays")
      newDF = data[keeps]
      newDF
      x <- as.scidb(newDF,name="users")
    }
    return(x[])
  }
  
