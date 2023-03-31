## google_search_cy_analysis_cross_validation.R
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

attention_rate <- TRUE ## set to FALSE for count
NGO_amnesty <- TRUE ## set to FALSE for the alternative NGO variable
lowsearch_option <- FALSE ## note that the lowsearch term in the file label means that the lowsearch argument is set to its default FALSE value in the gtrends() search function

if(lowsearch_option==TRUE) test_dat <- readRDS("Data_output/combined_gsearch_dat_list_merged.RDS")
if(lowsearch_option==FALSE) test_dat <- readRDS("Data_output/combined_gsearch_dat_list_merged_lowsearch.RDS")

## inspect object
length(test_dat)
head(test_dat[[1]])
summary(test_dat[[1]])

#test_dat$hits_mean[is.na(test_dat$hits_mean)] <- 0
#test_dat$hits_median[is.na(test_dat$hits_median)] <- 0
#test_dat$hits_max[is.na(test_dat$hits_max)] <- 0
#test_dat$hits_sd[is.na(test_dat$hits_sd)] <- 0


## linear models (languages are seperated)
fit_mean_robust <- fit_median_robust <- fit_max_robust <- list()
unit_n <- c()
for(i in 1:length(test_dat)){
  
  temp <- subset(test_dat[[i]], !is.na(CCODE))
  
  ## scale variable 
  temp$theta_mean <- -1*temp$theta_mean
  temp$amnesty_attention_count <- scale(temp$amnesty_attention_count)
  temp$amnesty_attention_rate <- scale(temp$amnesty_attention_rate)
  temp$GDP_growth_annual_percent <- scale(temp$GDP_growth_annual_percent)
  temp$Foreign_direct_investment_net_inflows_percent_GDP <- scale(temp$Foreign_direct_investment_net_inflows_percent_GDP) 
  temp$treaty_count <- scale(temp$treaty_count)
  temp$v2smgovfilprc <- scale(temp$v2smgovfilprc)
  temp$hringo_inter <- scale(temp$hringo_inter)
  temp$hringo_inter_rate <- scale(temp$hringo_inter_rate)
  temp$hringo_inter_rate <- scale(temp$hringo_inter_rate)
  
  if(attention_rate==FALSE & NGO_amnesty==TRUE) temp$NGO <- temp$amnesty_attention_count
  if(attention_rate==TRUE & NGO_amnesty==TRUE) temp$NGO <- temp$amnesty_attention_rate
  if(attention_rate==FALSE & NGO_amnesty==FALSE) temp$NGO <- temp$hringo_inter
  if(attention_rate==TRUE & NGO_amnesty==FALSE) temp$NGO <- temp$hringo_inter_rate
  
  fit_mean <- lm(hits_mean ~ Foreign_direct_investment_net_inflows_percent_GDP  
                 + NGO
                 + treaty_count 
                 + GDP_growth_annual_percent  
                 + theta_mean   
                 + v2smgovfilprc 
                 , 
                 data=temp)
  
  fit_median <- lm(hits_median ~ Foreign_direct_investment_net_inflows_percent_GDP  
                   + NGO
                   + treaty_count 
                   + GDP_growth_annual_percent  
                   + theta_mean   
                   + v2smgovfilprc 
                   , 
                   data=temp)
  
  fit_max <- lm(hits_max ~Foreign_direct_investment_net_inflows_percent_GDP  
                + NGO
                + treaty_count 
                + GDP_growth_annual_percent  
                + theta_mean   
                + v2smgovfilprc 
                , 
                data=temp)
  #summary(fit)
  ## robust clustered standard errors
  fit_mean_robust[[i]] <- coeftest(fit_mean, vcov = vcovHC, type = "HC1", cluster=~CCODE)
  fit_median_robust[[i]] <- coeftest(fit_median, vcov = vcovHC, type = "HC1", cluster=~CCODE)
  fit_max_robust[[i]] <- coeftest(fit_max, vcov = vcovHC, type = "HC1", cluster=~CCODE)
  
  
  unit_n[i] <- length(fit_mean$fitted.values)
}

