## gtrends_country_search_ratios.R
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

## define a function to work with the google trends object, specifically the interest_by_country data.frame
gtrends_country_search_ratios_func <- function(dat, location1, location2){
  as.numeric(dat$interest_by_country$hits[dat$interest_by_country$location==location1])/as.numeric(dat$interest_by_country$hits[dat$interest_by_country$location==location2])
}

##########################################################################
## country pair ratios: human rights
##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")


##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")


##
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2012-01-01_2016-12-31_saved_2022-05-12.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")

##
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2013-01-01_2017-12-31_saved_2022-05-12.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")

##
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2014-01-01_2018-12-31_saved_2022-05-12.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")

## 
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-12.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Uganda", location2="United States")



##########################################################################
## country pair ratios: derechos humanos
##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2012-01-01_2016-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Guatemala", location2="Argentina")

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2013-01-01_2017-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Guatemala", location2="Argentina")

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2014-01-01_2018-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Guatemala", location2="Argentina")

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Guatemala", location2="Argentina")


## Guatemala vs. Spain
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-11.RDS")
gtrends_country_search_ratios_func(dat=dat, location1="Guatemala", location2="Spain")

