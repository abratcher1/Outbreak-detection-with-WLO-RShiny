# RShiny-WLO-Anomaly-Detection
An RShiny dashboard that compares distinctive terms in open text fields across two different time periods. 

Purpose: To identify outbreaks or other important trends 
Process: Identification of how the subject matter of open text fields changes from a baseline period to a period of interest
Method:  Weighted Log Odds (WLO)


A note on WLO:
To identify distinctive terms in each period, a Weighted Log-Odds (WLO) approach is used on tokenized data pulled from an open text field. This measure compares two periods of time by calculating the odds of a term occurring in one period compared to the other, logging this odds ratio, and weighting the result according to its variance using a Bayesian Dirichlet Prior. Ultimately, the resulting WLO is a z-score for the log-odds-ratio of the term comparing a period of interest to a baseline period. 

**TLDR**: The higher the WLO, the more distinctive the term is to that period compared to the other. 


## Code Structure
The included code contains two major steps:  

  1. Data cleaning and tokenization
  2. Dashboard creation



## Example
The included code is applicable to a dataset on tweets from January 2020 to June 2021 that reference COVID-19 or other related words. 
  Dataset:     "full_dataset.tsv.gz" 
  Location:    https://zenodo.org/records/5090588
  Description: https://www.mdpi.com/2673-3986/2/3/24
