## Amnesty_article_coverage_analysis.R
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

## load the HRPS with the additional information from the total number of amnesty reports generated by country each year
#data <- try(read.csv("Data_input/HumanRightsProtectionScores_v4.01_amnesty_report_count.csv"))

data <- try(read.csv("Data_input/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv"))

amnesty_attention <- read.csv("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/amnesty_article_meta_data_procssed.csv")

amnesty_cy <- data.frame(table(amnesty_attention$CCODE, amnesty_attention$YEAR))
names(amnesty_cy) <- c("CCODE", "YEAR", "amnesty_attention_count")
head(amnesty_cy)

data <- merge(data, amnesty_cy, by.x=c("COW", "YEAR"), by.y=c("CCODE", "YEAR"), all.x=TRUE, all.y=FALSE)

## inspect the object
head(data)
summary(data)
table(data$amnesty_report_count, data$YEAR)


# create an empty list
newdata <- list()

# take K draws from the posterior distribution and make K new datasets in the list object just created
for(j in 1:1000){
  newdata[[j]] <- data
  newdata[[j]]$draw <- rnorm(cbind(rep(1,nrow(data))), mean=data$theta_mean, sd=data$theta_sd)
}

## a vector and a list object to hold some stuff
year_cor <- c()
year_cor_draws <- list()

YEAR <- 1961:2019

## this code is slow but it works fine <shrugs>; make an lapply() version later
for(i in 1:length(YEAR)){
  temp <- c()
  year_cor[i] <- cor(data$theta_mean[data$YEAR==YEAR[i]], data$amnesty_report_count[data$YEAR==YEAR[i]], use="pairwise", method="spearman")
  for(j in 1:1000){
    temp[j] <- cor(newdata[[j]]$draw[newdata[[j]]$YEAR==YEAR[i]], newdata[[j]]$amnesty_report_count[newdata[[j]]$YEAR==YEAR[i]], use="pairwise", method="spearman")
  }
  year_cor_draws[[i]] <- temp
}

year_cor

## unlist and lapply some stats
year_cor_draw_mean <- unlist(lapply(year_cor_draws, mean))
year_cor_draw_ub <- unlist(lapply(year_cor_draws, quantile, .975))
year_cor_draw_lb <- unlist(lapply(year_cor_draws, quantile, .025))

## organize all the correlation estimates in a data.frame
dat <- data.frame(year=1961:2019, year_cor, year_cor_draw_mean, year_cor_draw_ub, year_cor_draw_lb)
dat

## create graph file
pdf("Rplots/HRPS_Amnesty_Yearly_Correlations.pdf", height=8, width=8)

## make a sweet plots
par(mar=c(4,4,4,1))
plot(dat$year, dat$year_cor_draw_mean, type="n", ylim=c(-1,1), main="Yearly Correlation between Human Rights Protection\nScores and Number of Amnesty International Reports", ylab="Spearman Correlation", xlab="Year")
abline(h=0.5, col=grey(.25), lty=2)
abline(h=0, col=grey(.25), lty=2)
abline(h=-0.5, col=grey(.25), lty=2)
for(i in 1:nrow(dat)){
  lines(c(dat$year[i], dat$year[i]), c(dat$year_cor_draw_lb[i], dat$year_cor_draw_ub[i]), col=grey(.25))
}
points(dat$year, dat$year_cor_draw_mean, pch=21, bg=grey(.9), col=grey(.25))

dev.off()

## check out the cross-tabs 
ctabs <- xtabs(amnesty_report_count ~ YEAR + country_name, data=data) 
ctabs
ctabs[,'Uganda']
ctabs[,'Guatemala']
ctabs[,'Argentina']
ctabs[,'United Kingdom']
ctabs[,'Congo - Brazzaville']
ctabs[,'Congo - Kinshasa']
ctabs[,'Myanmar (Burma)']

## 

ctabs <- xtabs(amnesty_report_count ~ YEAR + country_name, data=subset(data, YEAR>=2012)) 
ctabs
ctabs[,'Uganda']
ctabs[,'Guatemala']
ctabs[,'Argentina']
ctabs[,'United Kingdom']


out_2019 <- sort(ctabs['2019',])
out_2018 <- sort(ctabs['2018',])

pdf("Rplots/Amnesty_report_2019_rankorder.pdf", height=12, width=8)

par(mar=c(2,10,1,.25))
barplot(out_2019, horiz=T, las=2, xaxt="n", cex.names=.75, main="Amnesty International Reports Rank Order in 2019", space=0)
axis(side=1, at=c(0,25,50,75,100,125,150,175,200,225))

dev.off()



# create an empty list
newdata <- list()

# take K draws from the posterior distribution and make K new datasets in the list object just created
for(j in 1:1000){
  newdata[[j]] <- data
  newdata[[j]]$draw <- rnorm(cbind(rep(1,nrow(data))), mean=data$theta_mean, sd=data$theta_sd)
}

