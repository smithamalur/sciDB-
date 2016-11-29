observe(
  {
    updateVisualization()
  }
)

updateVisualization<-function()
{
  g=scidb("users")
  fd1=iqdf(g)
  username=input$userlabel
  st=fd1$arrays[fd1$usernames==username]
  arrs<-(strsplit(st, ";"))
  arrs<-unlist(arrs)
  updateSelectInput(session,"selectarray",choices=c(arrs))
}

observeEvent(input$selectarray,{
  arrayName=input$selectarray
 # switch(input$selectarray,
#         selectedarray=scidb(arrayName))
  array1=scidb(arrayName)
  attr1=scidb_attributes(array1)
  updateSelectInput(session,"xcol",choices = c(attr1))
  updateSelectInput(session,"ycol",choices = c(attr1))
})
#datasetInput <- reactive({
#  arrayName=input$selectarray
#  switch(input$selectarray,
#         selectedarray=scidb(arrayName))
#})

#selectedData <- function(kmeanson){
#  kmeanson[, c(input$xcol, input$ycol)]
#}
#plotinput <- reactive(
#  {
#    switch(input$clusterType,
#           "Kmeans scatterplot"=
#           "Kmeans 2D plot"=
#           "Cluster Dendogram"=
#           )
#  }
#)

observeEvent(input$genplot,
  {
    arrayName=input$selectarray
    array2=scidb(arrayName)
    Df=iqdf(array2,n=100)
    x<-input$xcol
    y<-input$ycol
    KmeansDf1=data.frame(Df[x],Df[y])
    kk=kmeans(KmeansDf1, input$clusters)
    distances <- dist(KmeansDf1, method="euclidean")
    require(grDevices)
    switch(input$clusterType,
           "Kmeans scatterplot"=kmeansScatter(KmeansDf1,kk,distances),
             "Kmeans 2D plot"=kmeans2d(KmeansDf1,kk,distances)
             ,"Interactive plot"=interactivekmeans(KmeansDf1,kk,distances),
           "Partitioning around medoids"=pamFunction(KmeansDf1,distances)
    )
      
  }
)
pamFunction <- function(KmeansDf1,distances)
{
  clusters=input$clusters
  pam1=pam(distances,clusters)
  output$plot1<- renderPlot({
  plot(pam1,color = rainbow(clusters))
  })
}
interactivekmeans <- function(KmeansDf1,kk,distances)
{
  mycmdscale<-cmdscale(distances,3)
  output$plot1<- renderPlot({
    plot3d(mycmdscale, col=kk$cluster, size=5)
  })
}
kmeansScatter<- function(KmeansDf1,kk,distances)
{
  
  mycmdscale<-cmdscale(distances,3)
  output$plot1<- renderPlot({
  s3d <- scatterplot3d(mycmdscale, color=kk$cluster)
  })
}

kmeans2d<- function(KmeansDf1,kk,distances)
  {
  #print(KmeansDf)
  #print(y)
  mycmdscale<-cmdscale(distances,3)
  output$plot1<- renderPlot({
    plot(mycmdscale,col = kk$cluster)
    #   ,pch = 20, cex = 3)
    points(kk$centers, pch = 4, cex = 4, lwd = 4)
})
}
#output$plot1 <- renderPlot({
#  palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
#            "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
#  par(mar = c(5.1, 4.1, 0, 1))
#  
#  arrayName=input$selectarray
#  kmeanson=scidb(arrayName)
#  KmeansDf=iqdf(kmeanson)
#  x<-input$xcol
#  y<-input$ycol
#  KmeansDf1=data.frame(KmeansDf$x,KmeansDf$y)
#  kk=kmeans(KmeansDf1, input$clusters)
#  plot(KmeansDf$x,KmeansDf$y,
#       col = kk$cluster,
#       pch = 20, cex = 3)
#  points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
#})
