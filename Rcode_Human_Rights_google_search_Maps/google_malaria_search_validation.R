## google_malaria_search_validation.R
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


## malaria terms (note that malaria is the same in English and Spanish so here we only included English/Spanish, Portuguese, and French) 
TERMS <- c("malaria", "malária", "paludisme")


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



pdf("Rplots/Maps_google_malaria.pdf", height=3, width=6)

TIME <- "2015-01-01 2019-12-31"
TIME <- "2017-01-01 2017-12-31"

## ------------------------------------------------------------ ##
## English (or Spanish) "malaria"
english.world <- gtrends(TERMS[1], time=TIME, low_search_volume=TRUE)
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
ggtitle(paste("English: '", TERMS[1], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")



## ------------------------------------------------------------ ##
## Portuguese
portugese.world <- gtrends(TERMS[2], time=TIME, low_search_volume=TRUE)
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
ggtitle(paste("Portuguese: '", TERMS[2], "'", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")



## ------------------------------------------------------------ ##
## French "paludisme"
french.world <- gtrends(TERMS[3], time=TIME, low_search_volume=TRUE)
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



## load malaria and population data 
malaria_data <- read.csv("Data_input/malaria_deaths_2017.csv")
malaria_data$iso3c <- countrycode(malaria_data$country_2017, origin="country.name", destination="iso3c")

wb_population <- read.csv("Data_input/world_bank_population_data.csv", na.strings = c("NA", "..", ""))
wb_population <- subset(wb_population, select=c(Country.Name, Country.Code, X2017..YR2017.))
names(wb_population) <- c("country_wb", "iso3c", "population_2017")
wb_population <- wb_population[!is.na(wb_population$population_2017),]

## merge data
data <- merge(wb_population, malaria_data, by=c("iso3c"), all=TRUE)

## calcualte Malaria incidence rate
data$rate <- 100000 * data$estimate/data$population_2017
data$rate[is.na(data$rate)] <-0

data$country_wb <- as.character(data$country_wb)





## Malaria incidence rate map
map.world <- map_data("world")

map_names <- unique(map.world$region)
map_iso3c <- countrycode(map_names, origin="country.name", destination="iso3c")


map_data_names <- data.frame(map_names, map_iso3c)

data <- merge(data, map_data_names, by.x=c("iso3c"), by.y=c("map_iso3c"), all=TRUE)


COLORS <- c("#f0f9e8", "#bae4bc", "#7bccc4", "#43a2ca", "#0868ac", "black")
COLORS <- c("#f7f7f7", "#bdbdbd", "#969696", "#636363", "#252525")

COLORS <- c("#f7f7f7", "#de2d26", "#a50f15", "#252525")

ggplot(data, aes(map_id = map_names)) +
geom_map(aes(fill = rate), map = map.world) +
ggtitle(paste("Estimated Malaria Mortality Rate per 100,000 in 2017", sep="")) +
xlab("Latitude") + ylab("Longitude") +
coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90)) +
expand_limits(x = map.world$long, y = map.world$lat) + scale_fill_gradientn(colours=COLORS, na.value=grey(.875), guide = "colourbar")


dev.off()

test_dat <- data.frame()
test_dat

## Correlation analysis
english.world$iso3c <- countrycode(english.world$location, origin="country.name", destination="iso3c")
enlish_data <- merge(data, english.world, by.x=c("iso3c"), by.y=c("iso3c"), all=TRUE)

test_dat[1,1] <- cor.test(enlish_data$rate, enlish_data$hits)$estimate
test_dat[1,2] <- cor.test(enlish_data$rate, enlish_data$hits, method="spearman")$estimate
test_dat[1,3] <- nrow(subset(enlish_data, !is.na(hits) & !is.na(rate)))

portugese.world$iso3c <- countrycode(portugese.world$location, origin="country.name", destination="iso3c")
portugese_data <- merge(data, portugese.world, by.x=c("iso3c"), by.y=c("iso3c"), all=TRUE)

test_dat[2,1] <- cor.test(portugese_data$rate, portugese_data$hits)$estimate
test_dat[2,2] <- cor.test(portugese_data$rate, portugese_data$hits, method="spearman")$estimate
test_dat[2,3] <- nrow(subset(portugese_data, !is.na(hits) & !is.na(rate)))

french.world$iso3c <- countrycode(french.world$location, origin="country.name", destination="iso3c")
french_data <- merge(data, french.world, by.x=c("iso3c"), by.y=c("iso3c"), all=TRUE)

test_dat[3,1] <- cor.test(french_data$rate, french_data$hits)$estimate
test_dat[3,2] <- cor.test(french_data$rate, french_data$hits, method="spearman")$estimate
test_dat[3,3] <- nrow(subset(french_data, !is.na(hits) & !is.na(rate)))

names(test_dat) <- c("Pearson", "Spearman", "N")
test_dat

## archive datasets

## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

## save data.frame
write.csv(enlish_data, paste("Data_output/Google_search_malaria_english", current_date, ".csv", sep=""), row.names=FALSE)
write.csv(portugese_data, paste("Data_output/Google_search_malaria_portugese", current_date, ".csv", sep=""), row.names=FALSE)
write.csv(french_data, paste("Data_output/Google_search_malaria_french", current_date, ".csv", sep=""), row.names=FALSE)
