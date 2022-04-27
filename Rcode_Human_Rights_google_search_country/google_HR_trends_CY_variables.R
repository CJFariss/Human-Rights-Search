## clean up workspace
rm(list = ls(all.names = TRUE))
gc()

## load libraries
library(gtrendsR)
library(countrycode)
library(stm)
library(tm)
library(MASS)
library(colorbrewer)
library(bcp)

## country codes
data("countries")
ISO <- as.character(unique(countries$country_code))
COUNTRY <- countrycode(ISO, origin="iso2c", destination="country.name")


## load data for merge into trend dataframe
HRINGO <- read.csv("HRINGO_data.csv")
HRSCORES <- read.csv("M_2_Full_Data.csv")
HRSCORES <- subset(HRSCORES, YEAR>=2012)
WB <- read.csv("worldbank_trim.csv")
TREATY <- read.csv("hr_commit_trim.csv")

## country codes
data("countries")
ISO <- as.character(unique(countries$country_code))
COUNTRY <- countrycode(ISO, origin="iso2c", destination="country.name")

## add country codes to NGO data
HRINGO$iso2c <- countrycode(HRINGO$country, origin="country.name", destination="iso2c")
HRINGO$ccode <- countrycode(HRINGO$country, origin="country.name", destination="cown")
HRINGO <- subset(HRINGO, !is.na(iso2c))

HRSCORES$iso2c <- countrycode(HRSCORES$COW, origin="cown", destination="iso2c")
nrow(HRSCORES)
HRSCORES <- subset(HRSCORES, !is.na(iso2c))
nrow(HRSCORES)



WB$iso2c <- countrycode(WB$country, origin="country.name", destination="iso2c")
TREATY$iso2c <- countrycode(TREATY$country, origin="country.name", destination="iso2c")


## make a color vector for polots
COLORS <- c("#fdae61", "#a6cee3", "#1f78b4", "#b2df8a", "#33a02c")


##
TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "hak asasi Manusia", "人权", "droits humains")




## ------------------------------------------------------------ ##
## English
english.world <- gtrends(TERMS[1], time="2012-01-01 2016-12-31")
english.world <- subset(english.world$interest_by_country, !is.na(hits))
english.ISO <- countrycode(english.world$location, origin="country.name", destination="iso2c")

#english.ISO <- english.ISO[english.ISO!="NA"]
english.CCODE <- countrycode(english.ISO, origin="iso2c", destination="cown")


english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
english.world <- subset(english.world, !is.na(hits))

N <- nrow(english.world)


