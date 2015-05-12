library(UsingR)
data(galton)

#fif the best model
bestfit<-function(parent_height) {
    fit<-lm(child~parent,data=galton)
    coef(fit)[1]+coef(fit)[2]*parent_height
}

shinyServer(
    function(input, output) {
        #find model part
        output$newHist <- renderPlot({
            freqData <- as.data.frame(table(galton$parent, galton$child))
            names(freqData) <- c("child", "parent", "freq")
            plot(as.numeric(as.vector(freqData$parent)),
                 as.numeric(as.vector(freqData$child)),
                 pch = 21, col = "black", bg = "lightblue",
                 cex = .15 * freqData$freq,
                 xlab = "parent",ylab = "child")
            abline(input$a,input$b,lwd = 3)
            mse <- mean((galton$child-galton$parent*input$b-input$a)^2)
            title(paste("intercept =",input$a,"slope=",input$b,"mse = ", round(mse, 3)))
        })
        
        #prediction part
        output$inputValue <- renderPrint({input$parent_height})
        output$prediction <- renderPrint({bestfit(input$parent_height)})   
    }
)