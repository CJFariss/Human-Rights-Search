## google_HR_french_validation_maps.R
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


pdf("Rplots/Maps_French_validation.pdf", height=3, width=6)



#TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "hak asasi Manusia", "人权", "droits")


## colors from colorbrewer2.org
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

## Notes
## We do not run the search together because we want the correlation to be precise and we only need the relative ordering for this because we are using a Spearman rank-order correlation. It's a precision issue with the significant digits in the google rate values.


TIME <- "2015-01-01 2019-12-31"

TERMS <- c("droits humains", "droits de lhomme", "libertés", "droits")

## ------------------------------------------------------------ ##
## French "human rights"
french.world <- gtrends(TERMS[1], time=TIME, low_search_volume=TRUE)
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
ggtitle(paste("French: '", TERMS[1], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")

## ------------------------------------------------------------ ##
## French alternative to "human rights"
french.world <- gtrends(TERMS[2],  time=TIME, low_search_volume=TRUE)
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
  ggtitle(paste("French: '", TERMS[2], "'", sep="")) +
  xlab("Latitude") + ylab("Longitude") +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")

## ------------------------------------------------------------ ##
## French "liberties"
french.world <- gtrends(TERMS[3],  time=TIME, low_search_volume=TRUE)
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
  ggtitle(paste("French: '", TERMS[3], "'", sep="")) +
  xlab("Latitude") + ylab("Longitude") +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")

## ------------------------------------------------------------ ##
## French "rights"
french.world <- gtrends(TERMS[4],  time=TIME, low_search_volume=TRUE)
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
  ggtitle(paste("French: '", TERMS[4], "'", sep="")) +
  xlab("Latitude") + ylab("Longitude") +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")


dev.off()


TERMS <- c("droits humains", "droits de lhomme", "libertés", "droits")

## ------------------------------------------------------------ ##
## French "droits humains" 
french.world <- gtrends(TERMS[1], time=TIME, low_search_volume=TRUE)
french.world <- subset(french.world$interest_by_country)
french.world$hits[french.world$hits=="<1"] <- .5
french.world$hits <- as.numeric(french.world$hits)
data <- french.world[,1:2]
names(data) <- c("region", "hits")
dim(data)

## ------------------------------------------------------------ ##
## French "droits de lhomme"
french.world <- gtrends(TERMS[2], time=TIME, low_search_volume=TRUE)
french.world <- subset(french.world$interest_by_country)
french.world$hits[french.world$hits=="<1"] <- .5
french.world$hits <- as.numeric(french.world$hits)
data2 <- french.world[,1:2]
names(data2) <- c("region", "hits")
dim(data2)

## ------------------------------------------------------------ ##
## French "libertés"
french.world <- gtrends(TERMS[3], time=TIME, low_search_volume=TRUE)
french.world <- subset(french.world$interest_by_country)
french.world$hits[french.world$hits=="<1"] <- .5
french.world$hits <- as.numeric(french.world$hits)
data3 <- french.world[,1:2]
names(data3) <- c("region", "hits")
dim(data3)

## ------------------------------------------------------------ ##
## French "droits""
french.world <- gtrends(TERMS[4], time=TIME, low_search_volume=TRUE)
french.world <- subset(french.world$interest_by_country)
french.world$hits[french.world$hits=="<1"] <- .5
french.world$hits <- as.numeric(french.world$hits)
data4 <- french.world[,1:2]
names(data4) <- c("region", "hits")
dim(data4)


## merge datasets for correlations 
test1 <- merge(data, data2, by="region", all=T, suffixes = c(".humains",".de_lhomme"))
dim(test1)
test2 <- merge(data3, data4, by="region", all=T, suffixes = c(".libertes", ".droits"))
dim(test2)

test <- merge(test1, test2, by="region", all=T)
dim(test)

head(test)
summary(test)

test$indicator <- NA
test$indicator <- ifelse(!is.na(test$hits.humains), 1, NA)
test$indicator <- ifelse(!is.na(test$hits.de_lhomme), 1, NA)
test$indicator <- ifelse(!is.na(test$hits.libertes), 1, NA)
test$indicator <- ifelse(!is.na(test$hits.droits), 1, NA)

table(test$indicator)

test$hits.humains[test$indicator==1 & is.na(test$hits.humains)] <- 0
test$hits.de_lhomme[test$indicator==1 & is.na(test$hits.de_lhomme)] <- 0
test$hits.libertes[test$indicator==1 & is.na(test$hits.libertes)] <- 0
test$hits.droits[test$indicator==1 & is.na(test$hits.droits)] <- 0

summary(test)

par(mfrow=c(2,2))
plot(test$hits.humains, test$hits.de_lhomme)
plot(test$hits.de_lhomme, test$hits.libertes)
plot(test$hits.libertes, test$hits.droits)
plot(test$hits.droits, test$hits.de_lhomme)

## Pearson correlations
cor.test(test$hits.humains, test$hits.de_lhomme)
cor.test(test$hits.de_lhomme, test$hits.libertes)
cor.test(test$hits.libertes, test$hits.droits)
cor.test(test$hits.droits, test$hits.de_lhomme)

## Spearman correlations
cor.test(test$hits.humains, test$hits.de_lhomme, method="spearman")
cor.test(test$hits.de_lhomme, test$hits.libertes, method="spearman")
cor.test(test$hits.libertes, test$hits.droits, method="spearman")
cor.test(test$hits.droits, test$hits.de_lhomme, method="spearman")



## archive datasets

## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

## save data.frame
write.csv(test, paste("Data_output/Maps_French_validation", current_date, ".csv", sep=""), row.names=FALSE)
