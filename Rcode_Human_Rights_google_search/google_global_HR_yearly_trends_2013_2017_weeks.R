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


COLORS <- c("#fdae61", "#a6cee3", "#1f78b4", "#b2df8a", "#33a02c")


##
TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "droits", "%2Fm%2F03ll3")
#TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "hak asasi Manusia", "人权", "droits")

#TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "hak asasi Manusia", "人权", "droits de l'homme")

#TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "人权", "droits humains")

#for(j in 1:8){
#   world <- gtrends(TERMS[1])$interest_over_time
#}

fit_lm <- list()

#par(mfrow=c(3,3), mar=c(2,2.5,1,.5))
#par(mfrow=c(1,1), mar=c(2,2.5,1,.5))

pdf("/Users/cjfariss/Dropbox/GOOGLEBOOK/SearchforRights\ 2/Figures/images/Global_search_hits_mean_CI_2013_2017.pdf", height=6, width=6)
#pdf("/Users/cjfariss/Dropbox/GOOGLEBOOK/SearchforRights\ 2/Figures/images/Global_search_hits_mean_CI_2014_2018.pdf", height=6, width=6)
#pdf("/Users/cjfariss/Dropbox/GOOGLEBOOK/SearchforRights\ 2/Figures/images/Global_search_hits_mean_CI_2015_2019.pdf", height=6, width=6)
#pdf("/Users/cjfariss/Dropbox/GOOGLEBOOK/SearchforRights\ 2/Figures/images/Global_search_hits_mean_CI_2016_2020.pdf", height=6, width=6)

par(mfrow=c(1,1), mar=c(2,2.5,1,.5))

TERMS_LABLES <- c("'human rights'", "'derechos humanos'", "'direitos humanos'", "'huquq al'iinsan'", "'droits'", "'human rights' (topic)")

TERMS_LABLES <- c("'human rights' (search term)", "'derechos humanos' (search term)", "'direitos humanos' (search term)", "'huquq al'iinsan' (search term)", "'droits' (search term)", "'human rights' (topic)")

