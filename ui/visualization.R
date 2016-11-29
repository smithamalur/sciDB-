fluidPage(
  sidebarPanel(
    selectInput("selectarray", "Choose a dataset:",choices = 'users',selected = NULL),
    selectInput('xcol', 'X Variable',choices = 'usernames',selected = NULL),
    selectInput('ycol', 'Y Variable',choices='usernames',selected = NULL),
    radioButtons('clusterType', "Choose visualization type:", list("Kmeans scatterplot", "Kmeans 2D plot", "Interactive plot","Partitioning around medoids")),
    numericInput('clusters', 'Cluster count', 3, min = 1, max = 9),
    actionButton('genplot',label = "Generate Plot", class = "btn-primary")
  ),
  mainPanel(
   plotOutput('plot1')
)
)