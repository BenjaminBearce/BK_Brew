# Fermentation Server

fermentationServer <- function(input, output){
  
  fermentationPlot <<- reactive({
          days1 <- 1:input$days1 #days
          days2 <- (max(days1)+1):(max(days1)+input$days2) #days
          days3 <- (max(days2)+1):(max(days2)+input$days3) #days
          days4 <- (max(days3)+1):(max(days3)+input$days4) #days
          days5 <- (max(days4)+1):(max(days4)+input$days5) #days
          
          days <- c(days1,days2,days3,days4,days5)
          
          tempFirstTemp <- rep(input$fermentationFirstTemp,length(days1))
          tempSecondTemp <- rep(input$fermentationSecondTemp,length(days2)) 
          tempThirdTemp <- rep(input$fermentationThirdTemp,length(days3))
          tempFourthTemp <- rep(input$fermentationFourthTemp,length(days4))
          tempFifthTemp <- rep(input$fermentationFifthTemp,length(days5))
          
          temp <- c(tempFirstTemp,tempSecondTemp,tempThirdTemp,tempFourthTemp,tempFifthTemp)
          
          fermentationDF <- data.frame(Days = days, Temp = temp)
          
          fermentationGraph <- ggplot(fermentationDF, aes(Days, Temp))
          #group = Volumes, color = Volumes))
          fermentationGraph + geom_line(size = 2) + ggtitle("Fementation")
  })
        
  output$fermentationPlot <- renderPlot({fermentationPlot()})
}