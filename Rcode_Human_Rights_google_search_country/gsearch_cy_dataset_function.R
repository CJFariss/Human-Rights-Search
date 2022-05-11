## gsearch_cy_dataset_function.R
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

## human rights search as a topic
#https://trends.google.com/trends/explore?q=%2Fm%2F03ll3&geo=US

## human rights search as a search term
#https://trends.google.com/trends/explore?geo=US&q=Human%20rights

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


## make a color vector for polots
COLORS <- c("#fdae61", "#a6cee3", "#1f78b4", "#b2df8a", "#33a02c")


## ------------------------------------------------------------ ##
## generic search function to create country-year cy datasets
##gsearch_cy_dataset_function <- function(language_term="human rights", language_time="2013-01-01 2017-12-31"){
gsearch_cy_dataset_function <- function(data_list){

  temp_cy <- list()
  
  ## function arguments for internal function testing
  for(i in 1:length(data_list)){
    
    temp <- data_list[[i]]$interest_over_time
    
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    temp$hits <- temp$hits * (language_world$hits[i]/100)
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    year <<- as.numeric(names(table(temp[c("year")])))
    hits_mean <- sapply(1:length(year), function(j){mean(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_median <- sapply(1:length(year), function(j){median(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_max <- sapply(1:length(year), function(j){max(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_sd <- sapply(1:length(year), function(j){sd(temp[c("year","hits")]$hits[temp$year==year[j]])})
    
    ISO <- temp$geo[1]
    #CCODE <- language_CCODE[i]
    #location <- language_location[i]
    
    temp_cy[[i]] <- data.frame(year, ISO, hits_mean, hits_median, hits_max, hits_sd)
  }
  
  cy_dat <- do.call("rbind", temp_cy)
  return(cy_dat)
}

data <- readRDS("Data_output_search_lists/gsearch_location_data_lists_human_rights_2012-01-01_2016-12-31_saved_2022-05-10.RDS")
out_dat <- gsearch_cy_dataset_function(data_list=data)


for(j in 1:length(TIME)){
  out_dat <- gsearch_cy_dataset_function(language_term=TERMS[i], language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  write.csv(out_dat, paste("Data_output_search_cy_datasets/gsearch_cy_data_", gsub(" ", "_", TERMS[i]), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)

}



## "huquq alansan"
for(j in 1:length(TIME)){
  out_dat <- gsearch_cy_dataset_function(language_term="حقوق الانسان", language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  write.csv(out_dat, paste("Data_output_search/gsearch_cy_data_", gsub(" ", "_", "huquq alansan"), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)
  
}

# "Amnesty International"
for(j in 1:length(TIME)){
#for(j in c(1,4)){
  out_dat <- gsearch_cy_dataset_function(language_term="Amnesty International", language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  write.csv(out_dat, paste("Data_output_search/gsearch_cy_data_", gsub(" ", "_", "Amnesty International"), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)
  
}
