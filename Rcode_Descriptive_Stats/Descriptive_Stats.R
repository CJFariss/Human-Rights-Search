## Descriptive_Stats.R
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
## change groundhog to TRUE to install original versions of libraries from May-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

test_dat <- readRDS("Data_output/combined_gsearch_dat_list_merged.RDS")
test_dat <- readRDS("Data_output/combined_gsearch_dat_list_merged_lowsearch.RDS")
length(test_dat)
head(test_dat[[1]])
summary(test_dat[[1]])

sapply(test_dat, nrow)


## correlations
cor_value <- list()
for(i in 1:length(test_dat)){
  dat <- test_dat[[i]]
  cor_value[[i]] <- c(cor(dat$hits_mean, -1*dat$theta_mean, use="pairwise"), cor(dat$hits_median, -1*dat$theta_mean, use="pairwise"), cor(dat$hits_max, -1*dat$theta_mean, use="pairwise"))
}
cor_out <- data.frame(names(test_dat), do.call("rbind", cor_value))
#cor_out
cor_out[,1] <- c("derechos humanos", "derechos humanos", "derechos humanos", "derechos humanos", "direitos humanos", "direitos humanos", "direitos humanos", "direitos humanos", "droit", "droit", "droit", "droit", "human rights", "human rights", "human rights", "human rights", "huquq alansan", "huquq alansan", "huquq alansan", "huquq alansan")
cor_out$years <- c("2012-2016", "2013-2017", "2014-2018", "2015-2019", "2012-2016", "2013-2017", "2014-2018", "2015-2019", "2012-2016", "2013-2017", "2014-2018", "2015-2019", "2012-2016", "2013-2017", "2014-2018", "2015-2019", "2012-2016", "2013-2017", "2014-2018", "2015-2019")

cor_out <- cor_out[,c(1,5,2,3,4)]
cor_out

names(cor_out) <- c("Term", "Years", "Search Mean", "Search Median", "Search Max")

tab_out <- xtable(cor_out, digits=3, align=c("|r|", "rl", "r","r","r","r||"), caption="Correlations between Search and HR Violations by search term")
tab_out
print(tab_out, file="Tex_tables/cor_search_theta_all.tex")


## correlations
cor_value <- list()
for(i in 1:length(test_dat)){
  dat <- test_dat[[i]]
  cor_value[[i]] <- c(cor(dat$hits_mean, dat$amnesty_attention_count, use="pairwise"), cor(dat$hits_median, dat$amnesty_attention_count, use="pairwise"), cor(dat$hits_max, dat$amnesty_attention_count, use="pairwise"))
}
data.frame(names(test_dat), do.call("rbind", cor_value))
summary(do.call("rbind", cor_value))

## correlations
cor_value <- list()
for(i in 1:length(test_dat)){
  dat <- test_dat[[i]]
  cor_value[[i]] <- c(cor(dat$hits_mean, dat$amnesty_attention_rate, use="pairwise"), cor(dat$hits_median, dat$amnesty_attention_rate, use="pairwise"), cor(dat$hits_max, dat$amnesty_attention_rate, use="pairwise"))
}
data.frame(names(test_dat), do.call("rbind", cor_value))
summary(do.call("rbind", cor_value))



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



## correlations
cor_value <- list()
for(i in 1:length(test_dat_language_pooled)){
  dat <- test_dat_language_pooled[[i]]
  cor_value[[i]] <- c(cor(dat$hits_mean, -1*dat$theta_mean, use="pairwise"), cor(dat$hits_median, -1*dat$theta_mean, use="pairwise"), cor(dat$hits_max, -1*dat$theta_mean, use="pairwise"))
}
cor_out <- data.frame(do.call("rbind", cor_value))
#summary(do.call("rbind", cor_value))
names(cor_out) <- c("Search Mean", "Search Median", "Search Max")
row.names(cor_out) <- c("2012-2016", "2013-2017", "2014-2018", "2015-2019")
cor_out
tab_out <- xtable(cor_out, digits=3, align=c("|l|","r","r","r|"), caption="Correlations between Search and HR Violations")
tab_out
print(tab_out, file="Tex_tables/cor_search_theta_2012_2016.tex")

## correlations
cor_value <- list()
for(i in 1:length(test_dat_language_pooled)){
  dat <- test_dat_language_pooled[[i]]
  cor_value[[i]] <- c(cor(dat$hits_mean, dat$amnesty_attention_count, use="pairwise"), cor(dat$hits_median, dat$amnesty_attention_count, use="pairwise"), cor(dat$hits_max, dat$amnesty_attention_count, use="pairwise"))
}
cor_out <- data.frame(do.call("rbind", cor_value))
#summary(do.call("rbind", cor_value))
names(cor_out) <- c("Search Mean", "Search Median", "Search Max")
row.names(cor_out) <- c("2012-2016", "2013-2017", "2014-2018", "2015-2019")
cor_out
tab_out <- xtable(cor_out, digits=3, align=c("|l|","r","r","r|"), caption="Correlations between Search and Amnesty Attention Count")
print(tab_out, file="Tex_tables/cor_search_amnesty_attention_count_2012_2016.tex")

