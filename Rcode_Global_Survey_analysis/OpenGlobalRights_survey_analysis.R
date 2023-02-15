## OpenGlobalRights_survey_analysis.R
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
## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


## load Stata 13 data version (this file is too big so use the binary version of the file below)
#la_hub_data <- read.dta13("master_la_hub_.dta")
#dim(la_hub_data)

## load binary data file 
load("Data_input/master_la_hub_data.Rdata")
dim(la_hub_data)

la_hub_country <- unique(la_hub_data$country)

la_hub_country_name <- c("Mexico", "Morocco", "Ecuador", "India", "Colombia", "Nigeria")
##################################################
## Values and labels:
## 1 Mexico
## 2 Morocco
## 3 Ecuador
## 4 India
## 5 Colombia
## 6 Nigeria
##################################################

## social media only answered in Mexico and Colombia
table(la_hub_data$web_social, la_hub_data$country)

## hr_where only answered in Nigeria
table(la_hub_data$hr_where, la_hub_data$country)



##################################################
## Values and labels:
## 1       Local news media (newspapers, radio, TV or online)
## 2       Foreign news media (newspaper, radio, TV or online)
## 3       Online social media
## 4       Friends, family, or people in my community
## 5       Politicians
## 6       Government agencies
## 7       HROs, activists, or workers
## 8       Religious leaders or institutions
## 9       Traditional rulers
## 10      School
## 11      Everywhere, all around
## 12      Other
##################################################


pdf("Rplots_survey_data/la_hub_plots.pdf", height=6, width=6)


##################################################
## hr_disc: Hear about 'Human rights'
##################################################
table(la_hub_data$hr_disc_lots, la_hub_data$country)
table(la_hub_data$hr_disc, la_hub_data$country)
#hr_disc_lots <- ifelse(la_hub_data$hr_disc_lots==1, 1, 0)
#hr_disc[hr_disc==0] <- NA
hr_disc <- la_hub_data$hr_disc
summary(hr_disc)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(la_hub_country)){
    observed.values <- hr_disc[la_hub_data$country %in% la_hub_country[i]]
    observed.weights <- la_hub_data$weight[la_hub_data$country %in% la_hub_country[i]]
    observed.values <- observed.values[!is.na(observed.values)]
    observed.weights <- observed.weights[!is.na(observed.values)]
    samples <- lapply(1:1000, function(i){
        bootstrap_samples <- sample(1:length(observed.values), replace=T, size=length(observed.values))
        bootstrap_mean <- sum(observed.values[bootstrap_samples]*observed.weights[bootstrap_samples])/sum(observed.weights[bootstrap_samples])
        return(bootstrap_mean)
    })
    stats_list[[i]] <- unlist(samples)
}

stats <- do.call("rbind", stats_list)

prop <- apply(stats, 1, mean)
prop_q025 <- apply(stats, 1, quantile, .025)
prop_q025
prop_q975 <- apply(stats, 1, quantile, .975)
prop_q975

data.frame(prop, la_hub_country)

par(mar=c(5,6,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,5)-1, main="Hear about 'Human rights'", col=grey(.85), xaxt="n")
axis(side=1, at=c(1,2,3,4,5)-1, labels=c(1,2,3,4,5))
axis(side=2, at=((1:length(prop)-.5)), labels=la_hub_country_name[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3,4,5)-1, labels=c("Never", "Rarely", "Sometimes", "Frequently", "Daily"), tick=FALSE, line=3)
for(i in 1:length(la_hub_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}


##################################################
## hr_resp: Respect for human rights
##################################################
la_hub_country <- c(1,2,4,5)
table(la_hub_data$hr_resp, la_hub_data$country)
hr_resp <- la_hub_data$hr_resp
summary(hr_disc)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(la_hub_country)){
    observed.values <- hr_resp[la_hub_data$country %in% la_hub_country[i]]
    observed.weights <- la_hub_data$weight[la_hub_data$country %in% la_hub_country[i]]
    observed.values <- observed.values[!is.na(observed.values)]
    observed.weights <- observed.weights[!is.na(observed.values)]
    samples <- lapply(1:1000, function(i){
        bootstrap_samples <- sample(1:length(observed.values), replace=T, size=length(observed.values))
        bootstrap_mean <- sum(observed.values[bootstrap_samples]*observed.weights[bootstrap_samples])/sum(observed.weights[bootstrap_samples])
        return(bootstrap_mean)
    })
    stats_list[[i]] <- unlist(samples)
}

stats <- do.call("rbind", stats_list)

