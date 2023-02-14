## Search_engine_use_analysis.R
##########################################################################
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
## Search example:
## https://gs.statcounter.com/search-engine-market-share/all/united-states-of-america/#monthly-201301-201912
##
##################################################


pdf("Rplots/Rplot_search_months.pdf", height=4, width=8)


##################################################
# Uganda
##################################################
stat_counter <- read.csv("Data_input/search_engine-UG-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Uganda: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# Guatemala
##################################################
stat_counter <- read.csv("Data_input/search_engine-GT-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Guatemala: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# Burundi
##################################################
stat_counter <- read.csv("Data_input/search_engine-BI-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Burundi: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# Mozambique
##################################################
stat_counter <- read.csv("Data_input/search_engine-MZ-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Mozambique: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)


##################################################
# Morocco
##################################################
stat_counter <- read.csv("Data_input/search_engine-MA-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Morocco: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# Africa region
##################################################
stat_counter <- read.csv("Data_input/search_engine-af-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Africa Region: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# South America region
##################################################
stat_counter <- read.csv("Data_input/search_engine-sa-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="South America Region: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# Europe region
##################################################
stat_counter <- read.csv("Data_input/search_engine-eu-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Europe Region: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)


##################################################
# Asia region
##################################################
stat_counter <- read.csv("Data_input/search_engine-as-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Asia Region: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# Oceania region
##################################################
stat_counter <- read.csv("Data_input/search_engine-oc-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="Oceania Region: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

##################################################
# North America region
##################################################
stat_counter <- read.csv("Data_input/search_engine-na-monthly-201301-201912.csv")
barplot(t(as.matrix(stat_counter[,2:6])), beside=F, space=0, ylim=c(0,100), main="North America Region: Monthly Search Engine Use (2013-2019)", col=rev(c("#d7191c", "#fdae61", "#ffffbf", "#abd9e9", "#2c7bb6")), names.arg= stat_counter$Date, las=2, cex.axis=1, cex=.75)

dev.off()





