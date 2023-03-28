## WorldValuesSurvey_analysis_weighted_means.R
##########################################################################
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
## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

## load Stata 13 data version (this file is too big so use the binary version of the file below)
#wvs_data <- read.dta13("WVS_Cross-National_Wave_7_inverted_stata_v1_4.dta")
## wvs_data <- read.dta("WVS_Cross-National_Wave_7_inverted_stata_v1_4.dta")
##names(wvs_data)
#wvs_data <- read.dta("EVS_WVS_Joint_v1.1.0 STATA.dta")
#names(wvs_data)

## load binary data file 
load("Data_input/WVS_Cross-National_Wave_7_inverted_stata_v1_4.Rdata")
wvs_data <- WVS

LA_country_ids <- c("Argentina", "Bolivia", "Brazil", "Chile", "Colombia", "Ecuador", "Guatemala", "Mexico", "Nicaragua", "Peru")
LA_country_ids_colors <- c("#e9a3c9", "#f7f7f7", "#f7f7f7", "#f7f7f7", "#f7f7f7", "#f7f7f7", "#a1d76a", "#f7f7f7", "#f7f7f7", "#f7f7f7", "#f7f7f7")
LA_country_ids_colors <- c("#f7f7f7", "#f7f7f7", "#f7f7f7", "#f7f7f7", "#f7f7f7", "#f7f7f7", "black", "#f7f7f7", "#f7f7f7", "#f7f7f7", "#f7f7f7")

#pdf("Rplots_survey_data/WVS_LA_country_plots.pdf", height=6, width=6)
pdf("Rplots_survey_data/WVS_LA_country_plots_wide.pdf", height=6.75, width=12)

##################################################
# Q93 Here are some questions about international organizations. Many people don't know the answers to these questions, but if you do please tell me. Which of the following problems does the organization Amnesty International deal with?
##################################################
table(wvs_data$Q93)
human_rights_knowledge <- ifelse(wvs_data$Q93=="Human rights", 1, 0)
table(human_rights_knowledge)
table(wvs_data$B_COUNTRY, human_rights_knowledge)

## weight the values for mean calculation duh
#human_rights_knowledge <- human_rights_knowledge * wvs_data$W_WEIGHT

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(LA_country_ids)){
    observed.values <- human_rights_knowledge[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
    observed.weights <- wvs_data$W_WEIGHT[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
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

data.frame(prop, LA_country_ids)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)], space=0, horiz=TRUE, xlim=c(0,1), main="World Values Survey (WVS 2019): \nProportion of Correct Response to the Question: \nWhich of the following problems does the \norganization Amnesty International deal with? ", col=LA_country_ids_colors[order(prop)])
axis(side=2, at=((1:length(prop)-.5)), labels=LA_country_ids[order(prop)], las=2, cex.axis=1)
for(i in 1:10){
    lines(c(prop_q025[order(prop)][i], prop_q975[order(prop)][i]), c(i-.5,i-.5))
}

##################################################
# Q253 How much respect is there for individual human rights nowadays in this country?
##################################################
table(wvs_data$Q253)
human_rights_perception <- ifelse(wvs_data$Q253=="No respect at all", 1, 0) +
                                    ifelse(wvs_data$Q253=="Not much respect", 2, 0) +
                                    ifelse(wvs_data$Q253=="Fairly much  respect", 3, 0) +
                                    ifelse(wvs_data$Q253=="A great deal of respect for individual human rights", 4, 0)
table(human_rights_perception)
table(wvs_data$B_COUNTRY, human_rights_perception)

## weight the values for mean calculation
#human_rights_perception <- human_rights_perception * wvs_data$W_WEIGHT

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(LA_country_ids)){
    observed.values <- human_rights_perception[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
    observed.weights <- wvs_data$W_WEIGHT[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
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

data.frame(prop, LA_country_ids)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,4)-1, main="World Values Survey (WVS 2019): \nHow much respect is there for individual\nhuman rights nowadays in this country?", col=LA_country_ids_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=LA_country_ids[order(prop)], las=2, cex.axis=1)
axis(side=1, at=c(1,2,3,4)-1, labels=c(1,2,3,4))
axis(side=1, at=c(1,2,3,4)-1, labels=c("No respect\nat all", "Not much\nrespect", "Fairly much\nrespect", "A great\ndeal of respect"), tick=FALSE, line=3)
for(i in 1:10){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}


##################################################
# Q206 Information source: Internet
# People learn what is going on in this country and the world from various sources. For each of the following sources, please indicate whether you use it to obtain information daily, weekly, monthly, less than monthly or never: Internet
##################################################
table(wvs_data$Q206)
Information_source_internet <- ifelse(wvs_data$Q206=="Never", 1, 0) +
                                ifelse(wvs_data$Q206=="Less than monthly", 2, 0) +
                                ifelse(wvs_data$Q206=="Monthly", 3, 0) +
                                ifelse(wvs_data$Q206=="Weekly", 4, 0) +
                                ifelse(wvs_data$Q206=="Daily", 5, 0)
table(Information_source_internet)
table(wvs_data$B_COUNTRY, Information_source_internet)

## weight the values for mean calculation
#Information_source_internet <- Information_source_internet * wvs_data$W_WEIGHT

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(LA_country_ids)){
    observed.values <- Information_source_internet[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
    observed.weights <- wvs_data$W_WEIGHT[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
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

data.frame(prop, LA_country_ids)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,5)-1, main="World Values Survey (WVS 2019): \nInternet as a Source for Information", col=LA_country_ids_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=LA_country_ids[order(prop)], las=2, cex.axis=1)
axis(side=1, at=c(1,2,3,4,5)-1, labels=c(1,2,3,4,5))
axis(side=1, at=c(1,2,3,4,5)-1, labels=c("Never", "Less than\n monthly", "Monthly", "Weekly", "Daily"), tick=FALSE, line=3)
for(i in 1:10){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}


##################################################
# Q217 Political actions online: Searching information about politics and political events
# Now I’d like you to look at this card. I’m going to read out some other forms of political action that people can take using Internet and social media tools like Facebook, Twitter etc., and I’d like you to tell me, for each one, whether you have done any of these things, whether you might do it or would never under any circumstances do it: Searching information about politics and political events
##################################################
table(wvs_data$Q217)
Searching_information_about_politics <- ifelse(wvs_data$Q217=="Would never do", 1, 0) +
                                        ifelse(wvs_data$Q217=="Might do", 2, 0) +
                                        ifelse(wvs_data$Q217=="Have done", 3, 0)
table(Searching_information_about_politics)
table(wvs_data$B_COUNTRY, Searching_information_about_politics)

## weight the values for mean calculation
#Searching_information_about_politics <- Searching_information_about_politics * wvs_data$W_WEIGHT

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(LA_country_ids)){
    observed.values <- Searching_information_about_politics[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
    observed.weights <- wvs_data$W_WEIGHT[wvs_data$B_COUNTRY %in% LA_country_ids[i]]
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

data.frame(prop, LA_country_ids)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,3)-1, main="World Values Survey (WVS 2019): \nOnline Searching for Information \nabout Politics and Political Events", col=LA_country_ids_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=LA_country_ids[order(prop)], las=2, cex.axis=1)
axis(side=1, at=c(1,2,3)-1, labels=c(1,2,3))
axis(side=1, at=c(1,2,3)-1, labels=c("Would never do", "Might do", "Have done"), tick=FALSE, line=3)
for(i in 1:10){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}

dev.off()


