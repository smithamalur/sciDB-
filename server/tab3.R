# Define server logic required to summarize and view the 
# selected dataset
# Return the requested dataset
observe(
  {
    g=scidb("users")
    fd1=iqdf(g)
    username=input$userlabel
    st=fd1$arrays[fd1$usernames==username]
    arrs<-(strsplit(st, ";"))
    arrs<-unlist(arrs)
    updateSelectInput(session,"dataset",choices=c(arrs))
  }
)

datasetInput <- reactive({
  arrayName=input$dataset
  switch(input$dataset,
         selectedfunction=scidb(arrayName))
})


datasetFunc <- reactive(
  { 
    if(!is.null(input$checkbox)){
      s1<-c(input$checkbox,input$functions)
      s2<-paste(s1,collapse = "_")
      s=""
      s=paste(s,"store(cumulate(",input$dataset,",sum(",input$checkbox,")),",s2,")")
      #iquery(s)
    }
    switch(input$functions,
           "count" = count(scidb(input$dataset)),
           "cumulative" = head(scidb(s2),n=input$obs),
           "subset" = print("subset")
    )
  }  
)


observe(
  {
    arrayName=input$dataset
    array_data=scidb(arrayName)
    attrs=scidb_attributes(array_data)
    updateCheckboxGroupInput(session, "checkbox",choices = c(attrs))
  }
)

output$value3 <- renderPrint(
  {
    dims=input$checkbox
    print(dims)
  }
)

output$value4 <- renderPrint(
  {
    g=scidb("users")
    fd1=iqdf(g)
    username=input$userlabel
    st=fd1$arrays[fd1$usernames==username]
    nme<-(strsplit(st, ";")[[1]][2])
    print(nme)
  }
)

# Generate a summary of the dataset
#  output$Count <- renderPrint({
#   dataset <- datasetInput()
#   count(dataset)
# })

output$Functions <- renderPrint({
  datasetFunc()
  
})
# Show the first "n" observations
output$view <- renderTable({
  
  head(scidb(input$dataset), n = input$obs)
})
