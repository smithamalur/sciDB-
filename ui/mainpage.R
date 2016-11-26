#shinyUI(
 fluidPage(
   textInput("arrayName", label = h3("Name your array")),
   hr(),
   fileInput('file', 'Choose CSV File',
             accept = c(
               '.csv',
               '.tsv'
             )
   ),
   checkboxGroupInput('check', 'Select dimensions(Only integer attributes)', choices = c('Pending Upload')),
   actionButton("redimensionArray", label = "Redimension"),
   verbatimTextOutput("value1"),
   tableOutput("value")
)

