##########################################################################

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


##########################################################################
## merge
##########################################################################

files_names <- list.files("Data_output_search_cy_datasets")
files_names

dat_list <- list()
for(i in 1:length(files_names)){
  dat_list[[i]] <- read.csv(paste("Data_output_search_cy_datasets/",files_names[i], sep=""))
}
length(dat_list)

HRPS <- read.csv("Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
HRPS <- subset(HRPS, YEAR>=2012, select=c(YEAR, COW, theta_mean, theta_sd, amnesty_report_count))
head(HRPS)

amnesty_attention <- read.csv("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/amnesty_article_meta_data_procssed.csv")

amnesty_cy <- data.frame(table(amnesty_attention$CCODE, amnesty_attention$YEAR))
names(amnesty_cy) <- c("CCODE", "YEAR", "amnesty_attention_count")
head(amnesty_cy)

hringo <- read.csv("Data_output/hringo_inter_v2.csv")
hringo <- subset(hringo, year>=2012 & ccode!=-999, select=c(ccode, year, hringo_inter))
head(hringo, 10)

WDI <- read.csv("Data_input/WDI_data_2012_2019_saved_2022-05-23.csv")
head(WDI)

VDEM <- readRDS("Data_input/Country_Year_V-Dem_Full+others_R_v12/V-Dem-CY-Full+Others-v12.rds")
VDEM <- subset(VDEM, year>=2012, select=c(year, COWcode, v2smgovfilprc))
dim(VDEM)
head(VDEM)

TREATY <- read.csv("Data_output/hr_commitments_updated_2022.csv")
TREATY$CCODE <- countrycode(TREATY$country_case, origin="country.name", destination="cown")
TREATY <- subset(TREATY, year>=2012, select=c(year, CCODE, treaty_count))
dim(TREATY)
head(TREATY)

dat_list_merged <- list()

for(i in 1:length(dat_list)){
  dat <- dat_list[[i]]
  #dat <- dat_list[[1]] ## for testing
  temp <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, amnesty_cy, by.x=c("CCODE", "year"), by.y=c("CCODE", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, hringo, by.x=c("CCODE", "year"), by.y=c("ccode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, WDI, by.x=c("ISO", "year"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, VDEM, by.x=c("CCODE", "year"), by.y=c("COWcode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, TREATY, by.x=c("CCODE", "year"), by.y=c("CCODE", "year"), all.x=TRUE, all.y=FALSE)
  
  temp$amnesty_attention_rate <- 100000*(temp$amnesty_attention_count / temp$Population)
  temp$hringo_inter_rate <- 100000*(temp$hringo_inter / temp$Population)
  
  dat_list_merged[[i]] <- temp
}
## inspect the list object
head(dat_list_merged[[1]])
lapply(dat_list_merged, head)
sapply(dat_list_merged, nrow)

## add names to the list object
names(dat_list_merged) <- gsub(".csv", "", files_names)
names(dat_list_merged) 

## saved combined list of datasets
saveRDS(dat_list_merged, file="Data_output/combined_gsearch_dat_list_merged.RDS")

##########################################################################
## lowsearch merge
##########################################################################

files_names <- list.files("Data_output_search_cy_datasets_lowsearch")
files_names

dat_list <- list()
for(i in 1:length(files_names)){
  dat_list[[i]] <- read.csv(paste("Data_output_search_cy_datasets_lowsearch/",files_names[i], sep=""))
}
length(dat_list)

HRPS <- read.csv("Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
HRPS <- subset(HRPS, YEAR>=2012, select=c(YEAR, COW, theta_mean, theta_sd, amnesty_report_count))
head(HRPS)

amnesty_attention <- read.csv("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/amnesty_article_meta_data_procssed.csv")

amnesty_cy <- data.frame(table(amnesty_attention$CCODE, amnesty_attention$YEAR))
names(amnesty_cy) <- c("CCODE", "YEAR", "amnesty_attention_count")
head(amnesty_cy)

hringo <- read.csv("Data_output/hringo_inter_v2.csv")
hringo <- subset(hringo, year>=2012 & ccode!=-999, select=c(ccode, year, hringo_inter))
head(hringo, 10)

WDI <- read.csv("Data_input/WDI_data_2012_2019_saved_2022-05-23.csv")
head(WDI)

VDEM <- readRDS("Data_input/Country_Year_V-Dem_Full+others_R_v12/V-Dem-CY-Full+Others-v12.rds")
VDEM <- subset(VDEM, year>=2012, select=c(year, COWcode, v2smgovfilprc))
dim(VDEM)
head(VDEM)

TREATY <- read.csv("Data_output/hr_commitments_updated_2022.csv")
TREATY$CCODE <- countrycode(TREATY$country_case, origin="country.name", destination="cown")
TREATY <- subset(TREATY, year>=2012, select=c(year, CCODE, treaty_count))
dim(TREATY)
head(TREATY)

dat_list_merged <- list()

for(i in 1:length(dat_list)){
  dat <- dat_list[[i]]
  #dat <- dat_list[[1]] ## for testing
  temp <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, amnesty_cy, by.x=c("CCODE", "year"), by.y=c("CCODE", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, hringo, by.x=c("CCODE", "year"), by.y=c("ccode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, WDI, by.x=c("ISO", "year"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, VDEM, by.x=c("CCODE", "year"), by.y=c("COWcode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, TREATY, by.x=c("CCODE", "year"), by.y=c("CCODE", "year"), all.x=TRUE, all.y=FALSE)
  
  temp$amnesty_attention_rate <- 100000*(temp$amnesty_attention_count / temp$Population)
  temp$hringo_inter_rate <- 100000*(temp$hringo_inter / temp$Population)
  
  dat_list_merged[[i]] <- temp
}
## inspect the list object
head(dat_list_merged[[1]])
lapply(dat_list_merged, head)
sapply(dat_list_merged, nrow)

## add names to the list object
names(dat_list_merged) <- gsub(".csv", "", files_names)
names(dat_list_merged) 

## saved combined list of datasets
saveRDS(dat_list_merged, file="Data_output/combined_gsearch_dat_list_merged_lowsearch.RDS")



##########################################################################
## topics merge
##########################################################################

files_names <- list.files("Data_output_search_cy_topic_datasets")
files_names

dat_list <- list()
for(i in 1:length(files_names)){
  dat_list[[i]] <- read.csv(paste("Data_output_search_cy_topic_datasets/",files_names[i], sep=""))
}
length(dat_list)

HRPS <- read.csv("Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
HRPS <- subset(HRPS, YEAR>=2012, select=c(YEAR, COW, theta_mean, theta_sd, amnesty_report_count))
head(HRPS)

amnesty_attention <- read.csv("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/amnesty_article_meta_data_procssed.csv")

amnesty_cy <- data.frame(table(amnesty_attention$CCODE, amnesty_attention$YEAR))
names(amnesty_cy) <- c("CCODE", "YEAR", "amnesty_attention_count")
head(amnesty_cy)

hringo <- read.csv("Data_output/hringo_inter_v2.csv")
hringo <- subset(hringo, year>=2012 & ccode!=-999, select=c(ccode, year, hringo_inter))
head(hringo, 10)

WDI <- read.csv("Data_input/WDI_data_2012_2019_saved_2022-05-23.csv")
head(WDI)

VDEM <- readRDS("Data_input/Country_Year_V-Dem_Full+others_R_v12/V-Dem-CY-Full+Others-v12.rds")
VDEM <- subset(VDEM, year>=2012, select=c(year, COWcode, v2smgovfilprc))
dim(VDEM)
head(VDEM)

TREATY <- read.csv("Data_output/hr_commitments_updated_2022.csv")
TREATY$CCODE <- countrycode(TREATY$country_case, origin="country.name", destination="cown")
TREATY <- subset(TREATY, year>=2012, select=c(year, CCODE, treaty_count))
dim(TREATY)
head(TREATY)

dat_list_merged <- list()



for(i in 1:length(dat_list)){
  dat <- dat_list[[i]]
  #dat <- dat_list[[1]] ## for testing
  temp <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, amnesty_cy, by.x=c("CCODE", "year"), by.y=c("CCODE", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, hringo, by.x=c("CCODE", "year"), by.y=c("ccode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, WDI, by.x=c("ISO", "year"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, VDEM, by.x=c("CCODE", "year"), by.y=c("COWcode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, TREATY, by.x=c("CCODE", "year"), by.y=c("CCODE", "year"), all.x=TRUE, all.y=FALSE)
  
  temp$amnesty_attention_rate <- 100000*(temp$amnesty_attention_count / temp$Population)
  temp$hringo_inter_rate <- 100000*(temp$hringo_inter / temp$Population)
  
  dat_list_merged[[i]] <- temp
}
## inspect the list object
head(dat_list_merged[[1]])
lapply(dat_list_merged, head)
sapply(dat_list_merged, nrow)

## add names to the list object
names(dat_list_merged) <- gsub(".csv", "", files_names)
names(dat_list_merged) 

## saved combined list of datasets
saveRDS(dat_list_merged, file="Data_output/combined_gsearch_dat_topic_list_merged.RDS")

