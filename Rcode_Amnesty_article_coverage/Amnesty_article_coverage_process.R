## Amnesty_article_coverage_process.R
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


## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

## load HRPS data for matching
data <- readRDS("Data_input/HumanRightsProtectionScores_v4.01.Rdata")

## add new variable for report counts
data$amnesty_report_count <- NA

## add new variable for country name associated with Amnesty report count
data$country_name_amnesty <- data$country_name
data$country_name_amnesty[data$country_name=="Myanmar (Burma)"] <- "Myanmar"

#data$amnesty_report_count[data$country_name=="Myanmar (Burma) " & data$YEAR==2019] <- NA


file_list <- list.files("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files")

length(file_list)

file_list[1:6]

YEAR <- 1999
COUNTRY <- "Ukraine"

YEAR
COUNTRY


test <- try(readLines(paste("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files/Amnesty_source_", COUNTRY,"_",YEAR,".txt",sep="")))


## define a function to remove some characters using the gsub() function
textEdit <- function(text.vector){
  TEXT <- text.vector
  ## ----- remove stuff ---------- #
  TEXT <- gsub("\t", "", TEXT) # replace tabs
  TEXT <- gsub("https:.*$", "", TEXT) # replace just the urls/http/www part
  TEXT <- gsub("[[:punct:]]", "", TEXT) # remove all punctuation
  TEXT <- gsub("[^\x20-\x7F\x0D\x0A]", "", TEXT) # remove all non-ascii characters
  TEXT <- gsub("^\\s+|\\s+$", "", TEXT) # remove extra leading and trailing whitespace
  TEXT <- gsub("[[:alpha:]]", "", TEXT)
  
  ## ----- function return ---------- #
  return(TEXT)
} ## end function

## inspect test object
length(test)
grep(paste("results for", sep=""), test)

step1 <- test[grep(paste("results for", sep=""), test)]
step1

step2 <- textEdit(step1)
step2

step3 <- strsplit(step2, split=" ")
step3

step3[[1]]
step3[[2]]




out <- lapply(1:nrow(data), function(i){
  
  #temp <- list()
  
  YEAR <- data$YEAR[i]
  COUNTRY <- data$country_name_amnesty[i]
  
  #if(is.na(data$amnesty_report_count[i]) & data$YEAR[i]>=1961){
    test <- try(readLines(paste("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files/Amnesty_source_", COUNTRY,"_",YEAR,".txt",sep="")), silent=TRUE)
    if(length(test)>0){
      step1 <- test[grep(paste("results for", sep=""), test)]
      step1
      
      step2 <- textEdit(step1)
      step2
      
      step3 <- strsplit(step2, split=" ")
      step3
      
      #temp <- step3
      temp <- ifelse(length(step3)>0, step3[[1]][1], NA)
      
    #} 
  }
  return(temp)
})

length(out)

data$amnesty_report_count <- as.numeric(unlist(out))

write.csv(data, "Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
write.csv(data, "Data_input/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")

data2 <- read.csv("Data_input/HumanRightsProtectionScores_v4.01_amnesty_report_count.csv")

cor(data$amnesty_report_count, data2$amnesty_report_count, use="pairwise")
table(data$amnesty_report_count, data2$amnesty_report_count)
table(data$amnesty_report_count - data2$amnesty_report_count)
