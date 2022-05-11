## google_serach_data_global_lists.R

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)


## make a color vector for polots
COLORS <- c("#fdae61", "#a6cee3", "#1f78b4", "#b2df8a", "#33a02c")


## select serach terms for cy dataset creation
TERMS <- c(URLdecode("%2Fm%2F03ll3")) ## human rights topic
TERMS <- c(URLdecode("%2Fm%2F0cttd")) ## torture topic
TERMS
TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "права человека", "hak asasi Manusia", "人权", "droits")
TERMS


## select time range
TIME <- c()
TIME[1] <- "2012-01-01 2016-12-31"
TIME[2] <- "2013-01-01 2017-12-31"
TIME[3] <- "2014-01-01 2018-12-31"
TIME[4] <- "2015-01-01 2019-12-31"
TIME

TERMS <- c("human rights", "derechos humanos", "direitos humanos", "droit")
TERMS
