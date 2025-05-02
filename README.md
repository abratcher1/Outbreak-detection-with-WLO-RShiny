# RShiny-WLO-Anomaly-Detection
An RShiny dashboard that compares distinctive terms in open text fields across two different time periods. 

**Purpose**: To identify outbreaks or other important trends <br />
**Process**: Identification of how the subject matter of open text fields changes from a baseline period to a period of interest<br />
**Method**:  Weighted Log Odds (WLO)


*A note on WLO*: <br />
For this code, a WLO approach is used to identify distinctive terms in each period. This technique is applied to tokenized data pulled from an open text field. This measure compares two periods of time by calculating the odds of a term occurring in one period compared to the other, logging this odds ratio, and weighting the result according to its variance using a Bayesian Dirichlet Prior. Ultimately, the resulting WLO is a z-score for the log-odds-ratio of the term comparing a period of interest to a baseline period. 

**TLDR**: The higher the WLO, the more distinctive the term is to that period compared to the other. 


## Code Structure
To run the code as is, you will need a dataset with the following structure saved as 'raw_data' in the 'data' folder:

| date   | chief_complaint           | sex          | age          |
|--------|--------------------------:|-------------:|-------------:|
| date   | free text	               | “M” or “F”   |	integer      |


The included code contains two major steps:  

  1. Data cleaning and tokenization (i.e. splitting the text field into separate words)
     -'Asyndromic Anomaly Detection_cleaning_tokenization' file
  2. Dashboard creation, including calculating WLO for each token
     -'ui' and 'server' files


