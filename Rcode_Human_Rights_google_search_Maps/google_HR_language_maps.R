## google_HR_language_maps.R
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

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

pdf("Rplots/Maps_Human_Rights_language_groups.pdf", height=3, width=6)


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


TIME <- "2015-01-01 2019-12-31"


## ------------------------------------------------------------ ##
## English "human rights"
english.world <- gtrends(TERMS[1], time=TIME, low_search_volume=FALSE)
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
ggtitle(paste("English Language: '", TERMS[1], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")



## ------------------------------------------------------------ ##
## Spanish
spanish.world <- gtrends(TERMS[2], time=TIME, low_search_volume=FALSE)
spanish.world <- subset(spanish.world$interest_by_country)
spanish.world$hits[spanish.world$hits=="<1"] <- .5
spanish.world$hits <- as.numeric(spanish.world$hits)
data <- spanish.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#feebe2", "#fbb4b9", "#f768a1", "#c51b8a", "#7a0177", "black")


map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
geom_map(aes(fill = hits), map = map.world) +
ggtitle(paste("Spanish Language: '", TERMS[2], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")


## ------------------------------------------------------------ ##
## Portugese
portugese.world <- gtrends(TERMS[3], time=TIME, low_search_volume=FALSE)
portugese.world <- subset(portugese.world$interest_by_country)
portugese.world$hits[portugese.world$hits=="<1"] <- .5
portugese.world$hits <- as.numeric(portugese.world$hits)
data <- portugese.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
geom_map(aes(fill = hits), map = map.world) +
ggtitle(paste("Portuguese Language: '", TERMS[3], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")



## ------------------------------------------------------------ ##
## Arabic
arabic.world <- gtrends(TERMS[4], time=TIME, low_search_volume=FALSE)
arabic.world <- subset(arabic.world$interest_by_country)
arabic.world$hits[arabic.world$hits=="<1"] <- .5
arabic.world$hits <- as.numeric(arabic.world$hits)
data <- arabic.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#f1eef6", "#d7b5d8", "#df65b0", "#dd1c77", "#980043", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
geom_map(aes(fill = hits), map = map.world) +
ggtitle(paste("Arabic Language: '", "huquq al'iinsan", "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")



## ------------------------------------------------------------ ##
## French "rights"
french.world <- gtrends(TERMS[8], time=TIME, low_search_volume=FALSE)
french.world <- subset(french.world$interest_by_country)
french.world$hits[french.world$hits=="<1"] <- .5
french.world$hits <- as.numeric(french.world$hits)
data <- french.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#ffffcc", "#c2e699", "#78c679", "#31a354", "#006837", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
geom_map(aes(fill = hits), map = map.world) +
ggtitle(paste("French Language: '", TERMS[8], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")






## ------------------------------------------------------------ ##
## Russian
russian.world <- gtrends(TERMS[5], time=TIME, low_search_volume=FALSE)
russian.world <- subset(russian.world$interest_by_country)
russian.world$hits[russian.world$hits=="<1"] <- .5
russian.world$hits <- as.numeric(russian.world$hits)
data <- russian.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#f2f0f7", "#cbc9e2", "#9e9ac8", "#756bb1", "#54278f", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
geom_map(aes(fill = hits), map = map.world) +
ggtitle(paste("Russian Language: '", "prava cheloveka", "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")



## ------------------------------------------------------------ ##
## Chinese
chinese.world <- gtrends(TERMS[7], time=TIME, low_search_volume=FALSE)
chinese.world <- subset(chinese.world$interest_by_country)
chinese.world$hits[chinese.world$hits=="<1"] <- .5
chinese.world$hits <- as.numeric(chinese.world$hits)
data <- chinese.world[,1:2]
names(data) <- c("region", "hits")
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
#data$hits[is.na(data$hits)]<-0

COLORS <- c("#ffffb2", "#fecc5c", "#fd8d3c", "#f03b20", "#bd0026", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
geom_map(aes(fill = hits), map = map.world) +
ggtitle(paste("Chinese Language: '", TERMS[7], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
theme(plot.title=element_text(family="Noto Sans CJK SC")) +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")





dev.off()

