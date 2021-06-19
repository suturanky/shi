#'This application is helpful to analyze RNAseq data and takes a data frame with at least 3 columns;
#'
#' Symbol: name of a Gene, 
#' log2Fold:log2 of the fold change of expression of that gene between two different samples 
#' Pvalue: p-value of the fold-change calculation.
#' 
#' To avoid issues with the dataset, a mock dataset is provided with this code.
#' 
#' With that dataset it creates a volcano plot and allows the user to set up the treshold of log2Fold 
#' of interest to reduce the number of genes and returns a list with those genes.
#
#
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Volcano Plot Analyzer"),
  
  # Sidebar with input for threshold
  sidebarLayout(
    sidebarPanel(
      numericInput("threshold",
                  "Select log2Fold threshold:",
                  min = 1,
                  max = 10,
                  value = 2)
    ),
    
    #Button to create the list and save it
    actionButton("do","Create list")
  ),
    # Show a plot of the generated graph and table
    mainPanel(
      plotOutput("distPlot"),
      tableOutput("genes")
    )
  )
)