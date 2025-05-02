library(shiny)
library(readr)
library(tidyverse)
library(ggplot2)
library(tidytext)

cc_unigrams <- read_csv("data/cc_unigrams.csv")
cc_bigrams <- read_csv("data/cc_bigrams.csv")


function(input, output) {
  
  source("f_log_odds_original.R")
  
  period_names <- c("pre" = "Baseline", "post" = "Period of Interest")
  
  pal <- c("antiquewhite3", "honeydew3")
  
    #WLO Math
            
    output$distPlot_uni <- renderPlot({
      
    cc_unigrams$period <- ifelse(cc_unigrams$date >= input$predateRange[1] & cc_unigrams$date <= input$predateRange[2], "pre", "NA")
    cc_unigrams$period <- ifelse(cc_unigrams$date >= input$postdateRange[1] & cc_unigrams$date <= input$postdateRange[2], "post", cc_unigrams$period)
    
    
    cc_unigrams <- subset(cc_unigrams, sex == input$checkbox_sex)
    cc_unigrams <- subset(cc_unigrams, age_group == input$checkbox_age)
    
    
     unigrams_wlo <-  cc_unigrams %>%
                          filter(period != "NA") %>%
                          group_by(unigram, period) %>%
                          summarise(n = sum(n)) %>%
                          ungroup() %>%
                          bind_log_odds_original(period, unigram, n) %>%
                          rename(log_odds_weighted = log_odds) %>%
                          arrange(-log_odds_weighted) %>%
                          group_by(period) %>%
                          mutate(
                            period = factor(period, levels = c("pre", "post")), 
                            ngram_original = unigram, 
                            ngram = reorder_within(unigram, log_odds_weighted, period)
                          ) %>%
                         slice_max(log_odds_weighted, n = 10) %>%
                          ungroup() 

                        
   #WLO Plots
    
    ggplot(data = unigrams_wlo, aes(x = reorder(unigram, log_odds_weighted), log_odds_weighted, fill = period)) + 
          geom_col(show.legend = FALSE, color = "black") + 
          scale_fill_manual(values = pal) + 
          facet_wrap(~period, scales = "free_y", nrow = 2, labeller = as_labeller(period_names)) + 
          coord_flip() + 
          scale_x_reordered() +
          scale_y_continuous(expand = expansion(mult = c(0, 0.1))) + 
          labs(
              title = " ", 
              x = NULL, 
              y = "Log odds ratio, weighted by Informative Dirichlet prior"
             ) + 
          theme_minimal() + 
            theme(
              panel.background = element_rect(fill = "white"),
              strip.text = element_text(size = 20, face = "bold"), 
              axis.title.x = element_text(size = 16),
              axis.text.x = element_text(color = "black", size = 16),
              axis.text.y = element_text(color = "black", size = 12)
              )
     

                 
})
    
    output$distPlot_bi <- renderPlot({
      
      cc_bigrams$period <- ifelse(cc_bigrams$date >= input$predateRange[1] & cc_bigrams$date <= input$predateRange[2], "pre", "NA")
      cc_bigrams$period <- ifelse(cc_bigrams$date >= input$postdateRange[1] & cc_bigrams$date <= input$postdateRange[2], "post", cc_bigrams$period)
      
      cc_bigrams <- subset(cc_bigrams, sex == input$checkbox_sex)
      cc_bigrams <- subset(cc_bigrams, age_group == input$checkbox_age)
      
      
    bigrams_wlo <-  cc_bigrams %>%
      filter(period != "NA") %>%
      group_by(bigram, period) %>%
      summarise(n = sum(n)) %>%
      ungroup() %>%
      bind_log_odds_original(period, bigram, n) %>%
      rename(log_odds_weighted = log_odds) %>%
      arrange(-log_odds_weighted) %>%
      group_by(period) %>%
      mutate(
        period = factor(period, levels = c("pre", "post")), 
        ngram_original = bigram, 
        ngram = reorder_within(bigram, log_odds_weighted, period)
      ) %>%
      slice_max(log_odds_weighted, n = 10) %>%
      ungroup() 
    

    
    ggplot(data = bigrams_wlo, aes(x = reorder(bigram, log_odds_weighted), log_odds_weighted, fill = period)) + 
      geom_col(show.legend = FALSE, color = "black") + 
      scale_fill_manual(values = pal) + 
      facet_wrap(~period, scales = "free_y", nrow = 2, labeller = as_labeller(period_names)) + 
      coord_flip() + 
      scale_x_reordered() + 
      scale_y_continuous(expand = expansion(mult = c(0, 0.1))) + 
      labs(
        title = " ", 
        x = NULL, 
        y = "Log odds ratio, weighted by Informative Dirichlet prior"
      ) + 
      theme_minimal() + 
      theme(
        panel.background = element_rect(fill = "white"),
        strip.text = element_text(size = 20, face = "bold"), 
        axis.title.x = element_text(size = 16),
        axis.text.x = element_text(color = "black", size = 16),
        axis.text.y = element_text(color = "black", size = 12)
      )
    
    
})
    
}



  



