## Amnesty_article_coverage_scrape.R
##########################################################################
##
## Authors: Geoff Dancy and Christopher J. Fariss
##
## Title: "The Search for Human Rights: A Global Analysis Using Google Data"
##
## Contact Information: 
##  Geoff Dancy <gdancy@tulane.edu>
##  Christopher J. Fariss <cjf0006@gmail.com>
##  
##  Copyright (c) 2022, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
## For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
##  All rights reserved. 
##
##########################################################################


## Do this (set to TRUE) to load libraries using the version from when the scripts were originally run
if(FALSE){
  ## load an older version of the libraries
  remotes::install_github('CredibilityLab/groundhog')
  library(groundhog)
  pkgs <- c("rvest")
  groundhog.library(pkgs,'2022-04-19')
} else{
  ## or load the more recent version of the libraries
  install.packages("rvest")
  library(rvest)
}

## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

## load HRPS data for matching
data <- readRDS("Data_input/HumanRightsProtectionScores_v4.01.Rdata")

## add new variable for report counts
data$amnesty_report_count <- NA

## add new variable for country name associated with Amnesty report count
data$country_name_amnesty <- data$country_name
data$country_name_amnesty[data$country_name=="Myanmar (Burma) "] <- "Myanmar"

#data$amnesty_report_count[data$country_name=="Myanmar (Burma) " & data$YEAR==2019] <- NA

COUNTRY <- "Ukraine"
YEAR <- 1999
test <- try(readLines(paste("https://www.amnesty.org/en/search/",COUNTRY,"/?year=",YEAR,"&language=en", sep="")))

## inspect test object
length(test)
grep(paste("results for", sep=""), test)
test[grep(paste("results for", sep=""), test)]
try(writeLines(text=test, con=paste("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files/Amnesty_source_", COUNTRY,"_",YEAR,".txt",sep="")))


## loop through COUNTRY-YEAR combinations for scrapping at https://www.amnesty.org
## Warning: this code takes a while and generates quite a few errors and warings, hence the try() function
count <- 0
out <- lapply(1:nrow(data), function(i){
  
  YEAR <- data$YEAR[i]
  COUNTRY <- data$country_name_amnesty[i]
  
  test <- temp <- temp2 <- c()
  if(is.na(data$amnesty_report_count[i]) & data$YEAR[i]>=1961 & data$YEAR[i]>=1961){
    test <- try(readLines(paste("https://www.amnesty.org/en/search/",COUNTRY,"/?year=",YEAR,"&language=en", sep="")))
    if(length(test)>0){
      try(writeLines(text=test, con=paste("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files/Amnesty_source_", COUNTRY,"_",YEAR,".txt",sep="")))
      count <- count + 1
    }
  }
})

count
#summary(data)



count <- 0
#year_amnesty_report_count <- c()
YEAR <- 1961:2019
out <- lapply(1:length(YEAR), function(i){
  
  test <- temp <- temp2 <- c()
    test <- try(readLines(paste("https://www.amnesty.org/en/search/?year=",YEAR[i],"&language=en", sep="")))
    if(length(test)>0){
      try(writeLines(text=test, con=paste("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_YEAR/Amnesty_source_", YEAR,".txt",sep="")))
      count <- count + 1
    }
  
})
