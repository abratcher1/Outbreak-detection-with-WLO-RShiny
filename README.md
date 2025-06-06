# Outbreak Detection with Weighted Log Odds (WLO) RShiny App
An RShiny dashboard that compares distinctive terms in open text fields across two different time periods. 

**Purpose**: To identify outbreaks or other important trends <br />
**Process**: Identification of how the subject matter of open text fields changes from a baseline period to a period of interest<br />
**Method**:  Weighted Log Odds (WLO)


A note on WLO: <br />
For this code, a WLO approach is used to identify distinctive terms in each period. This technique is applied to tokenized data pulled from an open text field. This measure compares two periods of time by calculating the odds of a term occurring in one period compared to the other, logging this odds ratio, and weighting the result according to its variance using a Bayesian Dirichlet Prior. Ultimately, the resulting WLO is a z-score for the log-odds-ratio of the term comparing a period of interest to a baseline period.  <br />
*TLDR*: The higher the WLO, the more distinctive the term is to that period compared to the other. 


### Code Structure
To run the code as is, you will need a data set saved as 'raw_data' in a 'data' folder with the following structure:

| date   | chief_complaint           | sex          | age          |
|--------|--------------------------:|-------------:|-------------:|
| date   | free text	               | “M” or “F”   |	integer      |


*Note*: This code was developed using Chief Complaints from the NSSP system: https://www.cdc.gov/nssp/index.html

The included code contains two major steps:  

  1. Data cleaning and tokenization (i.e. splitting the text field into separate words) <br />
     -'Asyndromic Anomaly Detection_cleaning_tokenization' file
  2. Dashboard creation, including calculating WLO for each token <br />
     -'ui' and 'server' files

### Example Code

A slightly modified example is provided in the /example file. 

This example is written for the Covid Vaccine Tweets available at https://www.kaggle.com/datasets/kaushiksuresh147/covidvaccine-tweets. 

We subsetted the columns so that the data has the following structure: 

| user followers   | user_verified       | date         |text                      |
|------------------|--------------------:|-------------:|-------------------------:|
| integer          | “TRUE” or “FALSE”   | date         | free text	               |
