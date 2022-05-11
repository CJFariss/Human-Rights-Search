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
gsearch_cy_dataset_function <- function(){

  ## function arguments for internal function testing
  
  language_world <- gtrends(language_term, time=language_time, low_search_volume=TRUE)
  language_world <- subset(language_world$interest_by_country, !is.na(hits))
  
  language_world$hits[language_world$hits=="<1"] <- .5
  language_world$hits <- as.numeric(language_world$hits)
  language_world <- subset(language_world, !is.na(hits))
  
  ## fix issue with Namibia
  #language_world <- subset(language_world, location!="Namibia")
  ## fix Kosovo
  #language_world <- subset(language_world, location!="Kosovo")
  
  data("countries")
  #countries$country_code
  

  language_ISO <- countrycode(language_world$location, origin="country.name", destination="iso2c")
  language_CCODE <- countrycode(language_world$location, origin="country.name", destination="cown")

  language_world <- language_world[language_ISO %in% countries$country_code,]
  
  language_location <- language_world$location
  
  ## fix Kosovo
  #language_ISO[language_CCODE==347] <- "XK"
  ## fix Serbia
  #language_CCODE[language_ISO=="RS"] <- 345
  ## fix Vietnam
  #language_CCODE[language_CCODE==817] <- 816
  
  
  language_world <- language_world[!is.na(language_ISO),]
  
  N <- nrow(language_world)
  
  language_ISO <- language_ISO[!is.na(language_ISO)]
  language_CCODE <- language_CCODE[!is.na(language_ISO)]
  
  
  cy_temp <- lapply(1:N, function(i){
    
    temp <- try(gtrends(language_term, geo=c(language_ISO[i]), time=language_time, low_search_volume=TRUE)$interest_over_time)
    
    if(length(temp)>1){
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
    location <- language_location[i]
    
    temp_cy <- data.frame(year, ISO, CCODE, location, hits_mean, hits_median, hits_max, hits_sd)
    return(temp_cy)
    }else{
    
      temp_cy <- data.frame(year=NA, ISO=language_ISO[i], CCODE=NA, location=NA, hits_mean=NA, hits_median=NA, hits_max=NA, hits_sd=NA)
      return(temp_cy)
      
    }
  
  })
  
  cy_dat <- do.call("rbind", cy_temp)
  #cy_dat <- cy_dat[order(cy_dat$ISO, cy_dat$year),]
  return(cy_dat)
}


## select serach terms for cy dataset creation
TERMS <- c(URLdecode("%2Fm%2F03ll3")) ## human rights topic
TERMS <- c(URLdecode("%2Fm%2F0cttd")) ## torture topic
TERMS
TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "hak asasi Manusia", "人权", "droits")
TERMS


## select time range
TIME <- c()
TIME[1] <- "2012-01-01 2016-12-31"
TIME[2] <- "2013-01-01 2017-12-31"
TIME[3] <- "2014-01-01 2018-12-31"
TIME[4] <- "2015-01-01 2019-12-31"
TIME

TERMS <- c("human rights", "derechos humanos", "direitos humanos", "droit")
TERMS

i <- 1
#j <- 1
for(j in 1:length(TIME)){
  out_dat <- gsearch_cy_dataset_function(language_term=TERMS[i], language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  write.csv(out_dat, paste("Data_output_search/gsearch_cy_data_", gsub(" ", "_", TERMS[i]), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)

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
