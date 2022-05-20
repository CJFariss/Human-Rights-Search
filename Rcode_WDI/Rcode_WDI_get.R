## Rcode_WDI_get.R

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


dat <- WDI(indicator=c(GDP_growth_annual_percent="NY.GDP.MKTP.KD.ZG",    Foreign_direct_investment_net_inflows_percent_GDP="BX.KLT.DINV.WD.GD.ZS"
            ),
  country="all", start=2012, end=2019)

dim(dat)
names(dat)
head(dat)

cor(dat[,4:8], use="pairwise")

## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

write.csv(dat, file=paste("Data_input/WDI_data_2012_2019_saved_", current_date, ".csv", sep=""), row.names=FALSE)
