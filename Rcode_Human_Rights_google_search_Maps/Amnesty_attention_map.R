## Amnesty_attention_map.R
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



data <- try(read.csv("Data_input/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv"))

amnesty_cy <- data.frame(table(amnesty_attention$CCODE, amnesty_attention$YEAR))
names(amnesty_cy) <- c("CCODE", "YEAR", "amnesty_attention_count")
head(amnesty_cy)

data <- merge(data, amnesty_cy, by.x=c("COW", "YEAR"), by.y=c("CCODE", "YEAR"), all.x=TRUE, all.y=FALSE)

report_count <- data.frame(xtabs(amnesty_attention_count ~ COW, data=subset(data, YEAR>=2015)))
report_count[order(report_count$Freq, decreasing=TRUE),]

report_count$COUNTRY <- countrycode(report_count$COW, origin="cown", destination="country.name")

report_count[order(report_count$Freq, decreasing=TRUE),]


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

## grey-scale
#COLORS <- c("#f7f7f7", "#cccccc", "#969696", "#636363", "#252525", "black")


pdf("Rplots/Maps_Amnesty_attention_2015_2019.pdf", height=3, width=6)


## ------------------------------------------------------------ ##

data <- report_count[,2:3]
names(data) <- c("Value", "region")
#data$Value <- log10(data$Value)
#data$Value <- sqrt(data$Value)
data$region[data$region=="Côte d’Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
COLORS <- c("#feebe2", "#fbb4b9", "#f768a1", "#c51b8a", "#7a0177", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
geom_map(aes(fill = Value), map = map.world) +
ggtitle(paste("Amnesty International Country Attention: Article Count", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")


## transform count variable 
#data$Value <- log10(data$Value + 1)
data$Value <- sqrt(data$Value)
data$region[data$region=="Cote d'Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
COLORS <- c("#feebe2", "#fbb4b9", "#f768a1", "#c51b8a", "#7a0177", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
  geom_map(aes(fill = Value), map = map.world) +
  ggtitle(paste("Amnesty International Country Attention: sqrt(Article Count)", sep="")) +
  xlab("Latitude") + ylab("Longitude") +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")


## transform count variable 
data$Value <- log10(data$Value + 1)
#data$Value <- sqrt(data$Value)
data$region[data$region=="Cote d'Ivoire"] <- "Ivory Coast"
data$region[data$region=="Congo - Kinshasa"] <- "Democratic Republic of the Congo"
data$region[data$region=="Congo - Brazzaville"] <- "Republic of Congo"
data$region[data$region=="United Kingdom"] <- "UK"
data$region[data$region=="United States"] <- "USA"
COLORS <- c("#feebe2", "#fbb4b9", "#f768a1", "#c51b8a", "#7a0177", "black")

map.world <- map_data("world")
ggplot(data, aes(map_id = region)) +
  geom_map(aes(fill = Value), map = map.world) +
  ggtitle(paste("Amnesty International Country Attention: log10(Article Count)", sep="")) +
  xlab("Latitude") + ylab("Longitude") +
  coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
  expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")

dev.off()


