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


#pdf("Google_search_term_pairs.pdf", height=6, width=6)
#pdf("/Users/cjfariss/Dropbox/FarissDancy/SearchforRights/Figures/Rplots/Google_search_term_pairs.pdf", height=6, width=6)
pdf("/Users/christopherfariss/Dropbox/GOOGLEBOOK/SearchforRights\ 2/Figures/Rplots/Google_search_term_pairs.pdf", height=6, width=6)

#plot.new()

TERMS <- list(c("facebook", "google"),
            c("google", "time"),
            c("time", "sports"),
            c("sports", "war"),
            c("war", "god"),
            c("god", "bible"),
            c("bible", "race"),
            c("race", "injustice"),
            c("injustice", "human rights"),
            c("human rights", "terrorism"),
            c("human rights", "malaria"),
            c("human rights", "nationalism"),
            c("human rights", "national security"),
            c("human rights", "sovereignty"),
            c("human rights", "will of the people"),
            c("human rights", "social justice"),
            c("human rights", "rule of law"),
            c("human rights", "populism"),
            #c(URLdecode("%2Fm%2F03ll3"), "human rights"),
            c("human rights", "climate change"),
            c("human rights", "right to health"),
            c("human rights", "right to food"),
            c("human rights", "torture")

)
length(TERMS)

#par(mfrow=c(3,3), mar=c(2,2.5,1,.5))
par(mfrow=c(1,1), mar=c(2,2.5,1,.5))

for(i in 1:length(TERMS)){

world <- gtrends(TERMS[[i]], time="2013-01-01 2017-12-31", low_search_volume=T)$interest_over_time

    world$hits[world$hits=="<1"] <- .5
    world$hits <- as.numeric(world$hits)
    
    plot(world$hits[world$keyword==TERMS[[i]][1]], main=paste("Global:", TERMS[[i]][1], "vs.", TERMS[[i]][2]), lwd=1, col=grey(.75), ylim=c(0, 100), xaxt="n", yaxt="n", type="n")
    #lines(world$hits[world$keyword==TERMS[[i]][2]], type="l", ylim=c(0,100), col=2)
    #plot.window(xlim=c(1,length(world$hits[world$keyword==TERMS[[i]][1]])), ylim=c(0, 100))
    #mtext(side=3, text=paste("Global:", TERMS[[i]][1], "vs.", TERMS[[i]][2]), line=1)
    
    id2013 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2012-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2013-12-31"))
    id2014 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2013-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2014-12-31"))
    id2015 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2014-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2015-12-31"))
    id2016 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2015-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2016-12-31"))
    id2017 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2016-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2017-12-31"))
    #id2018 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2017-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2018-12-31"))

    polygon(x=c(min(id2013), min(id2013), max(id2013), max(id2013)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    polygon(x=c(min(id2015), min(id2015), max(id2015), max(id2015)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    polygon(x=c(min(id2017), min(id2017), max(id2017), max(id2017)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
    box()

    lines(world$hits[world$keyword==TERMS[[i]][1]], lwd=1, col="#c2a5cf")
    lines(world$hits[world$keyword==TERMS[[i]][2]], lwd=1, col="#a6dba0")
    axis(side=2, at=c(0,25,50,75,100), las=2)
    axis(side=1, at=c(median(id2013),  median(id2014), median(id2015), median(id2016), median(id2017)), labels=c(2013, 2014, 2015, 2016, 2017), las=1)
    model <- bcp(y=world$hits[world$keyword==TERMS[[i]][1]])
    lines(model$posterior.mean, lwd=.75, col="#7b3294")
    model <- bcp(y=world$hits[world$keyword==TERMS[[i]][2]])
    lines(model$posterior.mean, lwd=.75, col="#008837")
    
    legend("topleft", legend=c(TERMS[[i]][1]), text.col="#7b3294" ,bty="n")
    legend("bottomleft", legend=c(TERMS[[i]][2]), text.col="#008837", bty="n")

}

dev.off()


