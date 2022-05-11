## HR_treaty.R
##########################################################################

## document search for treaty updates: tbinternet.ohchr.org

dat <- read.csv("Data_input/hr_commitments.csv")
dat$country <- as.character(dat$country)
dim(dat)
names(dat)

##########################################################################
## 2018 updates
dat_2018 <- subset(dat, year==2017)
dat_2018$year <- 2018

## cat
dat_2018$cat[dat_2018$country_case=="Bahamas"] <- 1

## cat_op
dat_2018$cat_op[dat_2018$country_case=="Afghanistan"] <- 1

## iccpr
dat_2018$iccpr[dat_2018$country_case=="Marshall Islands"] <- 1
dat_2018$iccpr[dat_2018$country_case=="Qatar"] <- 1

## disap
dat_2018$disap[dat_2018$country_case=="Gambia"] <- 1

##########################################################################
## 2019 updates
dat_2019 <- dat_2018
dat_2019$year <- 2019

## cat
dat_2019$cat[dat_2019$country_case=="Angola"] <- 1
dat_2019$cat[dat_2019$country_case=="Kiribati"] <- 1
dat_2019$cat[dat_2019$country_case=="Samoa"] <- 1

## cat_op
dat_2019$cat_op[dat_2019$country_case=="Iceland"] <- 1
dat_2019$cat_op[dat_2019$country_case=="South Africa"] <- 1

## iccpr
dat_2019$iccpr[dat_2019$country_case=="Antigua & Barbuda"] <- 1

## disap
dat_2019$disap[dat_2019$country_case=="Dominica"] <- 1
dat_2019$disap[dat_2019$country_case=="Fiji"] <- 1
dat_2019$disap[dat_2019$country_case=="Norway"] <- 1


##########################################################################
## 2020 updates
dat_2020 <- dat_2019
dat_2020$year <- 2020

## cat
dat_2020$cat[dat_2020$country_case=="Oman"] <- 1
dat_2020$cat[dat_2020$country_case=="Saint Kitts & Nevis"] <- 1

## disap
dat_2020$disap[dat_2020$country_case=="Oman"] <- 1

## disab_op (CED Article 31) 
dat_2020$disab_op[dat_2020$country_case=="Mexico"] <- 1

##########################################################################
## 2021 updates
dat_2021 <- dat_2020
dat_2021$year <- 2021

## cat
dat_2021$cat[dat_2021$country_case=="Sudan"] <- 1
dat_2021$cat[dat_2021$country_case=="Suriname"] <- 1

## cat_op
dat_2021$cat_op[dat_2021$country_case=="Latvia"] <- 1

## disap
dat_2021$disap[dat_2021$country_case=="Slovenia"] <- 1
dat_2021$disap[dat_2021$country_case=="Sudan"] <- 1

## disab_op (CED Article 31)
dat_2021$disab_op[dat_2021$country_case=="Slovenia"] 

##########################################################################
## 2022 updates
dat_2022 <- dat_2021
dat_2022$year <- 2022

## cat_op
dat_2022$cat_op[dat_2022$country_case=="Morocco"] <- 1


## disap
dat_2022$disap[dat_2022$country_case=="Croatia"] <- 1
dat_2022$disap[dat_2022$country_case=="Denmark"] <- 1

## disab_op (CED Article 31)
dat_2022$disab_op[dat_2022$country_case=="Denmark"] <- 1


dat <- rbind(dat, dat_2018, dat_2019, dat_2020, dat_2021, dat_2022)
dim(dat)
head(dat)

write.csv(dat, "Data_output/hr_commitments_updated_2022.csv", row.names=FALSE)

