## Afrobaraometer_analysis_weighted_means.R
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


## load spss  data version (this file is too big so use the binary version of the file below)
#data <- read.spss("r7_merged_data_34ctry.release.sav", to.data.frame=TRUE)

## load binary data file 
load("Data_input/r7_merged_data_34ctry_release.Rdata")
data <- afrobarometer

## country codes
data("countries")
ISO <- countrycode(as.character(unique(data$COUNTRY)), origin="country.name", destination="iso2c")
ISO

afrobarometer_country <- as.character(unique(data$COUNTRY))
afrobarometer_country_colors <- ifelse(afrobarometer_country=="Uganda", "orange", grey(.95))


pdf("Rplots_survey_data/Afrobarometer_country_plots.pdf", height=6, width=6)


##################################################
# Q14 freedom_to_say_what_you_think
##################################################
table(data$Q14)
freedom_to_say_what_you_think <- ifelse(data$Q14=="Not at all free", 1, 0) +
                                    ifelse(data$Q14=="Not very free", 2, 0) +
                                    ifelse(data$Q14=="Somewhat free", 3, 0) +
                                    ifelse(data$Q14=="Completely free", 4, 0)

freedom_to_say_what_you_think[freedom_to_say_what_you_think==0] <- NA
table(data$COUNTRY, freedom_to_say_what_you_think)


## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- freedom_to_say_what_you_think[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,4)-1, main="Freedom to say what you think", col=afrobarometer_country_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3,4)-1, labels=c(1,2,3,4))
axis(side=1, at=c(1,2,3,4)-1, labels=c("No at all free", "Not very\nfree", "Somewhat\nfree", "Completely\nfree"), tick=FALSE, line=3)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}



##################################################
# Q89D Own_computer
##################################################
table(data$Q89D)
Own_computer <- ifelse(data$Q89D=="No, don’t own", 1, 0) +
                ifelse(data$Q89D=="Yes, someone else owns", 2, 0) +
                ifelse(data$Q89D=="Yes, do own", 3, 0)
Own_computer[Own_computer==0] <- NA
table(data$COUNTRY, Own_computer)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- Own_computer[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,3)-1, main="Own Computer", col=afrobarometer_country_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3)-1, labels=c(1,2,3))
axis(side=1, at=c(1,2,3)-1, labels=c("No, do not own", "Yes, someone\nelse owns", "Yes, do own"), tick=FALSE, line=3)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}


##################################################
# Q89F Own_mobile_phone
##################################################
table(data$Q89F)
Own_mobile_phone <- ifelse(data$Q89F=="No, don’t own", 1, 0) +
                    ifelse(data$Q89F=="Yes, someone else owns", 2, 0) +
                    ifelse(data$Q89F=="Yes, do own", 3, 0)
Own_mobile_phone[Own_mobile_phone==0] <- NA
table(data$COUNTRY, Own_mobile_phone)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- Own_mobile_phone[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,3)-1, main="Own mobile phone", col=afrobarometer_country_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3)-1, labels=c(1,2,3))
axis(side=1, at=c(1,2,3)-1, labels=c("No, do not own", "Yes, someone\nelse owns", "Yes, do own"), tick=FALSE, line=3)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}




##################################################
#Q90 Mobile_phone_access_to_internet
##################################################
table(data$Q90)
#Mobile_phone_access_to_internet <- ifelse(data$Q90=="No, does not have internet access", 1, 0) +
#                                    ifelse(data$Q90=="Yes, has internet", 2, 0)
Mobile_phone_access_to_internet <- ifelse(data$Q90=="Yes, has internet", 1, 0)
table(data$COUNTRY, Mobile_phone_access_to_internet)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- Mobile_phone_access_to_internet[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)], space=0, horiz=TRUE, xlim=c(0,1), main="Mobile phone access to internet", col=afrobarometer_country_colors[order(prop)])
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i], prop_q975[order(prop)][i]), c(i-.5,i-.5))
}


##################################################
#Q91B How_often_use_the_internet
##################################################
table(data$Q91B)
How_often_use_the_internet <- ifelse(data$Q91B=="Never", 1, 0) +
                                ifelse(data$Q91B=="Less than once a month", 2, 0) +
                                ifelse(data$Q91B=="A few times a month", 3, 0) +
                                ifelse(data$Q91B=="A few times a week", 4, 0) +
                                ifelse(data$Q91B=="Everyday", 5, 0)