prop <- apply(stats, 1, mean)
prop_q025 <- apply(stats, 1, quantile, .025)
prop_q025
prop_q975 <- apply(stats, 1, quantile, .975)
prop_q975

data.frame(prop, la_hub_country)

par(mar=c(5,6,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,4)-1, main="Respect for human rights", col=grey(.85), xaxt="n")
axis(side=1, at=c(1,2,3,4)-1, labels=c(1,2,3,4))
axis(side=2, at=((1:length(prop)-.5)), labels=la_hub_country_name[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3,4)-1, labels=c("No respect\nat all", "Not much\nrespect", "Some\nrespect", "A lot of\nrespect"), tick=FALSE, line=3)
for(i in 1:length(la_hub_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}


##################################################
## web_freq:
##################################################
la_hub_country <- c(1:6)
table(la_hub_data$web_freq, la_hub_data$country)
web_freq <- la_hub_data$web_freq
summary(web_freq)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(la_hub_country)){
    observed.values <- web_freq[la_hub_data$country %in% la_hub_country[i]]
    observed.weights <- la_hub_data$weight[la_hub_data$country %in% la_hub_country[i]]
    observed.values <- observed.values[!is.na(observed.values)]
    observed.weights <- observed.weights[!is.na(observed.values)]
    samples <- lapply(1:1000, function(i){
        bootstrap_samples <- sample(1:length(observed.values), replace=T, size=length(observed.values))
        bootstrap_mean <- sum(observed.values[bootstrap_samples]*observed.weights[bootstrap_samples])/sum(observed.weights[bootstrap_samples])
        return(bootstrap_mean)
    })
    stats_list[[i]] <- unlist(samples)
}

stats <- do.call("rbind", stats_list)

prop <- apply(stats, 1, mean)
prop_q025 <- apply(stats, 1, quantile, .025)
prop_q025
prop_q975 <- apply(stats, 1, quantile, .975)
prop_q975

data.frame(prop, la_hub_country)

par(mar=c(5,6,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,4.5)-1, main="Frequency of internet use", col=grey(.85), xaxt="n")
axis(side=1, at=c(1,2,3,4)-1, labels=c(1,2,3,4))
axis(side=2, at=((1:length(prop)-.5)), labels=la_hub_country_name[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3,4)-1, labels=c("Occasionally\n", "3-5 times\nper week", "Once\ndaily", "Several times\na day"), tick=FALSE, line=3)
for(i in 1:length(la_hub_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}

##################################################
## therm_ai Amnesty International thermometer score
##################################################
la_hub_country <- c(1:6)
table(la_hub_data$therm_ai, la_hub_data$country)
therm_ai <- la_hub_data$therm_ai
summary(therm_ai)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(la_hub_country)){
    observed.values <- therm_ai[la_hub_data$country %in% la_hub_country[i]]
    observed.weights <- la_hub_data$weight[la_hub_data$country %in% la_hub_country[i]]
    observed.values <- observed.values[!is.na(observed.values)]
    observed.weights <- observed.weights[!is.na(observed.values)]
    samples <- lapply(1:1000, function(i){
        bootstrap_samples <- sample(1:length(observed.values), replace=T, size=length(observed.values))
        bootstrap_mean <- sum(observed.values[bootstrap_samples]*observed.weights[bootstrap_samples])/sum(observed.weights[bootstrap_samples])
        return(bootstrap_mean)
    })
    stats_list[[i]] <- unlist(samples)
}

stats <- do.call("rbind", stats_list)

prop <- apply(stats, 1, mean)
prop_q025 <- apply(stats, 1, quantile, .025)
prop_q025
prop_q975 <- apply(stats, 1, quantile, .975)
prop_q975

data.frame(prop, la_hub_country)


par(mar=c(5,10,4,3))
barplot(prop[order(prop)], space=0, horiz=TRUE, xlim=c(0,100), main="Amnesty International thermometer score", col=grey(.85), xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=la_hub_country_name[order(prop)], las=2, cex.axis=1)
axis(side=1, at=c(1,25,50,75,100))
axis(side=1, at=c(1,50,100), labels=c("Very\nunfavorable", "Neither favorable\nnor unfavorable", "Very\nfavorable"), tick=FALSE, line=3)
for(i in 1:length(la_hub_country_name)){
    lines(c(prop_q025[order(prop)][i], prop_q975[order(prop)][i]), c(i-.5,i-.5))
}

##################################################
## therm_hrw       Human Rights Watch thermometer score
##################################################
## only Nigeria