## print models to screen
unit_n
fit_mean_robust
fit_median_robust
fit_max_robust


## pool the datasets by language group
for(i in 1:length(test_dat)){
  if(i>0 & i<=4) test_dat[[i]]$language <- "derechos_humanos"
  if(i>4 & i<=8) test_dat[[i]]$language <- "direitos_humanos"
  if(i>8 & i<=12) test_dat[[i]]$language <- "droit"
  if(i>12 & i<=16) test_dat[[i]]$language <- "human_rights"
  if(i>16 & i<=20) test_dat[[i]]$language <- "huquq_al-nsan"
}

test_dat_language_pooled <- list()
test_dat_language_pooled[[1]] <- rbind(test_dat[[1]], test_dat[[5]], test_dat[[9]], test_dat[[13]], test_dat[[17]])
test_dat_language_pooled[[2]] <- rbind(test_dat[[2]], test_dat[[6]], test_dat[[10]], test_dat[[14]], test_dat[[18]])
test_dat_language_pooled[[3]] <- rbind(test_dat[[3]], test_dat[[7]], test_dat[[11]], test_dat[[15]], test_dat[[19]])
test_dat_language_pooled[[4]] <- rbind(test_dat[[4]], test_dat[[8]], test_dat[[12]], test_dat[[16]], test_dat[[20]])


## linear models (languages are pooled together)
fit_mean_robust <- fit_median_robust <- fit_max_robust <-  list()
unit_n <- c()
rmse_y_hat_pred_mean_HRPS <- rmse_y_hat_pred_median_HRPS <- rmse_y_hat_pred_max_HRPS <- c()
rmse_y_hat_pred_mean_baseline <- rmse_y_hat_pred_median_baseline <- rmse_y_hat_pred_max_baseline <-c()
cor_y_hat_pred_mean_HRPS <- cor_y_hat_pred_median_HRPS <- cor_y_hat_pred_max_HRPS <- c()
cor_y_hat_pred_mean_baseline <- cor_y_hat_pred_median_baseline <- cor_y_hat_pred_max_baseline <- c()

