## google_Amnesty_International_search_maps.R
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
  pkgs <- c("gtrendsR", "countrycode", "bcp", "ggplot2")
  groundhog.library(pkgs,'2022-04-19')
} else{
  ## or load the more recent version of the libraries
  install.packages("gtrendsR", "countrycode", "bcp", "ggplot2")
  library(gtrendsR)
  library(countrycode)
  library(bcp)
  library(ggplot2)
}

pdf("Rplots/Maps_Amnesty_International_search.pdf", height=3, width=6)


TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "hak asasi Manusia", "人权", "droits")


COLORS <- c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494")
COLORS <- c("#f0f9e8", "#bae4bc", "#7bccc4", "#43a2ca", "#0868ac")
COLORS <- c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494")
COLORS <- c("#feebe2", "#fbb4b9", "#f768a1", "#c51b8a", "#7a0177")
COLORS <- c("#ffffcc", "#c2e699", "#78c679", "#31a354", "#006837")

COLORS <- c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494", "black")
COLORS <- c("#f0f9e8", "#bae4bc", "#7bccc4", "#43a2ca", "#0868ac", "black")
COLORS <- c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494", "black")
COLORS <- c("#feebe2", "#fbb4b9", "#f768a1", "#c51b8a", "#7a0177", "black")
COLORS <- c("#ffffcc", "#c2e699", "#78c679", "#31a354", "#006837", "black")

#barplot(c(1,1,1,1,1), col=COLORS)

TIME <- "2015-01-01 2019-12-31"


## ------------------------------------------------------------ ##
## google Topic "amnesty international" (this is langauge agnostic)
english.world <- gtrends("%2Fm%2F012l0", time=TIME)
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data <- english.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#f0f9e8", "#bae4bc", "#7bccc4", "#43a2ca", "#0868ac", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
  geom_map(aes(fill = hits), map = map.world) +
  ggtitle(paste("Topic: '", "Amnesty International", "'", sep="")) +
  xlab("Latitude") + ylab("Longitude") +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")

## ------------------------------------------------------------ ##
## google English language "amnesty international" (this is langauge agnostic)
english.world <- gtrends("Amnesty International", time=TIME)
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data <- english.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#f0f9e8", "#bae4bc", "#7bccc4", "#43a2ca", "#0868ac", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
  geom_map(aes(fill = hits), map = map.world) +
  ggtitle(paste("English Langugage: '", "Amnesty International", "'", sep="")) +
  xlab("Latitude") + ylab("Longitude") +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")

dev.off()