##################################################
## part_hro
##################################################
la_hub_country <- c(1:6)
table(la_hub_data$part_hro, la_hub_data$country)
part_hro <- la_hub_data$part_hro
summary(part_hro)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(la_hub_country)){
    observed.values <- part_hro[la_hub_data$country %in% la_hub_country[i]]
    observed.weights <- la_hub_data$weight[la_hub_data$country %in% la_hub_country[i]]
    observed.values <- observed.values[!is.na(observed.values)]
    observed.weights <- observed.weights[!is.na(observed.values)]
    samples <- lapply(1:1000, function(i){
        bootstrap_samples <- sample(1:length(observed.values), replace=T, size=length(observed.values))
        bootstrap_mean <- sum(observed.values[bootstrap_samples]*observed.weights[bootstrap_samples])/sum(observed.weights[bootstrap_samples])
        return(bootstrap_mean)
    })
    stats_list[[i]] <- unlist(samples)
}

stats <- do.call("rbind", stats_list)

prop <- apply(stats, 1, mean)
prop_q025 <- apply(stats, 1, quantile, .025)
prop_q025
prop_q975 <- apply(stats, 1, quantile, .975)
prop_q975

data.frame(prop, la_hub_country)


par(mar=c(5,10,4,3))
barplot(prop[order(prop)], space=0, horiz=TRUE, xlim=c(0,1), main="part_hro", col=grey(.85))
axis(side=2, at=((1:length(prop)-.5)), labels=la_hub_country_name[order(prop)], las=2, cex.axis=1)
for(i in 1:length(la_hub_country_name)){
    lines(c(prop_q025[order(prop)][i], prop_q975[order(prop)][i]), c(i-.5,i-.5))
}

mat <- matrix(NA, nrow=6, ncol=2)
for(i in 1:length(la_hub_country)){
    mat[i,1] <- cor(la_hub_data$part_hro[la_hub_country[i]], la_hub_data$hr_disc[la_hub_country[i]], use="pairwise", method="spearman")
    mat[i,2] <- cor(la_hub_data$part_hro[la_hub_country[i]], la_hub_data$web_freq[la_hub_country[i]], use="pairwise", method="spearman")
}
mat

##################################################
## news_web: Follow news (frequency): Internet
##################################################
## 1 Never
## 2 Rarely
## 3 Some times a month
## 4 Some times a week
## 5 Daily

## doesn't seem to exist in the dataset


##################################################
##
##################################################

## ----- NEGATIVE ----- ##
## hro_assoc_corr
## hro_assoc_use
## hro_assoc_elite
## hro_assoc_us (doesn't seem to be available for any country)
## ----- POSITIVE ----- ##
## hro_assoc_help
## hro_assoc_trust
## hro_assoc_connect (doesn't seem to be available for any country)
## hro_assoc_effec
## hro_assoc_brave

COLOR <- c("#fc8d62", "#fc8d62", "#fc8d62", "#66c2a5", "#66c2a5", "#66c2a5")
COLOR <- c("#fc8d62", "#fc8d62", "#8da0cb", "#66c2a5","#66c2a5", "#66c2a5")

labels <- c("Corruption", "Useless", "Elitist", "Helpful", "Trustworthy", "Brave")
par(mfrow=c(6,3), mar=c(2,4.25,1.25,.75))

la_hub_country <- c(2,4,6)

for(k in 1:6){
if(k==1)temp <- la_hub_data$hro_assoc_corr
if(k==2)temp <- la_hub_data$hro_assoc_use
if(k==3)temp <- la_hub_data$hro_assoc_elite
if(k==4)temp <- la_hub_data$hro_assoc_help
if(k==5)temp <- la_hub_data$hro_assoc_trust
if(k==6)temp <- la_hub_data$hro_assoc_brave

#temp[temp==0] <- NA

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(la_hub_country)){
    observed.values <- temp[la_hub_data$country %in% la_hub_country[i]]
    observed.weights <- la_hub_data$weight[la_hub_data$country %in% la_hub_country[i]]
    observed.values <- observed.values[!is.na(observed.values)]
    observed.weights <- observed.weights[!is.na(observed.values)]
    samples <- lapply(1:1000, function(i){
        bootstrap_samples <- sample(1:length(observed.values), replace=T, size=length(observed.values))
        bootstrap_props <- table(observed.values[bootstrap_samples])/length(observed.weights[bootstrap_samples])
        return(bootstrap_props)
    })
    stats_list[[i]] <- unlist(samples)
}

##stats <- do.call("rbind", stats_list)

