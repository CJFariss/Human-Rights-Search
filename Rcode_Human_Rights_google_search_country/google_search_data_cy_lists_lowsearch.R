## google_search_data_cy_lists_lowsearch.R


## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


## make a color vector for polots
COLORS <- c("#fdae61", "#a6cee3", "#1f78b4", "#b2df8a", "#33a02c")


## ------------------------------------------------------------ ##
## generic search function to create country-year cy datasets
gsearch_cy_search_lists_function <- function(language_term="human rights", language_time="2013-01-01 2017-12-31"){
  
  ## function arguments for internal function testing
  #language_term <- TERMS[1]
  #language_term
  #language_time <- "2013-01-01 2017-12-31"
  #language_time <- "2014-01-01 2016-12-31"
  #language_type <- "English"
  
  language_world <- gtrends(language_term, time=language_time, low_search_volume=FALSE)
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
  #language_CCODE <- countrycode(language_world$location, origin="country.name", destination="cown")
  
  language_world <- language_world[language_ISO %in% countries$country_code,]
  
  #language_location <- language_world$location
  
  ## fix Kosovo
  #language_ISO[language_CCODE==347] <- "XK"
  ## fix Serbia
  #language_CCODE[language_ISO=="RS"] <- 345
  ## fix Vietnam
  #language_CCODE[language_CCODE==817] <- 816
  
  language_world <- language_world[!is.na(language_ISO),]
  N <- nrow(language_world)
  language_ISO <- language_ISO[!is.na(language_ISO)]
  #language_CCODE <- language_CCODE[!is.na(language_ISO)]
  
  out <- lapply(1:N, function(i){
    #temp <- try(gtrends(language_term, geo=c(language_ISO[i]), time=language_time, low_search_volume=TRUE)$interest_over_time)
    temp <- try(gtrends(language_term, geo=c(language_ISO[i]), time=language_time, low_search_volume=TRUE))
    return(temp)
  })
  return(out)
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

i <- 4
j <- 1
for(j in 1:length(TIME)){
  out_dat <- gsearch_cy_search_lists_function(language_term=TERMS[i], language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  #write.csv(out_dat, paste("Data_output_search/gsearch_cy_data_", gsub(" ", "_", TERMS[i]), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".csv", sep=""), row.names=FALSE)
  saveRDS(out_dat, paste("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_", gsub(" ", "_", TERMS[i]), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".RDS", sep=""))
  
}


## "huquq alansan"
for(j in 1:length(TIME)){
  out_dat <- gsearch_cy_search_lists_function(language_term="حقوق الانسان", language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  saveRDS(out_dat, paste("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_", gsub(" ", "_", "huquq_alansan"), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".RDS", sep=""))
  
}

# "Amnesty International"
for(j in 1:length(TIME)){
  #for(j in c(1,4)){
  out_dat <- gsearch_cy_search_lists_function(language_term="Amnesty International", language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  saveRDS(out_dat, paste("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_", gsub(" ", "_", "Amnesty_International"), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".RDS", sep=""))
  
}


# human rights topic
TERMS <- c(URLdecode("%2Fm%2F03ll3")) ## human rights topic

for(j in 1:length(TIME)){
  #for(j in c(1,4)){
  out_dat <- gsearch_cy_search_lists_function(language_term=TERMS, language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  saveRDS(out_dat, paste("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_", gsub(" ", "_", "human_rights_topic"), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".RDS", sep=""))
  
}


# "Amnesty International"
for(j in 1:length(TIME)){
  #for(j in c(1,4)){
  out_dat <- gsearch_cy_search_lists_function(language_term="Amnistía Internacional", language_time=TIME[j])
  #out_dat <- out_dat[order(out_dat$ISO, out_dat$year),]
  head(out_dat)
  summary(out_dat)
  
  ## set today's date for saving files below
  current_date <- as.Date(Sys.time())
  current_date
  
  ## save data.frame for future analysis 
  saveRDS(out_dat, paste("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_", gsub(" ", "_", "Amnistia_Internacional"), "_", gsub(" ", "_", TIME[j]), "_saved_", current_date, ".RDS", sep=""))
  
}

#"Anistia Internacional"
#"منظمة العفو الدولية"
#"munazamat aleafw alduwalia"


