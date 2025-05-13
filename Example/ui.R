
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
                      "checkbox_ver", 
                      "User Verification", 
                      c( 
                        "Verified"    = "Verified", 
                        "Not Verified"  = "Not Verified"
                      ),
                      selected = c("Verified", "Not Verified")
                    ), 
                    
                
                    checkboxGroupInput( 
                      "checkbox_followers", 
                      "Number of Followers", 
                      c(  "0-249" = "0-249",
                          "250-999" = "250-999", 
                          "1,000-4,999" = "1,000-4,999", 
                          "5,000-9,999" = "5,000-9,999", 
                          "10,000-999,999" = "10,000-999,999", 
                          "1,000,000+" = "1,000,000" 
                      ),
                      selected = c("0-249", "250-999", "1,000-4,999", "5,000-9,999","10,000-999,999", "1,000,000")
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