for(i in 1:length(test_dat_language_pooled)){
  
  temp <- subset(test_dat_language_pooled[[i]], !is.na(CCODE))
  
  ## scale variable 
  temp$theta_mean <- -1*temp$theta_mean
  temp$amnesty_attention_count <- scale(temp$amnesty_attention_count)
  temp$amnesty_attention_rate <- scale(temp$amnesty_attention_rate)
  temp$GDP_growth_annual_percent <- scale(temp$GDP_growth_annual_percent)
  temp$Foreign_direct_investment_net_inflows_percent_GDP <- scale(temp$Foreign_direct_investment_net_inflows_percent_GDP) 
  temp$treaty_count <- scale(temp$treaty_count)
  temp$v2smgovfilprc <- scale(temp$v2smgovfilprc)
  temp$hringo_inter <- scale(temp$hringo_inter)
  temp$hringo_inter_rate <- scale(temp$hringo_inter_rate)
  
  if(attention_rate==FALSE & NGO_amnesty==TRUE) temp$NGO <- temp$amnesty_attention_count
  if(attention_rate==TRUE & NGO_amnesty==TRUE) temp$NGO <- temp$amnesty_attention_rate
  if(attention_rate==FALSE & NGO_amnesty==FALSE) temp$NGO <- temp$hringo_inter
  if(attention_rate==TRUE & NGO_amnesty==FALSE) temp$NGO <- temp$hringo_inter_rate
  
  temp$folds <- as.numeric(as.factor(temp$CCODE)) ## crossvalidation with country units
  #temp$folds <- as.numeric(temp$year) - min(as.numeric(temp$year)) + 1 ## crossvalidation with year units
  
  for(k in unique(temp$folds)){
    #print(k) ## for error checking
    ## fit model with HRPS variable
    fit_mean <- lm(hits_mean ~ -1
                   + Foreign_direct_investment_net_inflows_percent_GDP  
                   + NGO
                   + treaty_count 
                   + GDP_growth_annual_percent  
                   + theta_mean 
                   + v2smgovfilprc 
                   + as.factor(language), 
                   data=subset(temp, folds!=k))
    
    fit_median <- lm(hits_median ~ -1 + 
                       + Foreign_direct_investment_net_inflows_percent_GDP  
                     + NGO
                     + treaty_count 
                     + GDP_growth_annual_percent  
                     + theta_mean 
                     + v2smgovfilprc 
                     + as.factor(language), 
                     data=subset(temp, folds!=k))
    
    fit_max <- lm(hits_max ~ -1 
                  + Foreign_direct_investment_net_inflows_percent_GDP  
                  + NGO
                  + treaty_count 
                  + GDP_growth_annual_percent  
                  + theta_mean   
                  + v2smgovfilprc 
                  + as.factor(language), 
                  data=subset(temp, folds!=k))
    
    pred_mean <- predict(fit_mean, newdata=subset(temp, folds==k))
    pred_median <- predict(fit_median, newdata=subset(temp, folds==k))
    pred_max <- predict(fit_max, newdata=subset(temp, folds==k))
    
    temp$y_hat_pred_mean_HRPS[temp$fold==k] <- as.numeric(pred_mean)
    temp$y_hat_pred_median_HRPS[temp$fold==k] <- as.numeric(pred_median)
    temp$y_hat_pred_max_HRPS[temp$fold==k] <- as.numeric(pred_max)
    
    
    ## model without HRPS variable
    fit_mean <- lm(hits_mean ~ -1
                   + Foreign_direct_investment_net_inflows_percent_GDP  
                   + NGO
                   + treaty_count 
                   + GDP_growth_annual_percent  
                   #+ theta_mean 
                   + v2smgovfilprc 
                   + as.factor(language), 
                   data=subset(temp, folds!=k))

    fit_median <- lm(hits_median ~ -1 + 
                       + Foreign_direct_investment_net_inflows_percent_GDP  
                     + NGO
                     + treaty_count 
                     + GDP_growth_annual_percent  
                     #+ theta_mean 
                     + v2smgovfilprc 
                     + as.factor(language), 
                     data=subset(temp, folds!=k))

    fit_max <- lm(hits_max ~ -1 
                  + Foreign_direct_investment_net_inflows_percent_GDP  
                  + NGO
                  + treaty_count 
                  + GDP_growth_annual_percent  
                  #+ theta_mean   
                  + v2smgovfilprc 
                  + as.factor(language), 
                  data=subset(temp, folds!=k))

    pred_mean <- predict(fit_mean, newdata=subset(temp, folds==k))
    pred_median <- predict(fit_median, newdata=subset(temp, folds==k))
    pred_max <- predict(fit_max, newdata=subset(temp, folds==k))
    
    temp$y_hat_pred_mean_baseline[temp$fold==k] <- as.numeric(pred_mean)
    temp$y_hat_pred_median_baseline[temp$fold==k] <- as.numeric(pred_median)
    temp$y_hat_pred_max_baseline[temp$fold==k] <- as.numeric(pred_max)
    
    
    #summary(fit)
    ## robust clustered standard errors
    #fit_mean_robust[[i]] <- coeftest(fit_mean, vcov = vcovHC, type = "HC1", cluster=~language)
    #fit_median_robust[[i]] <- coeftest(fit_median, vcov = vcovHC, type = "HC1", cluster=~language)
    #fit_max_robust[[i]] <- coeftest(fit_max, vcov = vcovHC, type = "HC1", cluster=~language)
    #unit_n[i] <- length(fit_mean$fitted.values)
  
  }
  
  rmse_y_hat_pred_mean_HRPS[i] <- sqrt(mean((temp$y_hat_pred_mean_HRPS - temp$hits_mean)^2, na.rm=T))
  rmse_y_hat_pred_median_HRPS[i] <- sqrt(mean((temp$y_hat_pred_median_HRPS - temp$hits_median)^2, na.rm=T))
  rmse_y_hat_pred_max_HRPS[i] <- sqrt(mean((temp$y_hat_pred_max_HRPS - temp$hits_max)^2, na.rm=T))

  rmse_y_hat_pred_mean_baseline[i] <- sqrt(mean((temp$y_hat_pred_mean_baseline - temp$hits_mean)^2, na.rm=T))
  rmse_y_hat_pred_median_baseline[i] <- sqrt(mean((temp$y_hat_pred_median_baseline - temp$hits_median)^2, na.rm=T))
  rmse_y_hat_pred_max_baseline[i] <- sqrt(mean((temp$y_hat_pred_max_baseline - temp$hits_max)^2, na.rm=T))
  
  cor_y_hat_pred_mean_HRPS[i] <- cor(temp$y_hat_pred_mean_HRPS, temp$hits_mean, use="pairwise", method="spearman")
  cor_y_hat_pred_median_HRPS[i] <- cor(temp$y_hat_pred_median_HRPS, temp$hits_median, use="pairwise", method="spearman")
  cor_y_hat_pred_max_HRPS[i] <- cor(temp$y_hat_pred_max_HRPS, temp$hits_max, use="pairwise", method="spearman")
  
  cor_y_hat_pred_mean_baseline[i] <- cor(temp$y_hat_pred_mean_baseline, temp$hits_mean, use="pairwise", method="spearman")
  cor_y_hat_pred_median_baseline[i] <- cor(temp$y_hat_pred_median_baseline, temp$hits_median, use="pairwise", method="spearman")
  cor_y_hat_pred_max_baseline[i] <- cor(temp$y_hat_pred_max_baseline, temp$hits_max, use="pairwise", method="spearman")
  
}

