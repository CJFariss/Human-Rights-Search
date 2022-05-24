## HR_treaty.R
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
##
## document search for treaty updates: tbinternet.ohchr.org
##
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CAT&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CAT-OP&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CCPR&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CCPR-OP1&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CCPR-OP1-DP&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CED&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CEDAW&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CEDAW-OP&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CESCR&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CESCR-OP&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CMW&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CRC&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CRC-OP-AC&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CRC-OP-IC&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CRC-OP-SC&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CRPD&Lang=en
## https://tbinternet.ohchr.org/_layouts/15/TreatyBodyExternal/Treaty.aspx?Treaty=CRPD-OP&Lang=en
##
##########################################################################

## load data 
dat <- read.csv("Data_input/hr_commitments.csv")
dat$country <- as.character(dat$country)
dim(dat)
names(dat)

##########################################################################
## 2018 updates
dat_2018 <- subset(dat, year==2017)
dat_2018$year <- 2018

## cat (CAT)
dat_2018$cat[dat_2018$country_case=="Bahamas"] <- 1

## cat (CAT-OP)
dat_2018$cat_op[dat_2018$country_case=="Afghanistan"] <- 1

## iccpr (CCPR)
dat_2018$iccpr[dat_2018$country_case=="Marshall Islands"] <- 1
dat_2018$iccpr[dat_2018$country_case=="Qatar"] <- 1

## disap (CED)
dat_2018$disap[dat_2018$country_case=="Gambia"] <- 1

## icescr (CESCR)
dat_2018$icescr[dat_2018$country_case=="Fiji"] <- 1
dat_2018$icescr[dat_2018$country_case=="Qatar"] <- 1

## icescr_op (CESCR-OP)
# none changed

## migrant (CRM)
dat_2018$migrant[dat_2018$country_case=="Gambia"] <- 1
dat_2018$migrant[dat_2018$country_case=="Guinea-Bissau"] <- 1

## crc_op1 (CRC-OP-AC)
dat_2018$crc_op1[dat_2018$country_case=="South Sudan"] <- 1

## crc_op2 (CRC-OP-SC)
dat_2018$crc_op2[dat_2018$country_case=="South Sudan"] <- 1

## crc_op3 (CRC-OP-IC)
dat_2018$crc_op3[dat_2018$country_case=="Bosnia & Herzegovina"] <- 1 
dat_2018$crc_op3[dat_2018$country_case=="Ecuador"] <- 1 
dat_2018$crc_op3[dat_2018$country_case=="San Marino"] <- 1 
dat_2018$crc_op3[dat_2018$country_case=="Slovenia"] <- 1 
dat_2018$crc_op3[dat_2018$country_case=="Tunisia"] <- 1 

## disability (CRPD)
dat_2018$disability[dat_2018$country_case=="Ireland"] <- 1 
dat_2018$disability[dat_2018$country_case=="Libya"] <- 1 

## disab_op (CRPD-OP)
dat_2018$disab_op[dat_2018$country_case=="Canada"] <- 1 
dat_2018$disab_op[dat_2018$country_case=="Guinea-Bissau"] <- 1 


##########################################################################
## 2019 updates
dat_2019 <- dat_2018
dat_2019$year <- 2019

## cat (CAT)
dat_2019$cat[dat_2019$country_case=="Angola"] <- 1
dat_2019$cat[dat_2019$country_case=="Kiribati"] <- 1
dat_2019$cat[dat_2019$country_case=="Samoa"] <- 1

## cat_op (CAT-OP)
dat_2019$cat_op[dat_2019$country_case=="Iceland"] <- 1
dat_2019$cat_op[dat_2019$country_case=="South Africa"] <- 1

## iccpr (CCPR)
dat_2019$iccpr[dat_2019$country_case=="Antigua & Barbuda"] <- 1

## disap (CED)
dat_2019$disap[dat_2019$country_case=="Dominica"] <- 1
dat_2019$disap[dat_2019$country_case=="Fiji"] <- 1
dat_2019$disap[dat_2019$country_case=="Norway"] <- 1

## cedaw (CEDAW)
dat_2019$cedaw_op[dat_2019$country_case=="Malta"] <- 1
dat_2019$cedaw_op[dat_2019$country_case=="Marshall Islands"] <- 1

## icescr (CESCR)
dat_2019$icescr[dat_2019$country_case=="Antigua & Barbuda"] <- 1

## migrant (CRM)
dat_2019$icescr[dat_2019$country_case=="Fiji"] <- 1

## crc_op1 (CRC-OP-AC)
dat_2019$crc_op1[dat_2019$country_case=="Gambia"] <- 1

