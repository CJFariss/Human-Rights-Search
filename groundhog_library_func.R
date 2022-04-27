
groundhog_library_func <- function(groundhog=FALSE, regular_install=FALSE){
  ## Do this (set to TRUE) to load libraries using the version from when the scripts were originally run
  if(groundhog){
      ## load an older version of the libraries
      remotes::install_github('CredibilityLab/groundhog')
      library(groundhog)
      pkgs <- c("gtrendsR", "countrycode", "stm", "tm", "MASS", "bcp", "ngramr", "rvest")
      groundhog.library(pkgs,'2022-04-19')
  } else if(regular_install==TRUE){
      ## or install and load the more recent version of the libraries
      install.packages("gtrendsR", "countrycode", "stm", "tm", "MASS", "bcp", "ngramr", "rvest")
      library(gtrendsR)
      library(countrycode)
      library(stm)
      library(tm)
      library(MASS)
      library(bcp)
      library(ngramr)
      library(rvest)
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
  }
}
