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
gsearch_cy_dataset_function <- function(cy_data_list, global_data_list){
  
  temp_cy <- list()
  
  language_world <- global_data_list
  
  language_world <- subset(language_world$interest_by_country, !is.na(hits))
  
  language_world$hits[language_world$hits=="<1"] <- .5
  language_world$hits <- as.numeric(language_world$hits)
  language_world <- subset(language_world, !is.na(hits))
  
  ## location to ISO and CCODE
  data("countries")
  countries$country_code
  
  language_ISO <- countrycode(language_world$location, origin="country.name", destination="iso2c")
  language_CCODE <- countrycode(language_world$location, origin="country.name", destination="cown")
  
  ## function arguments for internal function testing
  for(i in 1:length(cy_data_list)){
    
    temp <- cy_data_list[[i]]$interest_over_time
    
    
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    temp$hits <- temp$hits * (language_world$hits[i]/100)
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    year <<- as.numeric(names(table(temp[c("year")])))
    hits_mean <- sapply(1:length(year), function(j){mean(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_median <- sapply(1:length(year), function(j){median(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_max <- sapply(1:length(year), function(j){max(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_sd <- sapply(1:length(year), function(j){sd(temp[c("year","hits")]$hits[temp$year==year[j]])})
    
    ISO <- language_ISO[i]
    CCODE <- language_CCODE[i]
    location <- language_world$location[i]
    
    temp_cy[[i]] <- data.frame(year, ISO, CCODE, location, hits_mean, hits_median, hits_max, hits_sd)
  }
  
  #cy_dat <- do.call("rbind", temp_cy)
  return(temp_cy)
}


## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

##########################################################################
## "human rights" topic
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_topic_2012-01-01_2016-12-31_saved_2022-05-12.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_topic_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_dataset_function(cy_data_list=location_data, global_data_list=global_data)
cy_dat <- do.call("rbind", out_dat)
write.csv(cy_dat, paste("Data_output_search_cy_topic_datasets/gsearch_cy_data_", gsub(" ", "_", "human rights topic"), "_", gsub(" ", "_", "2012-01-01 2016-12-31"), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)

## "human rights" topic
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_topic_2013-01-01_2017-12-31_saved_2022-05-12.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_topic_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_dataset_function(cy_data_list=location_data, global_data_list=global_data)
cy_dat <- do.call("rbind", out_dat)
write.csv(cy_dat, paste("Data_output_search_cy_topic_datasets/gsearch_cy_data_", gsub(" ", "_", "human rights topic"), "_", gsub(" ", "_", "2013-01-01 2017-12-31"), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)

## "human rights" topic
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_topic_2014-01-01_2018-12-31_saved_2022-05-12.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_topic_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_dataset_function(cy_data_list=location_data, global_data_list=global_data)
cy_dat <- do.call("rbind", out_dat)
write.csv(cy_dat, paste("Data_output_search_cy_topic_datasets/gsearch_cy_data_", gsub(" ", "_", "human rights topic"), "_", gsub(" ", "_", "2014-01-01 2018-12-31"), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)

## "human rights" topic
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_topic_2015-01-01_2019-12-31_saved_2022-05-12.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_topic_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_dataset_function(cy_data_list=location_data, global_data_list=global_data)
cy_dat <- do.call("rbind", out_dat)
write.csv(cy_dat, paste("Data_output_search_cy_topic_datasets/gsearch_cy_data_", gsub(" ", "_", "human rights topic"), "_", gsub(" ", "_", "2015-01-01 2019-12-31"), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)
