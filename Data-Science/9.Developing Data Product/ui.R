library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Flower Classcification"),
    sidebarPanel(
      h4('The data was extracted from Edgar Anderson\'s Iris Data.'),
      h4('Select the lengths and the widths of the sepal and the petal of the flower, 
         and we shall show you the corresponding flower category'),
      
  	  h3("Enter the data"),
  			   
  	  numericInput("sl", 'Sepal Length', 
                   6.0, min = 0.1, max = 10.0, step = 0.1),
      numericInput("sw", 'Sepal Width', 
                   3.0, min = 0.1, max = 10.0, step = 0.1),
      numericInput("pl", 'Petal Length', 
                   4.0, min = 0.1, max = 10.0, step = 0.1),
      numericInput("pw", 'Petal Width', 
                   1.0, min = 0.1, max = 10.0, step = 0.1)  
  	),
    
    mainPanel(
      h4("The Flower Specie"),
  	verbatimTextOutput("Specie")
  	)
  )
)

