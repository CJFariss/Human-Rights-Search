library(readstata13)
library(countrycode)
library(plm)
library(lmtest)

#data <- readstata13::read.dta13("Data_input/meso_v3.dta")
data <- read.csv("Data_input/full.dat.csv")

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


dat <- data
temp <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all.x=TRUE, all.y=FALSE)
temp <- merge(temp, WDI, by.x=c("ISO", "year"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)
temp <- merge(temp, VDEM, by.x=c("CCODE", "year"), by.y=c("COWcode", "year"), all.x=TRUE, all.y=FALSE)
temp <- merge(temp, TREATY, by.x=c("CCODE", "year"), by.y=c("CCODE", "year"), all.x=TRUE, all.y=FALSE)
dat_merged <- temp
    
  
temp <-  dat_merged 
temp$amnesty_report_count <- scale(temp$amnesty_report_count)  
temp$GDP_growth_annual_percent <- scale(temp$GDP_growth_annual_percent)
temp$Foreign_direct_investment_net_inflows_percent_GDP <- scale(temp$Foreign_direct_investment_net_inflows_percent_GDP) 
temp$treaty_count <- scale(temp$treaty_count)
temp$v2smgovfilprc <- scale(temp$v2smgovfilprc)
  
fit <- plm(hits_mean ~ I(-1*theta_mean.y) + 
             amnesty_report_count + 
             GDP_growth_annual_percent + 
             Foreign_direct_investment_net_inflows_percent_GDP + 
             treaty_count +
             v2smgovfilprc,
             data=temp,
             effect = c("individual"),
             model = c("pooling"),
             index = c("language_type")
)
plm_value <- coeftest(fit, vcov = vcovHC, type = "HC1")
unit_n  <- length(fit$residuals)

plm_value
unit_n
