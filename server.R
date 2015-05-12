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
            y<-galton$child - mean(galton$child)
            x <- galton$parent - mean(galton$parent)
            freqData <- as.data.frame(table(x, y))
            names(freqData) <- c("child", "parent", "freq")
            plot(as.numeric(as.vector(freqData$parent)),
                 as.numeric(as.vector(freqData$child)),
                 pch = 21, col = "black", bg = "lightblue",
                 cex = .15 * freqData$freq,
                 xlab = "parent",ylab = "child")
            abline(0, input$beta, lwd = 3)
            mse <- mean( (y - input$beta * x)^2 )
            title(paste("beta = ", input$beta, "mse = ", round(mse, 3)))
        })
        #prediction part
        output$inputValue <- renderPrint({input$parent_height})
        output$prediction <- renderPrint({bestfit(input$parent_height)})   
    }
)