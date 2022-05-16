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

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


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
english.world <- gtrends("%2Fm%2F012l0", time=TIME, low_search_volume=TRUE)
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
english.world <- gtrends("Amnesty International", time=TIME, low_search_volume=TRUE)
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


## ------------------------------------------------------------ ##
## English "human rights"
english.world <- gtrends("human rights", time=TIME, low_search_volume=TRUE)
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data <- english.world[,1:2]
names(data) <- c("region", "hits")
dim(data)

## ------------------------------------------------------------ ##
## English "Amnesty International"
english.world <- gtrends("Amnesty International", time=TIME, low_search_volume=TRUE)
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data2 <- english.world[,1:2]
names(data2) <- c("region", "hits")
dim(data2)



## search term by seerach term correlations
test <- merge(data, data2, by="region", all=T)
dim(test)

par(mfrow=c(1,1))
plot(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y, method="spearman")

test$hits.x[is.na(test$hits.x) & !is.na(test$hits.y)] <- 0
test$hits.y[is.na(test$hits.y) & !is.na(test$hits.x)] <- 0

plot(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y, method="spearman")

## archive datasets

## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

## save data.frame
write.csv(test, paste("Data_output/Maps_Anesty_International_language_validation", current_date, ".csv", sep=""), row.names=FALSE)



## ------------------------------------------------------------ ##
## Topic "human rights"
english.world <- gtrends("%2Fm%2F03ll3", time=TIME, low_search_volume=TRUE)
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data <- english.world[,1:2]
names(data) <- c("region", "hits")
dim(data)

## ------------------------------------------------------------ ##
## Topic "Amnesty International"
english.world <- gtrends("%2Fm%2F012l0", time=TIME, low_search_volume=TRUE)
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data2 <- english.world[,1:2]
names(data2) <- c("region", "hits")
dim(data2)


## Topic by Topic correlations
test <- merge(data, data2, by="region", all=T)
dim(test)

par(mfrow=c(1,1))
plot(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y, method="spearman")

test$hits.x[is.na(test$hits.x) & !is.na(test$hits.y)] <- 0
test$hits.y[is.na(test$hits.y) & !is.na(test$hits.x)] <- 0

plot(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y, method="spearman")

## archive datasets

## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

## save data.frame
write.csv(test, paste("Data_output/Maps_Anesty_International_topic_validation", current_date, ".csv", sep=""), row.names=FALSE)

