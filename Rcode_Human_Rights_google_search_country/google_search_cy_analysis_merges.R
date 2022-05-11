## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

files_names <- list.files("Data_output_search_cy_datasets")
files_names

dat_list <- list()
for(i in 1:length(files_names)){
  dat_list[[i]] <- read.csv(paste("Data_output_search_cy_datasets/",files_names[i], sep=""))
}
length(dat_list)

HRPS <- read.csv("Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
HRPS <- subset(HRPS, YEAR>=min(dat$year))
head(HRPS)

WDI <- read.csv("Data_input/WDI_data_2012_2019_saved_2022-05-09.csv")

VDEM <- readRDS("Data_input/Country_Year_V-Dem_Full+others_R_v12/V-Dem-CY-Full+Others-v12.rds")
dim(VDEM)

VDEM <- subset(VDEM, year>=2012, select=c(year, COWcode, v2smgovfilprc))
dim(VDEM)

TREATY <- read.csv("Data_output/hr_commitments_updated_2022.csv")
TREATY$CCODE <- countrycode(TREATY$country_case, origin="country.name", destination="cown")
dim(TREATY)

dat_list_merged <- list()

for(i in 1:length(dat_list)){
  dat <- dat_list[[i]]
  temp <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, WDI, by.x=c("ISO", "year"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, VDEM, by.x=c("CCODE", "year"), by.y=c("COWcode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, TREATY, by.x=c("CCODE", "year"), by.y=c("CCODE", "year"), all.x=TRUE, all.y=FALSE)
  dat_list_merged[[i]] <- temp
}
head(dat_list_merged[[1]])
