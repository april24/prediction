library(shiny)
shinyUI(pageWithSidebar(
    #Application title
    headerPanel("Prediction with Galton's Data"),
    #two inputs "beta" and "parent's height"
    sidebarPanel(
        sliderInput('a', "intercept",23, min = 15, max = 30, step = 0.5),
        sliderInput('b', "slope",0.6, min = 0.5, max = 1, step = 0.005),
        sliderInput('parent_height', "Parent's Height",68, min = 60, max = 75, step = 0.05)
    ),
    
    mainPanel(
        #find model part
        h3('Find best model using Linear Regression Model'),
        h4('change intercept and slope to find the best model which make mse smallest'),
        plotOutput('newHist'),
        h3('Results of prediction with best model when intercept=23.94,slope=0.646'),
        #prediciton part
        h4("The parent's heght you entered"),
        verbatimTextOutput("inputValue"),
        h4("Prediction of child's height"),
        verbatimTextOutput("prediction")
    )
))