prop <- prop_q025 <- prop_q975 <- list()
for(i in 1:3){
    prop[[i]] <- apply(matrix(stats_list[[i]], nrow=7, ncol=1000), 1, mean)
    prop_q025[[i]] <- apply(matrix(stats_list[[i]], nrow=7, ncol=1000), 1, quantile, .025)
    prop_q975[[i]] <- apply(matrix(stats_list[[i]], nrow=7, ncol=1000), 1, quantile, .975)
}

la_hub_country <- c(2,4,6)

for(j in 1:3){
barplot(prop[[j]], space=0, horiz=TRUE, xlim=c(0,.5), col=COLOR[k])
if(k==1) mtext(side=3, paste(la_hub_country_name[la_hub_country[j]]), line=.125)
if(j==1) mtext(side=2, paste(labels[k]), line=2.5)
axis(side=2, at=c(1,2,3,4,5,6,7)-.5, labels=c(1,2,3,4,5,6,7), las=2)
    for(i in 1:7){
        lines(c(prop_q025[[j]][i], prop_q975[[j]][i]), c(i-.5,i-.5))
    }
}

}




##################################################
##
##################################################

## ----- NEGATIVE ----- ##
## ngo_assoc_corr
## ngo_assoc_use
## ngo_assoc_elite
## ngo_assoc_us (doesn't seem to be available for any country)
## ----- POSITIVE ----- ##
## ngo_assoc_help
## ngo_assoc_trust
## ngo_assoc_connect (doesn't seem to be available for any country)
## ngo_assoc_effec
## ngo_assoc_brave

COLOR <- c("#fc8d62", "#fc8d62", "#fc8d62", "#66c2a5", "#66c2a5", "#66c2a5")
COLOR <- c("#fc8d62", "#fc8d62", "#8da0cb", "#66c2a5","#66c2a5", "#66c2a5")

labels <- c("Corruption", "Useless", "Elitist", "Helpful", "Trustworthy", "Brave")
par(mfrow=c(6,3), mar=c(2,4.25,1.25,.75))

la_hub_country <- c(2,4,6)

for(k in 1:6){
    if(k==1)temp <- la_hub_data$ngo_assoc_corr
    if(k==2)temp <- la_hub_data$ngo_assoc_use
    if(k==3)temp <- la_hub_data$ngo_assoc_elite
    if(k==4)temp <- la_hub_data$ngo_assoc_help
    if(k==5)temp <- la_hub_data$ngo_assoc_trust
    if(k==6)temp <- la_hub_data$ngo_assoc_brave
    
    #temp[temp==0] <- NA
    
    ## weight the values for mean calculation in the bootstrap function
    stats_list <- list()
    for(i in 1:length(la_hub_country)){
        observed.values <- temp[la_hub_data$country %in% la_hub_country[i]]
        observed.weights <- la_hub_data$weight[la_hub_data$country %in% la_hub_country[i]]
        observed.values <- observed.values[!is.na(observed.values)]
        observed.weights <- observed.weights[!is.na(observed.values)]
        samples <- lapply(1:1000, function(i){
            bootstrap_samples <- sample(1:length(observed.values), replace=T, size=length(observed.values))
            bootstrap_props <- table(observed.values[bootstrap_samples])/length(observed.weights[bootstrap_samples])
            return(bootstrap_props)
        })
        stats_list[[i]] <- unlist(samples)
    }
    
    ##stats <- do.call("rbind", stats_list)
    
    prop <- prop_q025 <- prop_q975 <- list()
    for(i in 1:3){
        prop[[i]] <- apply(matrix(stats_list[[i]], nrow=7, ncol=1000), 1, mean)
        prop_q025[[i]] <- apply(matrix(stats_list[[i]], nrow=7, ncol=1000), 1, quantile, .025)
        prop_q975[[i]] <- apply(matrix(stats_list[[i]], nrow=7, ncol=1000), 1, quantile, .975)
    }
    
    la_hub_country <- c(2,4,6)
    
    for(j in 1:3){
        barplot(prop[[j]], space=0, horiz=TRUE, xlim=c(0,.5), col=COLOR[k])
        if(k==1) mtext(side=3, paste(la_hub_country_name[la_hub_country[j]]), line=.125)
        if(j==1) mtext(side=2, paste(labels[k]), line=2.5)
        axis(side=2, at=c(1,2,3,4,5,6,7)-.5, labels=c(1,2,3,4,5,6,7), las=2)
        for(i in 1:7){
            lines(c(prop_q025[[j]][i], prop_q975[[j]][i]), c(i-.5,i-.5))
        }
    }
    
}


dev.off()
