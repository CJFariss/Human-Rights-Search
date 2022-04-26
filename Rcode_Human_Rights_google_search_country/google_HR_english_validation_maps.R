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
library(ggplot2)


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

## Notes
## We do not run the search together because we want the correlation to be precise and we only need the relative ordering for this because we are using a Spearman rank-order correlation. It's a precision issue with the significant digits in the google rate values.

## ------------------------------------------------------------ ##
## English "rights"
english.world <- gtrends("rights")
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data <- english.world[,1:2]
names(data) <- c("region", "hits")
dim(data)

## ------------------------------------------------------------ ##
## English "human rights"
english.world <- gtrends("human rights")
english.world <- subset(english.world$interest_by_country)
english.world$hits[english.world$hits=="<1"] <- .5
english.world$hits <- as.numeric(english.world$hits)
data2 <- english.world[,1:2]
names(data2) <- c("region", "hits")
dim(data2)

test <- merge(data, data2, by="region", all=T)
dim(test)

plot(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y, method="spearman")

test$hits.x[is.na(test$hits.x) & !is.na(test$hits.y)] <- 0
test$hits.y[is.na(test$hits.y) & !is.na(test$hits.x)] <- 0

plot(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y)
cor.test(test$hits.x, test$hits.y, method="spearman")