## crc_op2 (CRC-OP-SC)
dat_2019$crc_op2[dat_2019$country_case=="Marshall Islands"] <- 1

## crc_op3 (CRC-OP-IC)
dat_2019$crc_op3[dat_2019$country_case=="Belize"] <- 1
dat_2019$crc_op3[dat_2019$country_case=="Maldives"] <- 1
dat_2019$crc_op3[dat_2019$country_case=="Marshall Islands"] <- 1
dat_2019$crc_op3[dat_2019$country_case=="Palestine"] <- 1 

## disability (CRPD)
dat_2019$disability[dat_2019$country_case=="Chad"] <- 1 
dat_2019$disability[dat_2019$country_case=="Kyrgyzstan"] <- 1 
dat_2019$disability[dat_2019$country_case=="Somalia"] <- 1 

## disab_op (CRPD-OP)
dat_2019$disab_op[dat_2019$country_case=="Monaco"] <- 1 
dat_2019$disab_op[dat_2019$country_case=="Palestine"] <- 1 


##########################################################################
## 2020 updates
dat_2020 <- dat_2019
dat_2020$year <- 2020

## cat (CAT)
dat_2020$cat[dat_2020$country_case=="Oman"] <- 1
dat_2020$cat[dat_2020$country_case=="Saint Kitts & Nevis"] <- 1

## disap (CED)
dat_2020$disap[dat_2020$country_case=="Oman"] <- 1

## disab_op (CED Article 31) 
dat_2020$disab_op[dat_2020$country_case=="Mexico"] <- 1

## migrant (CRM)
dat_2020$migrant[dat_2020$country_case=="Togo"] <- 1

## disability (CRPD)
dat_2020$disability[dat_2020$country_case=="Saint Lucia"] <- 1 

## disab_op (CRPD-OP)
dat_2020$disab_op[dat_2020$country_case=="Saint Lucia"] <- 1 


##########################################################################
## 2021 updates
dat_2021 <- dat_2020
dat_2021$year <- 2021

## cat (CAT)
dat_2021$cat[dat_2021$country_case=="Sudan"] <- 1
dat_2021$cat[dat_2021$country_case=="Suriname"] <- 1

## cat (CAT-OP)
dat_2021$cat_op[dat_2021$country_case=="Latvia"] <- 1

## disap (CED)
dat_2021$disap[dat_2021$country_case=="Slovenia"] <- 1
dat_2021$disap[dat_2021$country_case=="Sudan"] <- 1

## disab_op (CED Article 31)
dat_2021$disab_op[dat_2021$country_case=="Slovenia"] <- 1 

## crc_op2 (CRC-OP-SC)
dat_2021$crc_op2[dat_2021$country_case=="Fiji"] <- 1

## crc_op3 (CRC-OP-IC)
dat_2021$crc_op3[dat_2021$country_case=="Armenia"] <- 1
dat_2021$crc_op3[dat_2021$country_case=="Seychelles"] <- 1

## disability (CRPD)
dat_2021$disability[dat_2021$country_case=="Botswana"] <- 1 

## disab_op (CRPD-OP)
dat_2021$disab_op[dat_2021$country_case=="Czechoslovakia/Czech Republic"] <- 1 
dat_2021$disab_op[dat_2021$country_case=="Georgia"] <- 1 


##########################################################################
## 2022 updates
dat_2022 <- dat_2021
dat_2022$year <- 2022

## cat (CAT-OP)
dat_2022$cat_op[dat_2022$country_case=="Morocco"] <- 1

## disap (CED)
dat_2022$disap[dat_2022$country_case=="Croatia"] <- 1
dat_2022$disap[dat_2022$country_case=="Denmark"] <- 1

## disab_op (CED Article 31)
dat_2022$disab_op[dat_2022$country_case=="Denmark"] <- 1

## cedaw (CEDAW)
dat_2022$cedaw_op[dat_2022$country_case=="Morocco"] <- 1

## disability (CRPD)
dat_2022$disability[dat_2022$country_case=="Equatorial Guinea"] <- 1 


## last checked May-24-2022

##########################################################################
## combine new datasets years with the original dataset
dat <- rbind(dat, dat_2018, dat_2019, dat_2020, dat_2021, dat_2022)

## inspect data
dim(dat)
head(dat)

## create count variable
dat$treaty_count <- NA
dim(dat[,c(-1,-2,-3)])

dat$treaty_count <- apply(dat[,c(-1,-2,-3)], 1, sum, na.rm=TRUE)
summary(dat$treaty_count)
table(dat$treaty_count)

## save output as csv file
write.csv(dat, "Data_output/hr_commitments_updated_2022.csv", row.names=FALSE)

