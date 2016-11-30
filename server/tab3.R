# Define server logic required to summarize and view the
# selected dataset
# Return the requested dataset
observe(
  {
    updatefunctionarray()
  }
)

updatefunctionarray <- function()
{
  g=scidb("users")
  fd1=iqdf(g)
  username=input$userlabel
  st=fd1$arrays[fd1$usernames==username]
  arrs<-(strsplit(st, ";"))
  arrs<-unlist(arrs)
  updateSelectInput(session,"dataset",choices=c(arrs))
}
datasetInput <- reactive({
  arrayName=input$dataset
  switch(input$dataset,
         selectedfunction=scidb(arrayName))
})


datasetFunc <- reactive(
  {
    if(input$functions=="join"){
     dims1=input$check_func
      s_im=paste(" ",dims1)
      s_imm=paste(s_im,collapse = ",")
      s3<-c(input$check_func,input$functions)
      s4<-paste(s3,collapse = "_")         ##store(join(left_array,right_array),result_array)
      s_join=("")
     s_join=paste(s_join,"store(join(",s_imm,"),",s4,")")
     iquery(s_join)
    }
    
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
      else
        if(input$functions=="bernoulli"){
          updateTextInput(session, "func_param",label="Enter probability")
          s_bern=""
          s_bern=paste(s_bern,"store(bernoulli(",input$dataset,",",input$func_param,"),",s2,")")
          iquery(s_bern)
        }
      else 
        if(input$functions=="filter"){
          updateTextInput(session, "func_param",label="Enter filter constraints (<,>,=)")
          s_fil=""
          s_fil=paste(s_fil,"store(filter(",input$dataset,",",input$checkbox,input$func_param,"),",s2,")")
          iquery(s_fil)
        }
      else
        if(input$functions=="apply"){
          updateTextInput(session, "func_param",label="Enter the expression")
          s<-c("new",input$checkbox)
          s_n1<-paste(s,collapse = "_")
          s_n<-paste("",input$func_param,input$checkbox)
          s_app=""
          s_app=paste(s_app,"store(apply(",input$dataset,",",s_n1,",",s_n,"),",s2,")")
          iquery(s_app)
        }
    }
    switch(input$functions,
           "count" = count(scidb(input$dataset)),
           "cumulative" = head(scidb(s2),n=input$obs),
           "aggregate_avg" = head(scidb(s2),n=input$obs),
           "aggregate_prod" = head(scidb(s2),n=input$obs),
           "aggregate_sum" = head(scidb(s2),n=input$obs),
           "bernoulli" = head(scidb(s2),n=inp,ut$obs),
           "filter" = head(scidb(s2),n=input$obs),
           "join" = head(scidb(s4),n=input$obs),
           "apply" = head(scidb(s2),n=input$obs)
    )
  } 
)

  

observeEvent(input$Save, {
  str<-c(input$checkbox,input$functions)
  str1<-paste(str,collapse = "_")
  check_Save(str1)
}) 
check_Save <- function(str1){
  a=scidb("users")
  fd=iqdf(a)
  username=input$userlabel
  st=fd$arrays[fd$usernames==username]
  st=paste(st,str1,sep=';')
  fd$arrays[fd$usernames==username]<-st
 iquery("remove(users)")
  usernames=fd$usernames
  passwords=fd$passwords
  arrays=fd$arrays
  temp<-data.frame(usernames,passwords,arrays)
  x<-as.scidb(temp,name="users")
  updateVisualization()
  load_user_arrays(username)
  updatefunctionarray()  
}

#observeEvent(input$functions=="join",{
  #arrayName=input$dataset
   #array_data=scidb(arrayName)
  #attrs=scidb_attributes(array_data)
  #updateCheckboxGroupInput(session, "checkbox1",choices = c(attrs))
#})

observe(
  {
    arrayName=input$dataset
    array_data=scidb(arrayName)
    attrs=scidb_attributes(array_data)
    updateCheckboxGroupInput(session, "checkbox",choices = c(attrs))
    
  }
)
#observeEvent(input$functions=="join",{
observe(   ###THIS WORKS!
  { if(input$functions=="join")
{    f=scidb("users")
    fd2=iqdf(f)
    username=input$userlabel
    st=fd2$arrays[fd2$usernames==username]
    arrs1<-(strsplit(st, ";"))
    arrs1<-unlist(arrs1)
    updateCheckboxGroupInput(session,"check_func",choices=c(arrs1))
 } }
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
#output$nText <- renderText({
 # ntext()
#})
