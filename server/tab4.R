observe({ 
  load_user_arrays(input$userlabel)
  load_columns_names(input$check3)
})



plotGraph <- function(x, type) {
  require(grDevices)
  switch(type,
         Histogram = hist(x),
         BarChart = bar1(x),
         PieChart = pie1(x))
}

bar1<-function(x)
{
  n=length(x)/5
  if(n<9)
    n=10
  if(n>50)
    n=50
  z=sample(x,size = n)
  barplot(z,col = rainbow(n),legend.text = z)
}
pie1<-function(x)
{
  n=length(x)/5
  if(n<9)
    n=10
  if(n>30)
    n=20
  z=sample(x,size = n)
  arrayName=input$check3
  attrs1=input$check2
  s1=paste(attrs1," of ",arrayName)
  lbls <- paste(names(table(z)), "\n", table(z), sep="")
  pie(table(z),labels=lbls,col = rainbow(n))
}
output$Graph <- renderPlot({
  
  data <- scidb(input$check3)[]
  x <- input$check2
  result <- data.matrix(data[x])
  
  plotGraph(result,input$graphType)
})



load_user_arrays <- function(username) {
  
  if (username != "Login first..") {
    x=scidb("users")
    fd=iqdf(x)
    st=fd$arrays[fd$usernames==username]
    array_list = strsplit(st,';')
    updateSelectInput(session, "check3",choices = c(unlist(array_list)), selected = input$check3)
  }
}

load_columns_names <- function(array) {
  if (array != "Loading") {
    array_data=scidb(array)
    attrs=scidb_attributes(array_data)
    updateRadioButtons(session, "check2",choices = c(attrs))
  }
}