cy_english <- lapply(1:N, function(i){
    
    temp <- gtrends(TERMS[1], geo=c(english.ISO[i]), time="2012-01-01 2016-12-31")$interest_over_time
    
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    temp$hits <- temp$hits * (english.world$hits[i]/100)
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    year <<- as.numeric(names(table(temp[c("year")])))
    hits_mean <- sapply(1:length(year), function(j){mean(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_median <- sapply(1:length(year), function(j){median(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_max <- sapply(1:length(year), function(j){max(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_sd <- sapply(1:length(year), function(j){sd(temp[c("year","hits")]$hits[temp$year==year[j]])})
    
    ISO <- english.ISO[i]
    CCODE <- english.CCODE[i]
    
    
    ## HR INGO counts
    HRINGO_count <- rep(NA, length(year))
    for(j in 1:length(year)){
        if(length(HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]])>0){
            HRINGO_count[j] <- HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]]
        }
        
    }
    
    ## HR Scores
    theta_mean <- rep(NA, length(year))
    Amnesty <- rep(NA, length(year))
    State <- rep(NA, length(year))
    HRW <- rep(NA, length(year))
    
    for(j in 1:length(year)){
        if(length(HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) theta_mean[j] <-  HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) Amnesty[j] <- HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) State[j] <- HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) HRW[j] <-  HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
    }
    
    ## WB data
    WB <- subset(WB, !is.na(iso2c))
    gdp_growth <- NA
    gdp_pc_currentus <- NA
    gini <- NA
    literacy_per <- NA
    for(j in 1:length(year)){
        if(length(WB$gdp_growth[WB$iso2c == english.ISO[i] & WB$year==year[j]])>0) gdp_growth[j] <- WB$gdp_growth[WB$iso2c == english.ISO[i] & WB$year==year[j]]
        if(length(WB$gdp_pc_currentus[WB$iso2c == english.ISO[i] & WB$year==year[j]])>0) gdp_pc_currentus[j] <- WB$gdp_pc_currentus[WB$iso2c == english.ISO[i] & WB$year==year[j]]
        if(length(WB$gini[WB$iso2c == english.ISO[i] & WB$year==year[j]])>0) gini[j] <- WB$gini[WB$iso2c == english.ISO[i] & WB$year==year[j]]
        if(length(WB$literacy_per[WB$iso2c == english.ISO[i] & WB$year==year[j]])>0) literacy_per[j] <- WB$literacy_per[WB$iso2c == english.ISO[i] & WB$year==year[j]]
        
        
    }

    ## Treaty data
    TREATY <- subset(TREATY, !is.na(iso2c))
    rat_sum <- NA
    
    for(j in 1:length(year)){
        if(length(TREATY$rat_sum[TREATY$iso2c == english.ISO[i] & TREATY$year==year[j]])>0) rat_sum[j] <- TREATY$rat_sum[TREATY$iso2c == english.ISO[i] & TREATY$year==year[j]]

    }
    
    language <- "English"
    
    
    temp_cy <- data.frame(year, ISO, CCODE, language, hits_mean, hits_median, hits_max, hits_sd, HRINGO_count, theta_mean, Amnesty, State, HRW, gdp_growth, gdp_pc_currentus, gini, literacy_per, rat_sum)
    return(temp_cy)
})

english.dat <- do.call("rbind", cy_english)

write.csv(english.dat, "english.dat.csv")

summary(lm(hits_max ~ HRINGO_count + theta_mean,data= subset(english.dat, CCODE!=2)))
summary(lm(hits_mean ~ HRINGO_count + theta_mean,data= subset(english.dat, CCODE!=2)))
summary(lm(hits_median ~ HRINGO_count + theta_mean,data= subset(english.dat, CCODE!=2)))

summary(lm(hits_max ~ theta_mean,data= subset(english.dat, CCODE!=2)))
summary(lm(hits_mean ~ theta_mean,data= subset(english.dat, CCODE!=2)))
summary(lm(hits_median ~ theta_mean,data= subset(english.dat, CCODE!=2)))



## ------------------------------------------------------------ ##
## Spanish
spanish.world <- gtrends(TERMS[2])
spanish.world <- subset(spanish.world$interest_by_country, !is.na(hits))
spanish.ISO <- countrycode(spanish.world$location, origin="country.name", destination="iso2c")
spanish.CCODE <- countrycode(spanish.ISO, origin="iso2c", destination="cown")

spanish.world$hits[spanish.world$hits=="<1"] <- .5
spanish.world$hits <- as.numeric(spanish.world$hits)
spanish.world <- subset(spanish.world, !is.na(hits))


N <- nrow(spanish.world)
cy_spanish <- lapply(1:N, function(i){
    
    temp <- gtrends(TERMS[2], geo=c(spanish.ISO[i]), time="2012-01-01 2016-12-31")$interest_over_time
    
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    
    temp$hits <- temp$hits * (spanish.world$hits[i]/100)
    
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    year <- as.numeric(names(table(temp[c("year")])))
    hits_mean <- sapply(1:length(year), function(j){mean(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_median <- sapply(1:length(year), function(j){median(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_max <- sapply(1:length(year), function(j){max(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_sd <- sapply(1:length(year), function(j){sd(temp[c("year","hits")]$hits[temp$year==year[j]])})
    
    ISO <- spanish.ISO[i]
    CCODE <- spanish.CCODE[i]
    
    HRINGO_count <- rep(NA, length(year))
    for(j in 1:length(year)){
        if(length(HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]])>0){
            HRINGO_count[j] <- HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]]
        }
        
    }
    
    theta_mean <- rep(NA, length(year))
    Amnesty <- rep(NA, length(year))
    State <- rep(NA, length(year))
    HRW <- rep(NA, length(year))
    
    for(j in 1:length(year)){
        if(length(HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) theta_mean[j] <-  HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) Amnesty[j] <- HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) State[j] <- HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) HRW[j] <-  HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
    }
    language <- "Spanish"
    
    
    temp_cy <- data.frame(year, ISO, CCODE, language, hits_mean, hits_median, hits_max, hits_sd, HRINGO_count, theta_mean, Amnesty, State, HRW)
    return(temp_cy)
})

spanish.dat <- do.call("rbind", cy_spanish)
write.csv(spanish.dat, "spanish.dat.csv")

summary(lm(hits_max ~ HRINGO_count + theta_mean,data= subset(spanish.dat, CCODE!=2)))
summary(lm(hits_mean ~ HRINGO_count + theta_mean,data= subset(spanish.dat, CCODE!=2)))
summary(lm(hits_median ~ HRINGO_count + theta_mean,data= subset(spanish.dat, CCODE!=2)))

summary(lm(hits_max ~ theta_mean,data= subset(spanish.dat, CCODE!=2)))
summary(lm(hits_mean ~ theta_mean,data= subset(spanish.dat, CCODE!=2)))
summary(lm(hits_median ~ theta_mean,data= subset(spanish.dat, CCODE!=2)))



## ------------------------------------------------------------ ##
## Portugese
portugese.world <- gtrends(TERMS[3])
portugese.world <- subset(portugese.world$interest_by_country, !is.na(hits))
portugese.ISO <- countrycode(portugese.world$location, origin="country.name", destination="iso2c")
portugese.CCODE <- countrycode(portugese.ISO, origin="iso2c", destination="cown")

portugese.world$hits[portugese.world$hits=="<1"] <- .5
portugese.world$hits <- as.numeric(portugese.world$hits)
portugese.world <- subset(portugese.world, !is.na(hits))


N <- nrow(portugese.world)
cy_portugese <- lapply(1:N, function(i){
    
    temp <- gtrends(TERMS[3], geo=c(portugese.ISO[i]), time="2012-01-01 2016-12-31")$interest_over_time
    
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    
    temp$hits <- temp$hits * (portugese.world$hits[i]/100)
    
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    year <- as.numeric(names(table(temp[c("year")])))
    hits_mean <- sapply(1:length(year), function(j){mean(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_median <- sapply(1:length(year), function(j){median(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_max <- sapply(1:length(year), function(j){max(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_sd <- sapply(1:length(year), function(j){sd(temp[c("year","hits")]$hits[temp$year==year[j]])})
    
    ISO <- portugese.ISO[i]
    CCODE <- portugese.CCODE[i]
    
    HRINGO_count <- rep(NA, length(year))
    for(j in 1:length(year)){
        if(length(HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]])>0){
            HRINGO_count[j] <- HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]]
        }
        
    }
    
    theta_mean <- rep(NA, length(year))
    Amnesty <- rep(NA, length(year))
    State <- rep(NA, length(year))
    HRW <- rep(NA, length(year))
    
    for(j in 1:length(year)){
        if(length(HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) theta_mean[j] <-  HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) Amnesty[j] <- HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) State[j] <- HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) HRW[j] <-  HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
    }
    language <- "Portugese"
    
    
    temp_cy <- data.frame(year, ISO, CCODE, language, hits_mean, hits_median, hits_max, hits_sd, HRINGO_count, theta_mean, Amnesty, State, HRW)
    return(temp_cy)
})

portugese.dat <- do.call("rbind", cy_portugese)
write.csv(portugese.dat, "portugese.dat.csv")

summary(lm(hits_max ~ HRINGO_count + theta_mean,data= subset(portugese.dat, CCODE!=2)))
summary(lm(hits_mean ~ HRINGO_count + theta_mean,data= subset(portugese.dat, CCODE!=2)))
summary(lm(hits_median ~ HRINGO_count + theta_mean,data= subset(portugese.dat, CCODE!=2)))

summary(lm(hits_max ~ theta_mean,data= subset(portugese.dat, CCODE!=2)))
summary(lm(hits_mean ~ theta_mean,data= subset(portugese.dat, CCODE!=2)))
summary(lm(hits_median ~ theta_mean,data= subset(portugese.dat, CCODE!=2)))



## ------------------------------------------------------------ ##
## Arabic
arabic.world <- gtrends(TERMS[4])
arabic.world <- subset(arabic.world$interest_by_country, !is.na(hits))
arabic.ISO <- countrycode(arabic.world$location, origin="country.name", destination="iso2c")
arabic.CCODE <- countrycode(arabic.ISO, origin="iso2c", destination="cown")

arabic.world$hits[arabic.world$hits=="<1"] <- .5
arabic.world$hits <- as.numeric(arabic.world$hits)
arabic.world <- subset(arabic.world, !is.na(hits))


N <- nrow(arabic.world)
cy_arabic <- lapply(1:N, function(i){
    
    temp <- gtrends(TERMS[4], geo=c(arabic.ISO[i]), time="2012-01-01 2016-12-31")$interest_over_time
    
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    
    temp$hits <- temp$hits * (arabic.world$hits[i]/100)
    
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    year <- as.numeric(names(table(temp[c("year")])))
    hits_mean <- sapply(1:length(year), function(j){mean(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_median <- sapply(1:length(year), function(j){median(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_max <- sapply(1:length(year), function(j){max(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_sd <- sapply(1:length(year), function(j){sd(temp[c("year","hits")]$hits[temp$year==year[j]])})
    
    ISO <- arabic.ISO[i]
    CCODE <- arabic.CCODE[i]
    
    HRINGO_count <- rep(NA, length(year))
    for(j in 1:length(year)){
        if(length(HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]])>0){
            HRINGO_count[j] <- HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]]
        }
        
    }
    
    theta_mean <- rep(NA, length(year))
    Amnesty <- rep(NA, length(year))
    State <- rep(NA, length(year))
    HRW <- rep(NA, length(year))
    
    for(j in 1:length(year)){
        if(length(HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) theta_mean[j] <-  HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) Amnesty[j] <- HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) State[j] <- HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) HRW[j] <-  HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
    }
    language <- "Arabic"
    
    
    temp_cy <- data.frame(year, ISO, CCODE, language, hits_mean, hits_median, hits_max, hits_sd, HRINGO_count, theta_mean, Amnesty, State, HRW)
    return(temp_cy)
})

arabic.dat <- do.call("rbind", cy_arabic)
write.csv(arabic.dat, "arabic.dat.csv")

summary(lm(hits_max ~ HRINGO_count + theta_mean,data= subset(arabic.dat, CCODE!=2)))
summary(lm(hits_mean ~ HRINGO_count + theta_mean,data= subset(arabic.dat, CCODE!=2)))
summary(lm(hits_median ~ HRINGO_count + theta_mean,data= subset(arabic.dat, CCODE!=2)))

summary(lm(hits_max ~ theta_mean,data= subset(arabic.dat, CCODE!=2)))
summary(lm(hits_mean ~ theta_mean,data= subset(arabic.dat, CCODE!=2)))
summary(lm(hits_median ~ theta_mean,data= subset(arabic.dat, CCODE!=2)))




## ------------------------------------------------------------ ##
## French
french.world <- gtrends(TERMS[8])
french.world <- subset(french.world$interest_by_country, !is.na(hits))
french.ISO <- countrycode(french.world$location, origin="country.name", destination="iso2c")
french.CCODE <- countrycode(french.world$location, origin="country.name", destination="cown")

french.world$hits[french.world$hits=="<1"] <- .5
french.world$hits <- as.numeric(french.world$hits)
french.world <- subset(french.world, !is.na(hits))


N <- nrow(french.world)
cy_french <- lapply(1:N, function(i){
    
    temp <- gtrends(TERMS[8], geo=c(french.ISO[i]))$interest_over_time
    temp$hits[temp$hits=="<1"] <- .5
    temp$hits <- as.numeric(temp$hits)
    
    temp$hits <- temp$hits * (french.world$hits[i]/100)
    
    temp$year <- as.numeric(format(as.Date(temp$date, formate="%Y %B %d"), "%Y"))
    
    year <- as.numeric(names(table(temp[c("year")])))
    hits_mean <- sapply(1:length(year), function(j){mean(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_median <- sapply(1:length(year), function(j){median(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_max <- sapply(1:length(year), function(j){max(temp[c("year","hits")]$hits[temp$year==year[j]])})
    hits_sd <- sapply(1:length(year), function(j){sd(temp[c("year","hits")]$hits[temp$year==year[j]])})
    
    ISO <- french.ISO[i]
    CCODE <- french.CCODE[i]
    
    HRINGO_count <- rep(NA, length(year))
    for(j in 1:length(year)){
        if(length(HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]])>0){
            HRINGO_count[j] <- HRINGO$Total_HRINGOs[HRINGO$iso2c == english.ISO[i] & HRINGO$year==year[j]]
        }
        
    }
    
    theta_mean <- rep(NA, length(year))
    Amnesty <- rep(NA, length(year))
    State <- rep(NA, length(year))
    HRW <- rep(NA, length(year))
    
    for(j in 1:length(year)){
        if(length(HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) theta_mean[j] <-  HRSCORES$theta_mean[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) Amnesty[j] <- HRSCORES$Amnesty[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) State[j] <- HRSCORES$State[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
        if(length(HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]])>0) HRW[j] <-  HRSCORES$HRW[HRSCORES$iso2c == english.ISO[i] & HRSCORES$YEAR==year[j]]
    }
    language <- "French"
    
    
    temp_cy <- data.frame(year, ISO, CCODE, language, hits_mean, hits_median, hits_max, hits_sd, HRINGO_count, theta_mean, Amnesty, State, HRW)
    return(temp_cy)
})



french.dat <- do.call("rbind", cy_french)
write.csv(french.dat, "french.dat.csv")

summary(lm(hits_max ~ HRINGO_count + theta_mean,data= subset(french.dat, CCODE!=2)))
summary(lm(hits_mean ~ HRINGO_count + theta_mean,data= subset(french.dat, CCODE!=2)))
summary(lm(hits_median ~ HRINGO_count + theta_mean,data= subset(french.dat, CCODE!=2)))

summary(lm(hits_max ~ theta_mean,data= subset(french.dat, CCODE!=2)))
summary(lm(hits_mean ~ theta_mean,data= subset(french.dat, CCODE!=2)))
summary(lm(hits_median ~ theta_mean,data= subset(french.dat, CCODE!=2)))





######

full.dat <- rbind(english.dat, spanish.dat, portugese.dat, arabic.dat, french.dat)
write.csv(full.dat, "full.dat.csv")




summary(lm(hits_max ~ -1 + HRINGO_count + theta_mean + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_mean ~ -1 + HRINGO_count + theta_mean + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_median ~ -1 + HRINGO_count + theta_mean + as.factor(language),data= subset(full.dat, CCODE!=2)))

summary(lm(hits_max ~ -1 + theta_mean + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_mean ~ -1 + theta_mean + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_median ~ -1 + theta_mean + as.factor(language),data= subset(full.dat, CCODE!=2)))



summary(lm(hits_max ~ -1 + HRINGO_count + theta_mean + as.factor(CCODE) + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_mean ~ -1 + HRINGO_count + theta_mean + as.factor(CCODE) + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_median ~ -1 + HRINGO_count + theta_mean + as.factor(CCODE) + as.factor(language),data= subset(full.dat, CCODE!=2)))

summary(lm(hits_max ~ -1 + theta_mean + as.factor(CCODE) + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_mean ~ -1 + theta_mean + as.factor(CCODE) + as.factor(language),data= subset(full.dat, CCODE!=2)))
summary(lm(hits_median ~ -1 + theta_mean + as.factor(CCODE) + as.factor(language),data= subset(full.dat, CCODE!=2)))



