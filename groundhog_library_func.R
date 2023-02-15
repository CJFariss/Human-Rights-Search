## groundhog_library_func.R
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
##
## https://groundhogr.com/
##  
## Check out the groundhog library for R: It's a very important resource for reproducibility. 
##
##########################################################################

groundhog_library_func <- function(groundhog=FALSE, regular_install=FALSE){
  ## Do this (set to TRUE) to load libraries using the version from when the scripts were originally run
  if(groundhog){
      ## load an older version of the libraries
      remotes::install_github('CredibilityLab/groundhog')
      library(groundhog)
      pkgs <- c("gtrendsR", "countrycode", "stm", "tm", "MASS", "bcp", "ngramr", "rvest", "plm", "lmtest", "WDI", "boot", "forecast", "acled.api", "ggplot2", "stargazer", "httr", "lubridate", "xtable")
      groundhog.library(pkgs,'2022-05-23')
  } else if(regular_install==TRUE){
      ## or install and load the more recent version of the libraries
      install.packages("gtrendsR", "countrycode", "stm", "tm", "MASS", "bcp", "ngramr", "rvest", "plm", "lmtest", "WDI", "boot", "forecast", "acled.api", "ggplot2", "stargazer", "httr", "lubridate", "xtable")
      library(gtrendsR)
      library(countrycode)
      library(stm)
      library(tm)
      library(MASS)
      library(bcp)
      library(ngramr)
      library(rvest)
      library(plm)
      library(lmtest)
      library(WDI)
      library(boot)
      library(forecast)
      library(acled.api)
      library(ggplot2)
      library(stargazer)
      library(httr)
      library(lubridate)
      library(xtable)
  } else{
      ## or just load the more recent version of the libraries
      library(gtrendsR)
      library(countrycode)
      library(stm)
      library(tm)
      library(MASS)
      library(bcp)
      library(ngramr)
      library(rvest)
      library(plm)
      library(lmtest)
      library(WDI)
      library(boot)
      library(forecast)
      library(acled.api)
      library(ggplot2)
      library(stargazer)
      library(httr)
      library(lubridate)
      library(xtable)
  }
}

