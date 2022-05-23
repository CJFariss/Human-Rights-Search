## google_search_data_country_Rplot_function.R
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


#files_names <- list.files("Data_output_location_search_lists")
#files_names <- list.files("Data_output_location_search_lists_lowsearch")
#files_names

#temp <- readRDS(paste("Data_output_location_search_lists/", files_names[17], sep=""))

#dat_list <- list()
#ISO_location <- c()
#for(j in 1:length(temp)){
#  dat_list[[j]] <- try(temp[[j]]$interest_over_time)
#  ISO_location[j] <- try(dat_list[[j]]$geo[1])
#}
#ISO_location

#COUNTRY_location <- countrycode(ISO_location, origin="iso2c", destination="country.name")
#COUNTRY_location


gsearch_cy_list_function <- function(cy_data_list, global_data_list){
  
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

    temp <- try(cy_data_list[[i]]$interest_over_time)
    
    
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    temp$hits <- temp$hits * (language_world$hits[i]/100)
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    temp$ISO <- language_ISO[i]
    temp$CCODE <- language_CCODE[i]
    temp$location <- language_world$location[i]
    
    temp_cy[[i]] <- temp
  
  }
  
  #cy_dat <- do.call("rbind", temp_cy)
  return(temp_cy)
}



google_search_data_country_Rplot_function <- function(dat_list, file_name="temp.pdf"){
  
  pdf(paste(file_name, sep=""), height=6, width=6)
  
  par(mfrow=c(4,3), mar=c(2,2.5,1,.5))
  for(i in 1:length(dat_list)){
  if(length(dat_list[[1]])>1){
    LOCATION <- dat_list[[i]]$location[i][1]
    LOCATION <- gsub("Côte d’Ivoire", "Cote d'Ivoire", LOCATION)
    plot(dat_list[[i]]$hits, main=LOCATION, lwd=1, col=grey(.75), ylim=c(0, 100), xaxt="n", yaxt="n", type="n")
    
    id2012 <- which(as.Date(dat_list[[i]]$date) > as.Date("2011-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2012-12-31"))
    id2013 <- which(as.Date(dat_list[[i]]$date) > as.Date("2012-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2013-12-31"))
    id2014 <- which(as.Date(dat_list[[i]]$date) > as.Date("2013-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2014-12-31"))
    id2015 <- which(as.Date(dat_list[[i]]$date) > as.Date("2014-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2015-12-31"))
    id2016 <- which(as.Date(dat_list[[i]]$date) > as.Date("2015-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2016-12-31"))
    id2017 <- which(as.Date(dat_list[[i]]$date) > as.Date("2016-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2017-12-31"))
    id2018 <- which(as.Date(dat_list[[i]]$date) > as.Date("2017-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2018-12-31"))
    id2019 <- which(as.Date(dat_list[[i]]$date) > as.Date("2018-12-31") & as.Date(dat_list[[i]]$date) <= as.Date("2019-12-31"))
    
    if(length(id2013)>0) polygon(x=c(min(id2013), min(id2013), max(id2013), max(id2013)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    if(length(id2015)>0) polygon(x=c(min(id2015), min(id2015), max(id2015), max(id2015)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    if(length(id2017)>0) polygon(x=c(min(id2017), min(id2017), max(id2017), max(id2017)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    if(length(id2019)>0) polygon(x=c(min(id2019), min(id2019), max(id2019), max(id2019)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    box()
    
    lines(dat_list[[i]]$hits, lwd=1, col="#bdd7e7")
    axis(side=2, at=c(0,25,50,75,100), las=2)
    if(length(id2013)>0) axis(side=1, at=c(median(id2013)), labels=c(2013), las=1)
    if(length(id2015)>0) axis(side=1, at=c(median(id2015)), labels=c(2015), las=1)
    if(length(id2017)>0) axis(side=1, at=c(median(id2017)), labels=c(2017), las=1)
    if(length(id2019)>0) axis(side=1, at=c(median(id2019)), labels=c(2019), las=1)
    #axis(side=1, at=c(median(id2015), median(id2017), median(id2019)), labels=c(2015, 2017, 2019), las=1)
    model <- bcp(y= dat_list[[i]]$hits)
    lines(model$posterior.mean, lwd=.75, col="#08519c")
  }
  }
  dev.off()
  
}

##########################################################################
## "human rights"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_2012-01-01_2016-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "human rights"), "_country_week_time_series_", gsub(" ", "_", "2012-01-01 2016-12-31"), ".pdf", sep=""))

## "human rights"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_2013-01-01_2017-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "human rights"), "_country_week_time_series_", gsub(" ", "_", "2013-01-01 2017-12-31"), ".pdf", sep=""))

## "human rights"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_2014-01-01_2018-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "human rights"), "_country_week_time_series_", gsub(" ", "_", "2014-01-01 2018-12-31"), ".pdf", sep=""))

## "human rights"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "human rights"), "_country_week_time_series_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))

## "human rights" lowsearch=FALSE
location_data <- readRDS("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-12.RDS")
global_data <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-12.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "human rights"), "_country_week_time_series_lowsearch_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))


##########################################################################
## "derechos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_derechos_humanos_2012-01-01_2016-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "derechos humanos"), "_country_week_time_series_", gsub(" ", "_", "2012-01-01 2016-12-31"), ".pdf", sep=""))

## "derechos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_derechos_humanos_2013-01-01_2017-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "derechos humanos"), "_country_week_time_series_", gsub(" ", "_", "2013-01-01 2017-12-31"), ".pdf", sep=""))

## "derechos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_derechos_humanos_2014-01-01_2018-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "derechos humanos"), "_country_week_time_series_", gsub(" ", "_", "2014-01-01 2018-12-31"), ".pdf", sep=""))

## "derechos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "derechos humanos"), "_country_week_time_series_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))

## "derechos humanos" lowsearch=FALSE
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "derechos humanos"), "_country_week_time_series_lowsearch_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))


##########################################################################
## "direitos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_direitos_humanos_2012-01-01_2016-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_direitos_humanos_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "direitos humanos"), "_country_week_time_series_", gsub(" ", "_", "2012-01-01 2016-12-31"), ".pdf", sep=""))

## "direitos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_direitos_humanos_2013-01-01_2017-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_direitos_humanos_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "direitos humanos"), "_country_week_time_series_", gsub(" ", "_", "2013-01-01 2017-12-31"), ".pdf", sep=""))

## "direitos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_direitos_humanos_2014-01-01_2018-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_direitos_humanos_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "direitos humanos"), "_country_week_time_series_", gsub(" ", "_", "2014-01-01 2018-12-31"), ".pdf", sep=""))

## "direitos humanos"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_direitos_humanos_2015-01-01_2019-12-31_saved_2022-05-10.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_direitos_humanos_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "direitos humanos"), "_country_week_time_series_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))


##########################################################################
## "droit"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_droit_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_droit_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "droit"), "_country_week_time_series_", gsub(" ", "_", "2012-01-01 2016-12-31"), ".pdf", sep=""))

## "droit"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_droit_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_droit_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "droit"), "_country_week_time_series_", gsub(" ", "_", "2013-01-01 2017-12-31"), ".pdf", sep=""))

## "droit"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_droit_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_droit_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "droit"), "_country_week_time_series_", gsub(" ", "_", "2014-01-01 2018-12-31"), ".pdf", sep=""))

## "droit"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_droit_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_droit_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "droit"), "_country_week_time_series_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))


##########################################################################
## "huquq alansan"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_huquq_alansan_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_huquq_alansan_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "huquq alansan"), "_country_week_time_series_", gsub(" ", "_", "2012-01-01 2016-12-31"), ".pdf", sep=""))

## "huquq alansan"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_huquq_alansan_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_huquq_alansan_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "huquq alansan"), "_country_week_time_series_", gsub(" ", "_", "2013-01-01 2017-12-31"), ".pdf", sep=""))

## "huquq alansan"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_huquq_alansan_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_huquq_alansan_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "huquq alansan"), "_country_week_time_series_", gsub(" ", "_", "2014-01-01 2018-12-31"), ".pdf", sep=""))

## "huquq alansan"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_huquq_alansan_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_huquq_alansan_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "huquq alansan"), "_country_week_time_series_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))


##########################################################################
## "Amnesty International"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_Amnesty_International_2012-01-01_2016-12-31_saved_2022-05-16.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_Amnesty_International_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "Amnesty International"), "_country_week_time_series_", gsub(" ", "_", "2012-01-01 2016-12-31"), ".pdf", sep=""))

## "Amnesty International"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_Amnesty_International_2013-01-01_2017-12-31_saved_2022-05-16.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_Amnesty_International_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "Amnesty International"), "_country_week_time_series_", gsub(" ", "_", "2013-01-01 2017-12-31"), ".pdf", sep=""))

## "Amnesty International"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_Amnesty_International_2014-01-01_2018-12-31_saved_2022-05-16.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_Amnesty_International_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "Amnesty International"), "_country_week_time_series_", gsub(" ", "_", "2014-01-01 2018-12-31"), ".pdf", sep=""))

## "Amnesty International"
location_data <- readRDS("Data_output_location_search_lists/gsearch_location_data_lists_Amnesty_International_2015-01-01_2019-12-31_saved_2022-05-16.RDS")
global_data <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_Amnesty_International_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "Amnesty International"), "_country_week_time_series_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))

## "Amnesty International" lowsearch=FALSE
location_data <- readRDS("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_Amnesty_International_2015-01-01_2019-12-31_saved_2022-05-12.RDS")
global_data <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_Amnesty_International_2015-01-01_2019-12-31_saved_2022-05-12.RDS")
out_dat <- gsearch_cy_list_function(cy_data_list=location_data, global_data_list=global_data)
google_search_data_country_Rplot_function(dat_list=out_dat, file_name=paste("Rplots_country_search_ranks/", gsub(" ", "_", "Amnesty International"), "_country_week_time_series_lowsearch_", gsub(" ", "_", "2015-01-01 2019-12-31"), ".pdf", sep=""))
