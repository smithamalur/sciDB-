#shinyUI(
 fluidPage(
   textInput("arrayName", label = h3("Name your array")),
  
   fileInput('file', 'Choose CSV File',
             accept = c(
               '.csv',
               '.tsv'
             )
   ),
   actionButton("createArray", label = "Create Array", class = "btn-primary"),
   hr(),
   checkboxGroupInput('check', 'Select dimensions(Only integer attributes)', choices = c('Pending Upload')),
   actionButton("redimensionArray", label = "Redimension", class = "btn-primary"),
   verbatimTextOutput("value1"),
   hr(),
   tableOutput("value")
)

