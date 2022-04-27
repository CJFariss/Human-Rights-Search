## google_topics_paired_comparisons.R
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


## Do this (set to TRUE) to load libraries using the version from when the scripts were originally run
if(FALSE){
  ## load an older version of the libraries
  remotes::install_github('CredibilityLab/groundhog')
  library(groundhog)
  pkgs <- c("gtrendsR")
  groundhog.library(pkgs,'2022-04-19')
} else{
  ## or load the more recent version of the libraries
  install.packages("gtrendsR")
  library(gtrendsR)
}


pdf("Rplots/Google_topic_pairs.pdf", height=6, width=6)

TERMS <- list(c("human rights", "Amnesty International"),
              c("%2Fm%2F03ll3", "%2Fm%2F012l0")
              
)
length(TERMS)

TERMS_names <- list(c("human rights term", "Amnesty International term"),
                    c("human rights topic", "Amnesty International topic")
)


#TIME <- "2013-01-01 2017-12-31"
TIME <- "2015-01-01 2019-12-31"

#par(mfrow=c(3,3), mar=c(2,2.5,1,.5))
par(mfrow=c(1,1), mar=c(2,2.5,1,.5))

for(i in 1:length(TERMS)){
  
  world <- gtrends(TERMS[[i]], time=TIME, low_search_volume=T)$interest_over_time
  
  world$hits[world$hits=="<1"] <- .5
  world$hits <- as.numeric(world$hits)
  
  plot(world$hits[world$keyword==TERMS[[i]][1]], main=paste("Global:", TERMS_names[[i]][1], "vs.", TERMS_names[[i]][2]), lwd=1, col=grey(.75), ylim=c(0, 100), xaxt="n", yaxt="n", type="n")
  #lines(world$hits[world$keyword==TERMS[[i]][2]], type="l", ylim=c(0,100), col=2)
  #plot.window(xlim=c(1,length(world$hits[world$keyword==TERMS[[i]][1]])), ylim=c(0, 100))
  #mtext(side=3, text=paste("Global:", TERMS[[i]][1], "vs.", TERMS[[i]][2]), line=1)
  
  id2013 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2012-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2013-12-31"))
  id2014 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2013-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2014-12-31"))
  id2015 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2014-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2015-12-31"))
  id2016 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2015-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2016-12-31"))
  id2017 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2016-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2017-12-31"))
  id2018 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2017-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2018-12-31"))
  id2019 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2018-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2019-12-31"))
  id2020 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2019-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2020-12-31"))
  id2021 <- which(as.Date(world$date[world$keyword==TERMS[[i]][1]]) > as.Date("2020-12-31") & as.Date(world$date[world$keyword==TERMS[[i]][1]]) <= as.Date("2021-12-31"))
  
  polygon(x=c(min(id2013), min(id2013), max(id2013), max(id2013)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  polygon(x=c(min(id2015), min(id2015), max(id2015), max(id2015)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  polygon(x=c(min(id2017), min(id2017), max(id2017), max(id2017)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  polygon(x=c(min(id2019), min(id2019), max(id2019), max(id2019)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  polygon(x=c(min(id2021), min(id2021), max(id2021), max(id2021)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  box()
  
  
  lines(world$hits[world$keyword==TERMS[[i]][1]], lwd=1, col="#c2a5cf")
  lines(world$hits[world$keyword==TERMS[[i]][2]], lwd=1, col="#a6dba0")
  axis(side=2, at=c(0,25,50,75,100), las=2)
  axis(side=1, at=c(median(id2013),  median(id2014), median(id2015), median(id2016), median(id2017), median(id2018), median(id2019), median(id2020), median(id2021)), labels=c(2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021), las=1)
  model <- bcp(y=world$hits[world$keyword==TERMS[[i]][1]])
  lines(model$posterior.mean, lwd=.75, col="#7b3294")
  model <- bcp(y=world$hits[world$keyword==TERMS[[i]][2]])
  lines(model$posterior.mean, lwd=.75, col="#008837")
  
  legend("topleft", legend=c(TERMS_names[[i]][1]), text.col="#7b3294" ,bty="n")
  legend("bottomleft", legend=c(TERMS_names[[i]][2]), text.col="#008837", bty="n")
  
}

dev.off()


