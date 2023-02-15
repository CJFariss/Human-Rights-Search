## LAPOP_analysis_weighted_means.R
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
#LAPOP_data <- read.dta13("2016_LAPOP_AmericasBarometer_Merge_v1.5_W.dta")

## load binary data file 
load("Data_input/2016_LAPOP_AmericasBarometer_Merge_v1.5_W.Rdata")
LAPOP_data <- LAPOP

LAPOP_data$pais <- as.character(LAPOP_data$pais)
LAPOP_data$pais <- as.factor(LAPOP_data$pais)

##  "Guyana", "Grenada", "Saint Lucia", "Dominica", "Saint Vincent and the Grenadines", "Saint Kitts and Nevis",
LAPOP_country_ids <- c("Guatemala", "Argentina", "Mexico", "El Salvador", "Honduras", "Nicaragua", "Costa Rica", "Panama", "Colombia", "Ecuador", "Bolivia", "Peru", "Paraguay", "Chile", "Uruguay", "Brazil", "Venezuela", "Dominican Republic", "Haiti", "Jamaica","United States", "Canada")
LAPOP_country_ids_colors <- c("#a1d76a", "#e9a3c9", rep("#f7f7f7", length(LAPOP_country_ids)-2))

pdf("Rplots_survey_data/LAPOP_country_plots.pdf", height=6, width=6)

## country codes
#data("countries")
LAPOP_data$ISO <- countrycode(as.character(LAPOP_data$pais), origin="country.name", destination="iso2c")
dim(LAPOP_data)
LAPOP_data <- subset(LAPOP_data, !is.na(ISO))
dim(LAPOP_data)
ISO <- unique(LAPOP_data$ISO)
ISO



##################################################
# www1 internet_usage
##################################################
table(LAPOP_data$www1)
internet_usage <- ifelse(LAPOP_data$www1=="Never", 1, 0) +
                    ifelse(LAPOP_data$www1=="Rarely", 2, 0) +
                    ifelse(LAPOP_data$www1=="A few times a month", 3, 0) +
                    ifelse(LAPOP_data$www1=="A few times a week", 4, 0) +
                    ifelse(LAPOP_data$www1=="Daily", 5, 0)
internet_usage[internet_usage==0] <- NA
table(LAPOP_data$pais, internet_usage)

## weight the values for mean calculation
#internet_usage <- internet_usage * LAPOP_data$wt

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(LAPOP_country_ids)){
    observed.values <- internet_usage[LAPOP_data$pais %in% LAPOP_country_ids[i]]
    observed.weights <- LAPOP_data$wt[LAPOP_data$pais %in% LAPOP_country_ids[i]]
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

data.frame(prop, LAPOP_country_ids)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,5)-1, main="Latin American Public Opinion Project\n(LAPOP 2016/2017):\nInternet Use", col=LAPOP_country_ids_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=LAPOP_country_ids[order(prop)], las=2, cex.axis=1)
axis(side=1, at=c(1,2,3,4,5)-1, labels=c(1,2,3,4,5))
axis(side=1, at=c(1,2,3,4,5)-1, labels=c("Never", "Less than\nmonthly", "Monthly", "Weekly", "Daily"), tick=FALSE, line=3)
for(i in 1:length(LAPOP_country_ids)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}



##################################################
# lib2c freedom_of_expression
##################################################
table(LAPOP_data$lib2c)
freedom_of_expression <- ifelse(LAPOP_data$lib2c=="Very Little", 1, 0) #+
                        #ifelse(LAPOP_data$lib2c=="Enough", 2, 0) +
                        #ifelse(LAPOP_data$lib2c=="Too Much", 3, 0)
#freedom_of_expression[freedom_of_expression==0] <- NA
table(LAPOP_data$pais, freedom_of_expression)

## weight the values for mean calculation
#freedom_of_expression <- freedom_of_expression * LAPOP_data$wt

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(LAPOP_country_ids)){
    observed.values <- freedom_of_expression[LAPOP_data$pais %in% LAPOP_country_ids[i]]
    observed.weights <- LAPOP_data$wt[LAPOP_data$pais %in% LAPOP_country_ids[i]]
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

data.frame(prop, LAPOP_country_ids)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)], space=0, horiz=TRUE, xlim=c(0,1), main="Latin American Public Opinion Project\n(LAPOP 2016/2017):\n`Very Little' Freedom of Expression", col=LAPOP_country_ids_colors[order(prop)])
axis(side=2, at=((1:length(prop)-.5)), labels=LAPOP_country_ids[order(prop)], las=2, cex.axis=1)
axis(side=1, at=c(1,2)-1, labels=c("No", "Yes"), tick=FALSE, line=3)
for(i in 1:length(LAPOP_country_ids)){
    lines(c(prop_q025[order(prop)][i], prop_q975[order(prop)][i]), c(i-.5,i-.5))
}


##################################################
# lib4 human_rights
##################################################
table(LAPOP_data$lib4)
human_rights <- ifelse(LAPOP_data$lib4=="Very Little", 1, 0) #+
                        #ifelse(LAPOP_data$lib4=="Enough", 2, 0) +
                        #ifelse(LAPOP_data$lib4=="Too Much", 3, 0)
#human_rights[human_rights==0] <- NA
table(LAPOP_data$pais, human_rights)

## weight the values for mean calculation
#human_rights <- human_rights * LAPOP_data$wt

## weight the values for mean calculation in the bootstrap function
stats_list <- list()

## switched to reverse order to match the order of presentation in the published article
for(i in length(LAPOP_country_ids):1){
    observed.values <- human_rights[LAPOP_data$pais %in% LAPOP_country_ids[i]]
    observed.weights <- LAPOP_data$wt[LAPOP_data$pais %in% LAPOP_country_ids[i]]
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

data.frame(prop, LAPOP_country_ids)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)], space=0, horiz=TRUE, xlim=c(0,1), main="Latin American Public Opinion Project\n(LAPOP 2016/2017):\n`Very Little' Human Rights", col=LAPOP_country_ids_colors[order(prop)])
axis(side=2, at=((1:length(prop)-.5)), labels=LAPOP_country_ids[order(prop)], las=2, cex.axis=1)
axis(side=1, at=c(1,2)-1, labels=c("No", "Yes"), tick=FALSE, line=3)
for(i in 1:length(LAPOP_country_ids)){
    lines(c(prop_q025[order(prop)][i], prop_q975[order(prop)][i]), c(i-.5,i-.5))
}

dev.off()



