## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


dat <- read.csv("Data_output_search/gsearch_cy_data_Amnesty_International_2012-01-01_2015-12-31_saved_2022-04-28.csv")
dat <- read.csv("Data_output_search/gsearch_cy_data_Amnesty_International_2013-01-01_2017-12-31_saved_2022-04-28.csv")
dat <- read.csv("Data_output_search/gsearch_cy_data_Amnesty_International_2014-01-01_2018-12-31_saved_2022-04-28.csv")
dat <- read.csv("Data_output_search/gsearch_cy_data_Amnesty_International_2015-01-01_2019-12-31_saved_2022-04-28.csv")
head(dat)

HRPS <- read.csv("Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
HRPS <- subset(HRPS, YEAR>=min(dat$year))
head(HRPS)

test_dat <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all=TRUE)

head(test_dat)
dim(test_dat)

test_dat$hits_mean[is.na(test_dat$hits_mean)] <- 0
test_dat$hits_median[is.na(test_dat$hits_median)] <- 0
test_dat$hits_max[is.na(test_dat$hits_max)] <- 0
test_dat$hits_sd[is.na(test_dat$hits_sd)] <- 0


## correlations
cor.test(test_dat$hits_mean, test_dat$theta_mean)
cor.test(test_dat$hits_mean, test_dat$amnesty_report_count)

cor.test(test_dat$hits_median, test_dat$theta_mean)
cor.test(test_dat$hits_median, test_dat$amnesty_report_count)

cor.test(test_dat$hits_max, test_dat$theta_mean)
cor.test(test_dat$hits_max, test_dat$amnesty_report_count)




