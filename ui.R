
library(shiny)
library(bslib)
library(ggplot2)

# Define UI for application that draws a histogram
fluidPage(
    titlePanel("Distinctive Terms in Chief Complaints by Time Period"),
    
    sidebarLayout(
        sidebarPanel(dateRangeInput("predateRange", "Baseline Date Range:",
                    start = min(cc_unigrams$date), end = median(cc_unigrams$date)), 
                    dateRangeInput("postdateRange", "Period of Interest Date Range:",
                    start = median(cc_unigrams$date), end = max(cc_unigrams$date)),
                    
                    
                    checkboxGroupInput( 
                      "checkbox_sex", 
                      "Sex", 
                      c( 
                        "Male"    = "M", 
                        "Female"  = "F"
                      ),
                      selected = c("F", "M")
                    ), 
                    
                
                    checkboxGroupInput( 
                      "checkbox_age", 
                      "Age Group", 
                      c(  "0-4 years" = "0-4",
                          "5-11 years" = "5-11", 
                          "12-17 years" = "12-17", 
                          "18-44 years" = "18-44", 
                          "45-64 years" = "45-64", 
                          "65+ years" = "65+" 
                      ),
                      selected = c("0-4", "5-11", "12-17", "18-44","45-64", "65+")
                    ), 
                    ),
                      
         mainPanel(
            tabsetPanel(
              tabPanel("Unigrams", plotOutput("distPlot_uni")), 
              tabPanel("Bigrams", plotOutput("distPlot_bi")), 
         )
        )
    )
)  
