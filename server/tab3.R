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
      if(input$functions=="cumulative"){
        s_cum=""
        s_cum=paste(s_cum,"store(cumulate(", input$dataset, ",sum(",input$checkbox,")),",s2,")")
        iquery(s_cum)
      }
      else
        if(input$functions=="aggregate_sum"){
          s_aggs=""
          s_aggs=paste(s_aggs,"store(aggregate(",input$dataset,",sum(",input$checkbox,")),",s2,")")
          iquery(s_aggs)
        }
      else
        if(input$functions=="aggregate_avg"){
          s_agga=""
          s_agga=paste(s_agga,"store(aggregate(",input$dataset,",avg(",input$checkbox,")),",s2,")")
          iquery(s_agga)
        }
      else
        if(input$functions=="aggregate_prod"){
          s_aggp=""
          s_aggp=paste(s_aggp,"store(aggregate(",input$dataset,",prod(",input$checkbox,")),",s2,")")
          iquery(s_aggp)
        }
      #  s_bern=""
      #s_bern=paste(s_bern,)
    }
           switch(input$functions,
                  "count" = count(scidb(input$dataset)),
                  "cumulative" = head(scidb(s2)),
                  "aggregate_avg" = head(scidb(s2)),
                  "aggregate_prod" = head(scidb(s2)),
                  "aggregate_sum" = head(scidb(s2))
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