How_often_use_the_internet[How_often_use_the_internet==0] <- NA
table(data$COUNTRY, How_often_use_the_internet)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- How_often_use_the_internet[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,5)-1, main="How often do you use the internet", col=afrobarometer_country_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3,4,5)-1, labels=c(1,2,3,4,5))
axis(side=1, at=c(1,2,3,4,5)-1, labels=c("Never", "Less than\nonce a\nmonth", "A few\ntimes a\nmonth", "A few times\na week", "Everyday"), tick=FALSE, line=3)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}




##################################################
# Q40 How_much_fear_political_intimidation_or_violence
##################################################
table(data$Q40)
How_much_fear_political_intimidation_or_violence <- ifelse(data$Q40=="A lot", 1, 0) +
                                                    ifelse(data$Q40=="Somewhat", 2, 0) +
                                                    ifelse(data$Q40=="A little bit", 3, 0) +
                                                    ifelse(data$Q40=="Not at all", 4, 0)
How_much_fear_political_intimidation_or_violence[How_much_fear_political_intimidation_or_violence==0] <- NA
table(data$COUNTRY, How_much_fear_political_intimidation_or_violence)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- How_much_fear_political_intimidation_or_violence[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,4)-1, main="How much fear do you have of\npolitical intimidation or violence?", col=afrobarometer_country_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3,4)-1, labels=c(1,2,3,4))
axis(side=1, at=c(1,2,3,4)-1, labels=c("A lot", "Somewhat", "A little bit", "Not at all"), tick=FALSE, line=3)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}


##################################################
# Q12E Social_media_news
##################################################
table(data$Q12E)
Social_media_news <- ifelse(data$Q12E=="Never", 1, 0) +
                        ifelse(data$Q12E=="Less than once a month", 2, 0) +
                        ifelse(data$Q12E=="A few times a month", 3, 0) +
                        ifelse(data$Q12E=="A few times a week", 4, 0) +
                        ifelse(data$Q12E=="Every day", 5, 0)
Social_media_news[Social_media_news==0] <- NA
table(data$COUNTRY, Social_media_news)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- Social_media_news[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,5)-1, main="Social media news source", col=afrobarometer_country_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3,4,5)-1, labels=c(1,2,3,4,5))
axis(side=1, at=c(1,2,3,4,5)-1, labels=c("Never", "Less than\nonce a month", "A few times\na month", "A few times\na week", "Everyday"), tick=FALSE, line=3)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}



##################################################
# Q13 Discuss_politics
##################################################
table(data$Q13)
Discuss_politics <- ifelse(data$Q13=="Never", 1, 0) +
                        ifelse(data$Q13=="Occasionally", 2, 0) +
                        ifelse(data$Q13=="Frequently", 3, 0)
Discuss_politics[Discuss_politics==0] <- NA
table(data$COUNTRY, Discuss_politics)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- Discuss_politics[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)]-1, space=0, horiz=TRUE, xlim=c(1,3)-1, main="Discuss politics", col=afrobarometer_country_colors[order(prop)], xaxt="n")
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
axis(side=1, at=c(1,2,3)-1, labels=c(1,2,3))
axis(side=1, at=c(1,2,3)-1, labels=c("Never", "Occasionally", "Frequently"), tick=FALSE, line=3)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i]-1, prop_q975[order(prop)][i]-1), c(i-.5,i-.5))
}



##################################################
# Q74 Climate_change_main_cause
##################################################
table(data$Q74)
Climate_change_main_cause <- ifelse(data$Q74=="Human Activity", 1, 0)
table(data$COUNTRY, Climate_change_main_cause)

## weight the values for mean calculation in the bootstrap function
stats_list <- list()
for(i in 1:length(afrobarometer_country)){
    observed.values <- Climate_change_main_cause[data$COUNTRY %in% afrobarometer_country[i]]
    observed.weights <- data$withinwt[data$COUNTRY %in% afrobarometer_country[i]]
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

data.frame(prop, afrobarometer_country)

par(mar=c(5,10,4,3))
barplot(prop[order(prop)], space=0, horiz=TRUE, xlim=c(0,1), main="Human Activity is the\nmain cause of climate change?", col=afrobarometer_country_colors[order(prop)])
axis(side=2, at=((1:length(prop)-.5)), labels=afrobarometer_country[order(prop)], las=2, cex.axis=.75)
for(i in 1:length(afrobarometer_country)){
    lines(c(prop_q025[order(prop)][i], prop_q975[order(prop)][i]), c(i-.5,i-.5))
}



dev.off()



