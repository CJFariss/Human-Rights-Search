## Descriptive_Stats.R

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from May-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

test_dat <- readRDS("Data_output/combined_gsearch_dat_list_merged.RDS")
test_dat <- readRDS("Data_output/combined_gsearch_dat_list_merged_lowsearch.RDS")
length(test_dat)
head(test_dat[[1]])
summary(test_dat[[1]])

sapply(test_dat, nrow)


## pool the datasets by language group
for(i in 1:length(test_dat)){
  if(i>0 & i<=4) test_dat[[i]]$language <- "derechos_humanos"
  if(i>4 & i<=8) test_dat[[i]]$language <- "direitos_humanos"
  if(i>8 & i<=12) test_dat[[i]]$language <- "droit"
  if(i>12 & i<=16) test_dat[[i]]$language <- "human_rights"
  if(i>16 & i<=20) test_dat[[i]]$language <- "huquq_alansan"
}

test_dat_language_pooled <- list()
test_dat_language_pooled[[1]] <- rbind(test_dat[[1]], test_dat[[5]], test_dat[[9]], test_dat[[13]], test_dat[[17]])
test_dat_language_pooled[[2]] <- rbind(test_dat[[2]], test_dat[[6]], test_dat[[10]], test_dat[[14]], test_dat[[18]])
test_dat_language_pooled[[3]] <- rbind(test_dat[[3]], test_dat[[7]], test_dat[[11]], test_dat[[15]], test_dat[[19]])
test_dat_language_pooled[[4]] <- rbind(test_dat[[4]], test_dat[[8]], test_dat[[12]], test_dat[[16]], test_dat[[20]])

sapply(test_dat_language_pooled, nrow)


mean(test_dat_language_pooled[[4]]$hits_mean)
mean(test_dat_language_pooled[[4]]$hits_median)
mean(test_dat_language_pooled[[4]]$hits_max)

sd(test_dat_language_pooled[[4]]$hits_mean)
sd(test_dat_language_pooled[[4]]$hits_median)
sd(test_dat_language_pooled[[4]]$hits_max)

min(test_dat_language_pooled[[4]]$hits_mean)
min(test_dat_language_pooled[[4]]$hits_median)
min(test_dat_language_pooled[[4]]$hits_max)

max(test_dat_language_pooled[[4]]$hits_mean)
max(test_dat_language_pooled[[4]]$hits_median)
max(test_dat_language_pooled[[4]]$hits_max)




