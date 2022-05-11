## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

dat_list <- list()
dat_list[[1]] <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2012-01-01_2016-12-31_saved_2022-05-09.csv")
dat_list[[2]]  <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2013-01-01_2017-12-31_saved_2022-04-27.csv")
dat_list[[3]]  <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2014-01-01_2018-12-31_saved_2022-04-28.csv")
dat_list[[4]]  <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2015-01-01_2019-12-31_saved_2022-04-27.csv")


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

test_dat_list <- list()

for(i in 1:length(dat_list)){
  dat <- dat_list[[i]]
  temp <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, WDI, by.x=c("ISO", "year"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, VDEM, by.x=c("CCODE", "year"), by.y=c("COWcode", "year"), all.x=TRUE, all.y=FALSE)
  temp <- merge(temp, TREATY, by.x=c("CCODE", "year"), by.y=c("CCODE", "year"), all.x=TRUE, all.y=FALSE)
  test_dat_list[[i]] <- temp
}
head(test_dat_list[[2]])