cor_y_hat_pred_mean_HRPS
cor_y_hat_pred_mean_baseline

cor_y_hat_pred_median_HRPS
cor_y_hat_pred_median_baseline

cor_y_hat_pred_max_HRPS
cor_y_hat_pred_max_baseline

rmse_y_hat_pred_mean_HRPS
rmse_y_hat_pred_mean_baseline

rmse_y_hat_pred_median_HRPS
rmse_y_hat_pred_median_baseline

rmse_y_hat_pred_max_HRPS
rmse_y_hat_pred_max_baseline


tab_out <- data.frame(rbind(cor_y_hat_pred_mean_HRPS, cor_y_hat_pred_mean_baseline, cor_y_hat_pred_median_HRPS, cor_y_hat_pred_median_baseline, cor_y_hat_pred_max_HRPS, cor_y_hat_pred_max_baseline))
names(tab_out) <- c("2012-2016", "2013-2017", "2014-2018", "2015-2019")
row.names(tab_out) <- c("Correlation: Search Mean with HRPS", "Correlation: Search Mean baseline", "Correlation: Search Median with HRPS", "Correlation: Search Median baseline", "Correlation: Search Max with HRPS", "Correlation: Search Max baseline")
tab_out
print(xtable(tab_out, digits=3, align=c("|l|", "r", "r", "r", "r|"), caption="Correlation Comparison after Leave-One-Out Cross Valiation"), file="Tex_tables/main_results_lowsearch_amnesty_report_rate_cross_validation_cor.tex")

tab_out <- data.frame(rbind(rmse_y_hat_pred_mean_HRPS, rmse_y_hat_pred_mean_baseline, rmse_y_hat_pred_median_HRPS, rmse_y_hat_pred_median_baseline, rmse_y_hat_pred_max_HRPS, rmse_y_hat_pred_max_baseline))
names(tab_out) <- c("2012-2016", "2013-2017", "2014-2018", "2015-2019")
row.names(tab_out) <- c("RMSE: Search Mean with HRPS", "RMSE: Search Mean baseline", "RMSE: Search Median with HRPS", "RMSE: Search Median baseline", "RMSE: Search Max with HRPS", "RMSE: Search Max baseline")
tab_out
print(xtable(tab_out, digits=3, align=c("|l|", "r", "r", "r", "r|"), caption="RMSE Comparison after Leave-One-Out Cross Valiation"), file="Tex_tables/main_results_lowsearch_amnesty_report_rate_cross_validation_rmse.tex")