#i <- 1
for(i in 1:length(TERMS)){
    world <- gtrends(TERMS[i], time="2013-01-01 2017-12-31")$interest_over_time
    #world <- gtrends(TERMS[i], time="2014-01-01 2018-12-31")$interest_over_time
    #world <- gtrends(TERMS[i], time="2015-01-01 2019-12-31")$interest_over_time
    #world <- gtrends(TERMS[i], time="2016-01-01 2020-12-31")$interest_over_time

#if(i==4)
#if(i==6) TERMS[i] <- "'human rights' (topic)"
plot(world$hits, main=paste("Global:", TERMS_LABLES[i]), lwd=1, col=grey(.75), ylim=c(0, 100), xaxt="n", yaxt="n", type="n", ylab="", xlab="")
    
    id2013 <- which(as.Date(world$date) > as.Date("2012-12-31") & as.Date(world$date) <= as.Date("2013-12-31"))
    id2014 <- which(as.Date(world$date) > as.Date("2013-12-31") & as.Date(world$date) <= as.Date("2014-12-31"))
    id2015 <- which(as.Date(world$date) > as.Date("2014-12-31") & as.Date(world$date) <= as.Date("2015-12-31"))
    id2016 <- which(as.Date(world$date) > as.Date("2015-12-31") & as.Date(world$date) <= as.Date("2016-12-31"))
    id2017 <- which(as.Date(world$date) > as.Date("2016-12-31") & as.Date(world$date) <= as.Date("2017-12-31"))
    #id2018 <- which(as.Date(world$date) > as.Date("2017-12-31") & as.Date(world$date) <= as.Date("2018-12-31"))
    #id2019 <- which(as.Date(world$date) > as.Date("2018-12-31") & as.Date(world$date) <= as.Date("2019-12-31"))

    polygon(x=c(min(id2013), min(id2013), max(id2013), max(id2013)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    polygon(x=c(min(id2015), min(id2015), max(id2015), max(id2015)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    polygon(x=c(min(id2017), min(id2017), max(id2017), max(id2017)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    #polygon(x=c(min(id2014), min(id2014), max(id2014), max(id2014)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    #polygon(x=c(min(id2016), min(id2016), max(id2016), max(id2016)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    #polygon(x=c(min(id2018), min(id2018), max(id2018), max(id2018)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    #polygon(x=c(min(id2019), min(id2019), max(id2019), max(id2019)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    box()
    
    lines(world$hits, lwd=1, col="#bdd7e7")
    axis(side=2, at=c(0,25,50,75,100), las=2)
    axis(side=1, at=c(median(id2013),  median(id2014), median(id2015), median(id2016), median(id2017)), labels=c(2013, 2014, 2015, 2016, 2017), las=1)
    #axis(side=1, at=c(median(id2014), median(id2015), median(id2016), median(id2017), median(id2018)), labels=c(2014, 2015, 2016, 2017, 2018), las=1)
    #axis(side=1, at=c(median(id2015), median(id2016), median(id2017), median(id2018), median(id2019)), labels=c(2015, 2016, 2017, 2018, 2019), las=1)
    model <- bcp(y=world$hits)
    lines(model$posterior.mean, lwd=.75, col="#08519c")
    
    #abline(reg=lm(world$hits ~ c(1:nrow(world))))
    fit_lm[[i]] <- lm(world$hits ~ c(1:nrow(world)))
    
    
    polygon(c(min(id2013), min(id2013), max(id2013), max(id2013)), c(as.numeric(t.test(world$hits[id2013])$conf.int)[1:2], as.numeric(t.test(world$hits[id2013])$conf.int)[2:1]), col=grey(.75), lwd=1, border=F, density=30)
    polygon(c(min(id2014), min(id2014), max(id2014), max(id2014)), c(as.numeric(t.test(world$hits[id2014])$conf.int)[1:2], as.numeric(t.test(world$hits[id2014])$conf.int)[2:1]), col=grey(.75), lwd=1, border=F, density=30)
    polygon(c(min(id2015), min(id2015), max(id2015), max(id2015)), c(as.numeric(t.test(world$hits[id2015])$conf.int)[1:2], as.numeric(t.test(world$hits[id2015])$conf.int)[2:1]), col=grey(.75), lwd=1, border=F, density=30)
    polygon(c(min(id2016), min(id2016), max(id2016), max(id2016)), c(as.numeric(t.test(world$hits[id2016])$conf.int)[1:2], as.numeric(t.test(world$hits[id2016])$conf.int)[2:1]), col=grey(.75), lwd=1, border=F, density=30)
    polygon(c(min(id2017), min(id2017), max(id2017), max(id2017)), c(as.numeric(t.test(world$hits[id2017])$conf.int)[1:2], as.numeric(t.test(world$hits[id2017])$conf.int)[2:1]), col=grey(.75), lwd=1, border=F, density=30)
    #polygon(c(min(id2018), min(id2018), max(id2018), max(id2018)), c(as.numeric(t.test(world$hits[id2018])$conf.int)[1:2], as.numeric(t.test(world$hits[id2018])$conf.int)[2:1]), col=grey(.75), lwd=1, border=F, density=30)
    #polygon(c(min(id2019), min(id2019), max(id2019), max(id2019)), c(as.numeric(t.test(world$hits[id2019])$conf.int)[1:2], as.numeric(t.test(world$hits[id2019])$conf.int)[2:1]), col=grey(.75), lwd=1, border=F, density=30)

    lines(id2013, rep(mean(world$hits[id2013]),length(id2013)), col="darkorange4", lwd=2, lty=2)
    lines(id2014, rep(mean(world$hits[id2014]),length(id2014)), col="darkorange4", lwd=2, lty=2)
    lines(id2015, rep(mean(world$hits[id2015]),length(id2015)), col="darkorange4", lwd=2, lty=2)
    lines(id2016, rep(mean(world$hits[id2016]),length(id2016)), col="darkorange4", lwd=2, lty=2)
    lines(id2017, rep(mean(world$hits[id2017]),length(id2017)), col="darkorange4", lwd=2, lty=2)
    #lines(id2018, rep(mean(world$hits[id2018]),length(id2018)), col="darkorange4", lwd=2, lty=2)
    #lines(id2019, rep(mean(world$hits[id2019]),length(id2019)), col="darkorange4", lwd=2, lty=2)
#}

}

dev.off()




