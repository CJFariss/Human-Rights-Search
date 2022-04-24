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

pts <- read.csv("Data_input/PTS-2020.csv")

#pts_names <- unique(pts$Country)
#YEAR <- 1961:2021

value <- c()
for(i in 1892:nrow(pts)){
  
  YEAR <- pts$Year[i]
  COUNTRY <- pts$Country[i]
  
  test <- try(readLines(paste("https://www.amnesty.org/en/search/",COUNTRY,"/?year=",YEAR,"&language=en", sep="")))
  temp <- gsub("\t", "", test[500])
  temp2 <- unlist(strsplit(temp, " "))
  value[i] <- as.numeric(temp2[1])
}

pts_2015 <- subset(pts, Year>=2015)
dim(pts_2015)
value_2015 <- c()
for(i in 1:nrow(pts_2015)){
  
  YEAR <- pts_2015$Year[i]
  COUNTRY <- pts_2015$Country[i]
  
  test <- try(readLines(paste("https://www.amnesty.org/en/search/",COUNTRY,"/?year=",YEAR,"&language=en", sep="")))
  temp <- gsub("\t", "", test[500])
  temp2 <- unlist(strsplit(temp, " "))
  value_2015[i] <- as.numeric(temp2[1])
}

boxplot(sqrt(pts_2015$amnesty_report_count) ~ pts_2015$PTS_S)
boxplot(sqrt(pts_2015$amnesty_report_count) ~ pts_2015$PTS_A)
boxplot(sqrt(pts_2015$amnesty_report_count) ~ pts_2015$PTS_H)
write.csv(pts_2015, "amnesty_report_count_2015.csv", row.names=F)


data <- readRDS("Data_input/HumanRightsProtectionScores_v4.01.Rdata")

data$amnesty_report_count <- NA

data$country_name_amnesty <- data$country_name
data$country_name_amnesty[data$country_name=="Myanmar (Burma) "] <- "Myanmar"

#data$amnesty_report_count[data$country_name=="Myanmar (Burma) " & data$YEAR==2019] <- NA

#data <- try(read.csv("/Users/christopherfariss/Dropbox/GOOGLEBOOK/SearchforRights\ 2/Data/HumanRightsProtectionScores_v4.01_amnesty_report_count.csv"))

count <- 0
for(i in 1:nrow(data)){
  
  YEAR <- data$YEAR[i]
  COUNTRY <- data$country_name_amnesty[i]
  
  test <- temp <- temp2 <- c()
  if(is.na(data$amnesty_report_count[i]) & data$YEAR[i]>=1961 & data$YEAR[i]>=1961){
    test <- try(readLines(paste("https://www.amnesty.org/en/search/",COUNTRY,"/?year=",YEAR,"&language=en", sep="")))
    if(length(test)>0){
      temp <- gsub("\t", "", test[500])
      temp2 <- unlist(strsplit(temp, " "))
      data$amnesty_report_count[i] <- as.numeric(temp2[1])
      count <- count + 1
    }
  }
}

count
summary(data)

year_cor <- c()
YEAR <- 1961:2019
for(i in 1:length(YEAR)){
  year_cor[i] <- cor(data$theta_mean[data$YEAR==YEAR[i]], data$amnesty_report_count[data$YEAR==YEAR[i]], use="pairwise")
}

dat <- data.frame(year=1961:2019, year_cor)
dat
plot(dat$year, dat$year_cor, type="l", ylim=c(-.7,0))
points(dat$year, dat$year_cor,)

write.csv(data, paste("Data/HumanRightsProtectionScores_v4.01_amnesty_report_count",".csv"), row.names=FALSE)

ctabs <- xtabs(data$amnesty_report_count ~ data$YEAR + data$country_name) 
ctabs
ctabs[,'Uganda']
ctabs[,'Guatemala']
ctabs[,'Argentina']
ctabs[,'United Kingdom']



count <- 0
year_amnesty_report_count <- c()
YEAR <- 1961:2019
for(i in 1:length(YEAR)){
  
  test <- temp <- temp2 <- c()
    test <- try(readLines(paste("https://www.amnesty.org/en/search/?year=",YEAR[i],"&language=en", sep="")))
    if(length(test)>0){
      temp <- gsub("\t", "", test[500])
      temp2 <- unlist(strsplit(temp, " "))
      year_amnesty_report_count[i] <- as.numeric(temp2[1])
      count <- count + 1
    }
  
}