## a vector and a list object to hold some stuff
year_cor <- c()
year_cor_draws <- list()

YEAR <- 1961:2019

## this code is slow but it works fine <shrugs>; make an lapply() version later
for(i in 1:length(YEAR)){
  temp <- c()
  year_cor[i] <- cor(data$theta_mean[data$YEAR==YEAR[i]], data$amnesty_attention_count[data$YEAR==YEAR[i]], use="pairwise", method="spearman")
  for(j in 1:1000){
    temp[j] <- cor(newdata[[j]]$draw[newdata[[j]]$YEAR==YEAR[i]], newdata[[j]]$amnesty_attention_count[newdata[[j]]$YEAR==YEAR[i]], use="pairwise", method="spearman")
  }
  year_cor_draws[[i]] <- temp
}

year_cor

## unlist and lapply some stats
year_cor_draw_mean <- unlist(lapply(year_cor_draws, mean, na.rm=T))
year_cor_draw_ub <- unlist(lapply(year_cor_draws, quantile, .975, na.rm=T))
year_cor_draw_lb <- unlist(lapply(year_cor_draws, quantile, .025, na.rm=T))

## organize all the correlation estimates in a data.frame
dat <- data.frame(year=1961:2019, year_cor, year_cor_draw_mean, year_cor_draw_ub, year_cor_draw_lb)
dat

## create graph file
pdf("Rplots/HRPS_Amnesty_attention_Yearly_Correlations.pdf", height=8, width=8)

## make a sweet plots
par(mar=c(4,4,4,1))
plot(dat$year, dat$year_cor_draw_mean, type="n", ylim=c(-1,1), main="Yearly Correlation between Human Rights Protection\nScores and Number of Amnesty International Reports", ylab="Spearman Correlation", xlab="Year")
abline(h=0.5, col=grey(.25), lty=2)
abline(h=0, col=grey(.25), lty=2)
abline(h=-0.5, col=grey(.25), lty=2)
for(i in 1:nrow(dat)){
  lines(c(dat$year[i], dat$year[i]), c(dat$year_cor_draw_lb[i], dat$year_cor_draw_ub[i]), col=grey(.25))
}
points(dat$year, dat$year_cor_draw_mean, pch=21, bg=grey(.9), col=grey(.25))

dev.off()



cor(data$amnesty_report_count, data$amnesty_attention_count, use="pairwise")
cor(data$amnesty_report_count, data$amnesty_attention_count, use="pairwise", method="spearman")



report_count <- data.frame(xtabs(amnesty_attention_count ~ COW, data=subset(data, YEAR>=2015)))
report_count[order(report_count$Freq, decreasing=TRUE),]

report_count$COUNTRY <- countrycode(report_count$COW, origin="cown", destination="country.name")

report_count[order(report_count$Freq, decreasing=TRUE),]





#####
HRPS <- read.csv("Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
HRPS <- subset(HRPS, YEAR>=2012, select=c(YEAR, COW, theta_mean, theta_sd, amnesty_report_count))
head(HRPS)

amnesty_attention <- read.csv("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/amnesty_article_meta_data_procssed.csv")

amnesty_cy <- data.frame(table(amnesty_attention$CCODE, amnesty_attention$YEAR))
names(amnesty_cy) <- c("CCODE", "YEAR", "amnesty_attention_count")
head(amnesty_cy)

hringo <- read.csv("Data_output/hringo_inter_v2.csv")
hringo <- subset(hringo, year>=2012 & ccode!=-999, select=c(ccode, year, hringo_inter))
head(hringo, 10)

WDI <- read.csv("Data_input/WDI_data_2012_2019_saved_2022-05-23.csv")
head(WDI)


temp <- merge(HRPS, amnesty_cy, by.x=c("COW", "YEAR"), by.y=c("CCODE", "YEAR"), all.x=TRUE, all.y=FALSE)
temp <- merge(temp, hringo, by.x=c("COW", "YEAR"), by.y=c("ccode", "year"), all.x=TRUE, all.y=FALSE)
temp$ISO <- countrycode(temp$COW, origin="cown", destination="iso2c")
temp <- merge(temp, WDI, by.x=c("ISO", "YEAR"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)

temp$amnesty_report_rate <- 100000*(temp$amnesty_report_count / temp$Population)
temp$amnesty_attention_rate <- 100000*(temp$amnesty_attention_count / temp$Population)
temp$hringo_inter_rate <- 100000*(temp$hringo_inter / temp$Population)
  
dim(temp)
head(temp)

cor(temp[,c('theta_mean','amnesty_report_count','amnesty_attention_count', 'hringo_inter','amnesty_report_rate','amnesty_attention_rate','hringo_inter_rate')], use="pairwise")

cor(temp[,c('theta_mean','amnesty_report_count','amnesty_attention_count', 'hringo_inter','amnesty_report_rate','amnesty_attention_rate','hringo_inter_rate')], use="pairwise", method="spearman")
