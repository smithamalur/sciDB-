
  observe({ 
    load_user_arrays(input$userlabel)
    load_columns_names(input$check3)
  })
  
 
  
  plotGraph <- function(x, type) {
    switch(type,
           Histogram = hist(x),
           BarChart = barplot(x),
           PieChart = pie(x))
  }
  
  output$Graph <- renderPlot({
    
    data <- scidb("test")[]
    x <- input$check2
    result <- data.matrix(data[x])
    plotGraph(result,input$graphType)
  })
  
  
  
  load_user_arrays <- function(username) {
    
    if (username != "Loading") {
      x=scidb("users")
      fd=iqdf(x)
      st=fd$arrays[fd$usernames==username]
      array_list = strsplit(st,';')
      updateRadioButtons(session, "check3",choices = c(unlist(array_list)), selected = input$check3)
    }
  }
  
  load_columns_names <- function(array) {
    if (array != "Loading") {
      array_data=scidb(array)
      attrs=scidb_attributes(array_data)
      updateRadioButtons(session, "check2",choices = c(attrs))
    }
  }
  