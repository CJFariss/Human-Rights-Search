## hringo_2018

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