## correlations
cor_value <- list()
for(i in 1:length(test_dat_language_pooled)){
  dat <- test_dat_language_pooled[[i]]
  cor_value[[i]] <- c(cor(dat$hits_mean, dat$amnesty_attention_rate, use="pairwise"), cor(dat$hits_median, dat$amnesty_attention_rate, use="pairwise"), cor(dat$hits_max, dat$amnesty_attention_rate, use="pairwise"))
}
cor_out <- data.frame(do.call("rbind", cor_value))
#summary(do.call("rbind", cor_value))
names(cor_out) <- c("Search Mean", "Search Median", "Search Max")
row.names(cor_out) <- c("2012-2016", "2013-2017", "2014-2018", "2015-2019")
cor_out
tab_out <- xtable(cor_out, digits=3, align=c("|l|","r","r","r|"), caption="Correlations between Search and Amnesty Attention Rate")
print(tab_out, file="Tex_tables/cor_search_amnesty_attention_rate_2012_2016.tex")



## some descriptive stats
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


summary_list <- list()
cor_mat_list <- list()

for(i in 1:length(test_dat_language_pooled)){
  
  temp <- subset(test_dat_language_pooled[[i]], !is.na(CCODE), select=c(hits_mean, hits_median, hits_max, theta_mean, GDP_growth_annual_percent, Foreign_direct_investment_net_inflows_percent_GDP, treaty_count, v2smgovfilprc,amnesty_attention_count, amnesty_attention_rate, hringo_inter, hringo_inter_rate))
  
  ## scale variable 
  temp$theta_mean <- -1*temp$theta_mean
  #temp$amnesty_attention_count <- scale(temp$amnesty_attention_count)
  #temp$amnesty_attention_rate <- scale(temp$amnesty_attention_rate)
  #temp$GDP_growth_annual_percent <- scale(temp$GDP_growth_annual_percent)
  #temp$Foreign_direct_investment_net_inflows_percent_GDP <- scale(temp$Foreign_direct_investment_net_inflows_percent_GDP) 
  #temp$treaty_count <- scale(temp$treaty_count)
  #temp$v2smgovfilprc <- scale(temp$v2smgovfilprc)
  #temp$hringo_inter <- scale(temp$hringo_inter)
  #temp$hringo_inter_rate <- scale(temp$hringo_inter_rate)

  
  summary_list[[i]] <- data.frame(mean=apply(temp,2,mean, na.rm=T), 
                                  sd=apply(temp,2,sd, na.rm=T),
                                  min=apply(temp,2,min, na.rm=T),
                                  max=apply(temp,2,max, na.rm=T)) 
  row.names(summary_list[[i]]) <- c("Search Mean", "Search Median", "Search Max", "HR Violations", "GDP Growth", "FDI Inflows", "HR Treaty Count", "Internet Censorship", "Amnesty Attention Count", "Amnesty Attention Rate", "HRNGO Count", "HRNGO Rate")
  
  cor_mat_list[[i]] <- cor(temp, use="pairwise")
  row.names(cor_mat_list[[i]]) <- c("Search Mean", "Search Median", "Search Max", "HR Violations", "GDP Growth", "FDI Inflows", "HR Treaty Count", "Internet Censorship", "AI Attention Count", "AI Attention Rate", "HRNGO Count", "HRNGO Rate")

  colnames(cor_mat_list[[i]]) <- c("(1)","(2)","(3)","(4)","(5)","(6)","(7)","(8)","(9)","(10)","(11)","(12)")
  
}

summary_list[[1]]
summary_list[[2]]
summary_list[[3]]
summary_list[[4]]

cor_mat_list[[1]]
cor_mat_list[[2]]
cor_mat_list[[3]]
cor_mat_list[[4]]

## descriptive stats
tab_out <- xtable(summary_list[[1]], digits=3, align=c("|l|","r","r","r","r|"), caption="Summary Statistics 2012-2016")
print(tab_out, file="Tex_tables/stats_2012_2016.tex") 

tab_out <- xtable(summary_list[[2]], digits=3, align=c("|l|","r","r","r","r|"), caption="Summary Statistics 2013-2017")
print(tab_out, file="Tex_tables/stats_2013_2017.tex")

tab_out <- xtable(summary_list[[3]], digits=3, align=c("|l|","r","r","r","r|"), caption="Summary Statistics 2014-2018")
print(tab_out, file="Tex_tables/stats_2014_2018.tex")

tab_out <- xtable(summary_list[[4]], digits=3, align=c("|l|","r","r","r","r|"), caption="Summary Statistics 2015-2019")
print(tab_out, file="Tex_tables/stats_2015_2019.tex")


## correlation matrices
tab_out <- xtable(cor_mat_list[[1]], digits=2, align=c("|l|","r","r","r","r","r","r","r","r","r","r","r","r|"), caption="Pairwise Correlations 2012-2016")
print(tab_out, file="Tex_tables/cors_2012_2016.tex") 

tab_out <- xtable(cor_mat_list[[2]], digits=2, align=c("|l|","r","r","r","r","r","r","r","r","r","r","r","r|"), caption="Pairwise Correlations 2013-2017")
print(tab_out, file="Tex_tables/cors_2013_2017.tex")

tab_out <- xtable(cor_mat_list[[3]], digits=2, align=c("|l|","r","r","r","r","r","r","r","r","r","r","r","r|"), caption="Pairwise Correlations 2014-2018")
print(tab_out, file="Tex_tables/cors_2014_2018.tex")

tab_out <- xtable(cor_mat_list[[4]], digits=2, align=c("|l|","r","r","r","r","r","r","r","r","r","r","r","r|"), caption="Pairwise Correlations 2015-2019")
print(tab_out, file="Tex_tables/cors_2015_2019.tex")



