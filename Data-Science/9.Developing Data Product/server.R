library(shiny)
library(e1071) 


classifier <- function(sl, sw, pl, pw) {
  data(iris)
  classifier <- naiveBayes(iris[,1:4], iris[,5])
  
  test <- c(sl, sw, pl, pw)
  predict <- predict(classifier, test)
  
  out <- predict[1]
  return (out)

}

shinyServer(
 function(input, output) {
	output$Specie <- renderPrint(
    classifier(input$sl, input$sw,
               input$pl, input$pw) )
 }
)