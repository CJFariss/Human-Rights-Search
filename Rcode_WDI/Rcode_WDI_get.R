## Rcode_WDI_get.R
##########################################################################
##
## Authors: Geoff Dancy and Christopher J. Fariss
##
## Title: "The Search for Human Rights: A Global Analysis Using Google Data"
##
## Contact Information: 
##  Geoff Dancy <geoff.dancy@utoronto.ca>
##  Christopher J. Fariss <cjf0006@gmail.com>
##  
##  Copyright (c) 2022, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
## For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
##  All rights reserved. 
##
##########################################################################

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

## grab WDI variables from the WDI api
dat <- WDI(indicator=c(GDP_growth_annual_percent="NY.GDP.MKTP.KD.ZG",
                       Foreign_direct_investment_net_inflows_percent_GDP="BX.KLT.DINV.WD.GD.ZS",
                       Population="SP.POP.TOTL"
            ),
  country="all", start=2012, end=2019)

## inspect 
dim(dat)
names(dat)
head(dat)


## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

write.csv(dat, file=paste("Data_input/WDI_data_2012_2019_saved_", current_date, ".csv", sep=""), row.names=FALSE)
