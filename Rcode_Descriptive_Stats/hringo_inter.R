## hringo_inter.R
##
## Authors: Geoff Dancy and Christopher J. Fariss
##
## Title: "The Search for Human Rights: A Global Analysis Using Google Data"
##
## Contact Information: 
##  Geoff Dancy <geoff.dancy@utoronto.ca>
##  Christopher J. Fariss <cjf0006@gmail.com>
##  
##  Copyright (c) 2022, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
## For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
##  All rights reserved. 
##
##########################################################################
##
## add more interpolated/extrapolated rows (this is just an alternative variable for the main Amnesty International attention variables)
hringo <- read.csv("Data_input/hringo_inter.csv")
#hringo <- subset(hringo, year>=2012 & ccode!=-999)
head(hringo)

hringo_2018 <- subset(hringo, year==2017) 
hringo_2018$year <- 2018
hringo_2019 <- subset(hringo, year==2017) 
hringo_2019$year <- 2019

hringo <- rbind(hringo, hringo_2018, hringo_2019)
head(hringo, 10)
tail(hringo, 10)

hringo <- hringo[order(hringo$country, hringo$year),]
head(hringo, 50)

write.csv(hringo, file="Data_output/hringo_inter_v2.csv", row.names=FALSE)
