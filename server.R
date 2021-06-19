#'This application is helpful to analyze RNAseq data and takes a data frame with at least 3 columns;
#' 
#' Symbol: name of a Gene, 
#' log2Fold:log2 of the fold change of expression of that gene between two different samples 
#' Pvalue: p-value of the fold-change calculation.
#' 
#' To avoid issues with the dataset, a mock dataset is provided with this code.
#' 
#' With that dataset it creates a vulcano plot and allows the user to set up the treshold of log2Fold 
#' of interest to reduce the number of genes and returns a list with those genes. Then it saves that list
#' of genes in a csv document.
#' 

library(shiny)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(viridis)


shinyServer(function(input, output,session) {
  
  output$distPlot <- renderPlot({
    
    ##Generate mock dataset 
    set.seed(175)
    dataset<-data.frame(Symbol=do.call(paste0,expand.grid(rep(list(
      c('A', 'B', 'C', 'D')), 5))),
      log2Fold=rnorm(1024, mean=0,sd=4),
      Pvalue=rbeta(1024,0.1,10))
    ##Set Threshold based on input and filter dataset
    thresh <- as.numeric(input$threshold)
    filtered_dataset<<-filter(dataset,(log2Fold>thresh|log2Fold<(-thresh)))
    ##Create plot
    ggplot(dataset,mapping=aes(log2Fold,-log10(Pvalue), color=abs(log2Fold)))+
      geom_point(filtered_dataset,mapping=aes(log2Fold,-log10(Pvalue)),
                                              alpha=0.8, size=2)+
      theme_classic()+
      scale_color_viridis(option="D")+guides(color="none")
    
  })
  ##Create list and save it when button is clicked
  observeEvent(
    input$do,{
      output$genes<- renderTable(filtered_dataset)
      write.csv(filtered_dataset,"list.csv")
    })
    
    
  
  
  
  
  
})