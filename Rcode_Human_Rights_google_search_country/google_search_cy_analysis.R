## google_search_cy_analysis.R
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

## additional functions to add content to the stargazer table output
source("Rcode_Human_Rights_google_search_country/star_cleaning_functions.R")

## change this logical-value for the alternative count variable
attention_rate <- TRUE ## set to FALSE for count

## keep these values the same (see the other files for alternative model specifications)
## That is don't change these values look at the other files for the alternative model specifications 
NGO_amnesty <- TRUE ## set to FALSE for the alternative NGO variable
lowsearch_option <- FALSE ## note that the lowsearch term in the file label means that the lowsearch argument is set to its default FALSE value in the gtrends() search function which is FALSE (sorry this is confusing)

## keep these fixed
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
  if(i>16 & i<=20) test_dat[[i]]$language <- "huquq_alansan"
}

test_dat_language_pooled <- list()
test_dat_language_pooled[[1]] <- rbind(test_dat[[1]], test_dat[[5]], test_dat[[9]], test_dat[[13]], test_dat[[17]])
test_dat_language_pooled[[2]] <- rbind(test_dat[[2]], test_dat[[6]], test_dat[[10]], test_dat[[14]], test_dat[[18]])
test_dat_language_pooled[[3]] <- rbind(test_dat[[3]], test_dat[[7]], test_dat[[11]], test_dat[[15]], test_dat[[19]])
test_dat_language_pooled[[4]] <- rbind(test_dat[[4]], test_dat[[8]], test_dat[[12]], test_dat[[16]], test_dat[[20]])


## linear models (languages are pooled together)
fit_mean_robust <- fit_median_robust <- fit_max_robust <- r_squared <- list()
unit_n <- c()
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
  
  fit_mean <- lm(hits_mean ~ -1
                 + Foreign_direct_investment_net_inflows_percent_GDP  
                 + NGO
                 + treaty_count 
                 + GDP_growth_annual_percent  
                 + theta_mean 
                 + v2smgovfilprc 
                 + as.factor(language), 
                 data=temp)

  fit_median <- lm(hits_median ~ -1 + 
                    + Foreign_direct_investment_net_inflows_percent_GDP  
                   + NGO
                   + treaty_count 
                   + GDP_growth_annual_percent  
                   + theta_mean 
                    + v2smgovfilprc 
                   + as.factor(language), 
                   data=temp)

  fit_max <- lm(hits_max ~ -1 
                + Foreign_direct_investment_net_inflows_percent_GDP  
                + NGO
                + treaty_count 
                + GDP_growth_annual_percent  
                + theta_mean   
                + v2smgovfilprc 
                + as.factor(language), 
              data=temp)

  r_squared[[i]] <- c(summary(fit_mean)$r.squared, summary(fit_median)$r.squared, summary(fit_max)$r.squared)
  #summary(fit)
  ## robust clustered standard errors
  fit_mean_robust[[i]] <- coeftest(fit_mean, vcov = vcovHC, type = "HC1", cluster=~language)
  fit_median_robust[[i]] <- coeftest(fit_median, vcov = vcovHC, type = "HC1", cluster=~language)
  fit_max_robust[[i]] <- coeftest(fit_max, vcov = vcovHC, type = "HC1", cluster=~language)

  unit_n[i] <- length(fit_mean$fitted.values)
}

unit_n

## print models to screen
#summary(fit_mean)
#summary(fit_median)
#summary(fit_max)
fit_mean_robust[[4]]
fit_median_robust[[4]]
fit_max_robust[[4]]

## coeffient ratios
fit_mean_robust[[4]][5,1] / fit_mean_robust[[4]][2,1]
fit_median_robust[[4]][5,1] / fit_median_robust[[4]][2,1]

## save table output for latex 
for(j in 1:4){
  
  if(attention_rate==FALSE & NGO_amnesty==TRUE) LABELS <- c("FDI Inflows", "Amnesty Reports (Count)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship", "Spanish (derechos humanos)", "Portuguese (direitos humanos)", "French (droit)", "English (human rights)", "Arabic (huquq alansan)")

  if(attention_rate==TRUE & NGO_amnesty==TRUE) LABELS <- c("FDI Inflows", "Amnesty Reports (Rate)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship", "Spanish (derechos humanos)", "Portuguese (direitos humanos)", "French (droit)", "English (human rights)", "Arabic (huquq alansan)")

  if(attention_rate==FALSE & NGO_amnesty==FALSE) LABELS <- c("FDI Inflows", "NGO Presence (Count)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship", "Spanish (derechos humanos)", "Portuguese (direitos humanos)", "French (droit)", "English (human rights)", "Arabic (huquq alansan)")

  if(attention_rate==TRUE & NGO_amnesty==FALSE) LABELS <- c("FDI Inflows", "NGO Presence (Rate)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship", "Spanish (derechos humanos)", "Portuguese (direitos humanos)", "French (droit)", "English (human rights)", "Arabic (huquq alansan)")
  
  NOTES <- "\\parbox[t]{8cm}{Models include a fixed effects parameter for each language group (Spanish, Portuguese, French, English, Arabic). Search Mean, Search Median, and Search Max dependent variables are measure of the yearly mean, median, or max country-week search rate value for each country-year unit. Independent variables are measured annually for each country-year unit. $^{*}$p$<$0.1; $^{**}$p$<$0.05; $^{***}$p$<$0.01}"
  
  tab_output <- stargazer(fit_mean_robust[[j]], fit_median_robust[[j]], fit_max_robust[[j]], covariate.labels = LABELS, column.labels = c("Search Mean", "Search Median", "Search Max"), dep.var.caption = "Dependent Variable: Google Search Rate", no.space=TRUE, title="Country-Year Regression Analysis", notes=NOTES, notes.align="l", notes.append=FALSE)

  tab_output <- star_insert_row(tab_output, paste("R-squared  &", round(r_squared[[i]][1],3), "&", round(r_squared[[i]][2],3), "&", round(r_squared[[i]][3],3),"\\\\ "), insert.after=38) 

  tab_output <- star_insert_row(tab_output, paste("sample size  &", unit_n[1], "&", unit_n[2], "&", unit_n[3],"\\\\ "), insert.after=39) 
  
  #tab_output

    if(j==1 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_count_2012_2016.tex")
  if(j==2 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_count_2013_2017.tex")
  if(j==3 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_count_2014_2018.tex")
  if(j==4 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_count_2015_2019.tex")
  
  if(j==1 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_rate_2012_2016.tex")
  if(j==2 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_rate_2013_2017.tex")
  if(j==3 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_rate_2014_2018.tex")
  if(j==4 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) write(tab_output, file="Tex_tables/main_results_lowsearch_amnesty_report_rate_2015_2019.tex")
}


## save coefficient plots
for(j in 1:4){
  coef_mean <- fit_mean_robust[[j]][6:1,1]
  coef_median <- fit_median_robust[[j]][6:1,1]
  coef_max <- fit_max_robust[[j]][6:1,1]
  
  ## select value for first interval
  VALUE <- 1
  VALUE <- qt(.95, unit_n[j])
  
  coef_mean_1ub <- fit_mean_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_median_1ub <- fit_median_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_max_1ub <- fit_max_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_mean_1lb <- fit_mean_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  coef_median_1lb <- fit_median_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  coef_max_1lb <- fit_max_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  
  ## select value for second interval
  VALUE <- 2
  VALUE <- qt(.975, unit_n[j])
  
  coef_mean_2ub <- fit_mean_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_median_2ub <- fit_median_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_max_2ub <- fit_max_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_mean_2lb <- fit_mean_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  coef_median_2lb <- fit_median_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  coef_max_2lb <- fit_max_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  
  ## select value for third *optional) interval
  VALUE <- 3
  VALUE <- qt(.995, unit_n[j])
  
  coef_mean_3ub <- fit_mean_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_median_3ub <- fit_median_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_max_3ub <- fit_max_robust[[j]][6:1,1] + VALUE*fit_mean_robust[[j]][6:1,2]
  coef_mean_3lb <- fit_mean_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  coef_median_3lb <- fit_median_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  coef_max_3lb <- fit_max_robust[[j]][6:1,1] - VALUE*fit_mean_robust[[j]][6:1,2]
  
  cbind(coef_mean, coef_median, coef_max)
  
  ## coefficient plots
  ## create graph file
  if(j==1 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_2012_2016_Rplot.pdf", height=6, width=8)
  if(j==2 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_2013_2017_Rplot.pdf", height=6, width=8)
  if(j==3 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_2014_2018_Rplot.pdf", height=6, width=8)
  if(j==4 & lowsearch_option==FALSE & attention_rate==FALSE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_2015_2019_Rplot.pdf", height=6, width=8)
  
  if(j==1 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2012_2016_Rplot.pdf", height=6, width=8)
  if(j==2 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2013_2017_Rplot.pdf", height=6, width=8)
  if(j==3 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2014_2018_Rplot.pdf", height=6, width=8)
  if(j==4 & lowsearch_option==FALSE & attention_rate==TRUE & NGO_amnesty==TRUE) pdf("Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2015_2019_Rplot.pdf", height=6, width=8)
  
  
  par(mar=c(4,10,2,1))
  plot(coef_mean, 1:6, xlim=c(-6,6), ylim=c(.5,6.5), ylab="", xlab="Standarized Coefficients", xaxt="n", yaxt="n", type="n")
  abline(v=0, col=grey(.5), lty=2)
  abline(h=1.5, col=grey(.85), lty=1, lwd=.5)
  abline(h=2.5, col=grey(.85), lty=1, lwd=.5)
  abline(h=3.5, col=grey(.85), lty=1, lwd=.5)
  abline(h=4.5, col=grey(.85), lty=1, lwd=.5)
  abline(h=5.5, col=grey(.85), lty=1, lwd=.5)
  
  for(i in 1:6){
    lines(c(coef_mean_1ub[i], coef_mean_1lb[i]), c(i+.25,i+.25), lwd=2)
    lines(c(coef_mean_2ub[i], coef_mean_2lb[i]), c(i+.25,i+.25), lwd=1.25)
    #lines(c(coef_mean_3ub[i], coef_mean_3lb[i]), c(i+.25,i+.25), lwd=.5)
    lines(c(coef_median_1ub[i], coef_median_1lb[i]), c(i,i), lwd=2)
    lines(c(coef_median_2ub[i], coef_median_2lb[i]), c(i,i), lwd=1.25)
    #lines(c(coef_median_3ub[i], coef_median_3lb[i]), c(i,i), lwd=.5)
    lines(c(coef_max_1ub[i], coef_max_1lb[i]), c(i-.25,i-.25), lwd=2)
    lines(c(coef_max_2ub[i], coef_max_2lb[i]), c(i-.25,i-.25), lwd=1.5)
    #lines(c(coef_max_3ub[i], coef_max_3lb[i]), c(i-.25,i-.25), lwd=.5)
  }
  
  points(coef_mean, 1.25:6.25, col=1, bg=grey(.25), pch=21)
  points(coef_median, 1:6, col=1, bg=grey(.65), pch=23)
  points(coef_max, 0.75:5.75, col=1, bg=grey(.95), pch=22)
  
  mtext(side=3, line=0.5, text="Lower <----------- Google Search Rate -----------> Higher")
  
  if(attention_rate==FALSE & NGO_amnesty==TRUE) axis(side=2, at=6:1, labels=c("FDI Inflows", "Amnesty Report (Count)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship"), las=2)
  if(attention_rate==TRUE & NGO_amnesty==TRUE) axis(side=2, at=6:1, labels=c("FDI Inflows", "Amnesty Report (Rate)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship"), las=2)
  if(attention_rate==FALSE & NGO_amnesty==FALSE) axis(side=2, at=6:1, labels=c("FDI Inflows", "NGO Presence (Count)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship"), las=2)
  if(attention_rate==TRUE & NGO_amnesty==FALSE) axis(side=2, at=6:1, labels=c("FDI Inflows", "NGO Presence (Rate)", "HR Treaty Ratifications", "GDP Growth", "HR Violations", "Internet Censorship"), las=2)
  
  
  axis(side=1, at=-6:6)

  legend("topright", legend=c("mean rate", "median rate", "max rate"), pch=c(21, 23, 22), col=1, pt.bg=c(grey(.25), grey(.65), grey(.95)), bty="n", cex=.75)

  dev.off()
}



##########################################################################
## a bunch of alternative models (not reported; see other files)
##########################################################################

## panel linear models
unit_n <- c()
fit_mean_robust <- fit_median_robust <- fit_max_robust <- list()
for(i in 1:length(test_dat_language_pooled)){
  
  temp <- subset(test_dat_language_pooled[[i]], !is.na(CCODE))
 
  ## scale variable 
  temp$theta_mean <- -1*temp$theta_mean
  temp$amnesty_report_count <- scale(temp$amnesty_report_count)
  temp$GDP_growth_annual_percent <- scale(temp$GDP_growth_annual_percent)
  temp$Foreign_direct_investment_net_inflows_percent_GDP <- scale(temp$Foreign_direct_investment_net_inflows_percent_GDP) 
  temp$treaty_count <- scale(temp$treaty_count)
  temp$v2smgovfilprc <- scale(temp$v2smgovfilprc)

  fit_mean <- plm(hits_mean ~ theta_mean + 
              amnesty_report_count + 
              GDP_growth_annual_percent + 
              Foreign_direct_investment_net_inflows_percent_GDP + 
                treaty_count + 
              v2smgovfilprc + 
                Individuals_using_internet_percentage_population, 
            data=temp,
            effect = c("individual"),
            model = c("within"),
            index= c("language")
            )
  #summary(fit)
  ## robust clustered standard errors
  fit_mean_robust[[i]] <- coeftest(fit_mean, vcov = vcovHC,  type = "HC1")
  
  fit_median <- plm(hits_median ~ theta_mean + 
                    amnesty_report_count + 
                    GDP_growth_annual_percent + 
                    Foreign_direct_investment_net_inflows_percent_GDP + 
                    treaty_count + 
                    v2smgovfilprc + 
                      Individuals_using_internet_percentage_population, 
                  data=temp,
                  effect = c("individual"),
                  model = c("within"),
                  index= c("language")
  )
  #summary(fit)
  ## robust clustered standard errors
  fit_median_robust[[i]] <- coeftest(fit_median, vcov = vcovHC,  type = "HC1")
  
  fit_max <- plm(hits_max ~ theta_mean + 
                    amnesty_report_count + 
                    GDP_growth_annual_percent + 
                    Foreign_direct_investment_net_inflows_percent_GDP + 
                    treaty_count + 
                    v2smgovfilprc + 
                   Individuals_using_internet_percentage_population, 
                  data=temp,
                  effect = c("individual"),
                  model = c("within"),
                  index= c("language")
  )
  #summary(fit)
  ## robust clustered standard errors
  fit_max_robust[[i]] <- coeftest(fit_max, vcov = vcovHC,  type = "HC1")
  
  unit_n[i] <- length(fit_mean$residuals)
}
unit_n

fit_mean_robust[[4]]
fit_median_robust[[4]]
fit_max_robust[[4]]



## panel linear models
unit_n <- c()
fit_mean_robust <- fit_median_robust <- fit_max_robust <- list()
for(i in 1:length(test_dat_language_pooled)){
  
  temp <- subset(test_dat_language_pooled[[i]], !is.na(CCODE))
  
  ## scale variable 
  #temp$amnesty_report_count <- scale(temp$amnesty_report_count)  
  #temp$GDP_growth_annual_percent <- scale(temp$GDP_growth_annual_percent)
  #temp$Foreign_direct_investment_net_inflows_percent_GDP <- scale(temp$Foreign_direct_investment_net_inflows_percent_GDP) 
  #temp$treaty_count <- scale(temp$treaty_count)
  #temp$v2smgovfilprc <- scale(temp$v2smgovfilprc)
  
  fit_mean <- plm(hits_mean ~ I(-1*theta_mean) + 
                    treaty_count + 
                    amnesty_report_count + 
                    GDP_growth_annual_percent + 
                    Foreign_direct_investment_net_inflows_percent_GDP + 
                    v2smgovfilprc, 
                  data=temp,
                  effect = c("individual"),
                  model = c("within"),
                  index= c("language")
  )

  fit_median <- plm(hits_median ~ I(-1*theta_mean) + 
                      treaty_count + 
                      amnesty_report_count + 
                      GDP_growth_annual_percent + 
                      Foreign_direct_investment_net_inflows_percent_GDP + 
                      v2smgovfilprc, 
                    data=temp,
                    effect = c("individual"),
                    model = c("within"),
                    index= c("language")
  )
  
  fit_max <- plm(hits_max ~ I(-1*theta_mean) + 
                   treaty_count + 
                   amnesty_report_count + 
                   GDP_growth_annual_percent + 
                   Foreign_direct_investment_net_inflows_percent_GDP + 
                   v2smgovfilprc, 
                 data=temp,
                 effect = c("individual"),
                 model = c("within"),
                 index= c("language")
  )
  #summary(fit)
  ## robust clustered standard errors
  fit_mean_robust[[i]] <- coeftest(fit_mean, vcov = vcovHC,  type = "HC1")
  fit_median_robust[[i]] <- coeftest(fit_median, vcov = vcovHC,  type = "HC1")
  fit_max_robust[[i]] <- coeftest(fit_max, vcov = vcovHC,  type = "HC1")
  
  unit_n[i] <- length(fit_mean$residuals)
}
unit_n

fit_mean_robust[[4]]
fit_median_robust[[4]]
fit_max_robust[[4]]




## define milm function
milm <- function(fml, midata){
  xx <- terms(as.formula(fml))
  lms <- matrix(data=NA, nrow=(length(attr(xx, "term.labels")) + 1), ncol=length(midata))
  ses <- matrix(data=NA, nrow=(length(attr(xx, "term.labels")) + 1), ncol=length(midata))
  vcovs <- list()
  for(i in 1:length(midata)){
    tmp <- lm(formula=as.formula(fml), data=midata[[i]])
    lms[,i] <- tmp$coefficients
    #ses[,i] <- sqrt(diag(vcov(tmp)))
    #vcovs[[i]] <- vcov(tmp)
    ses[,i] <- sqrt(diag(vcovHC(tmp, type="HC1")))
    
    #library(clubSandwich)
    #modfit_cluster[[i]] <- coef_test(tmp, vcov = "CR2", cluster = "individual", test = "Satterthwaite")
    
    vcovs[[i]] <- vcovHC(tmp, type="HC1")
  }
  par.est <- apply(lms, 1, mean)
  se.within <- apply(ses^2, 1, mean)
  se.between <- apply(lms, 1, var)
  se.est <- sqrt(se.within + se.between*(1 + (1/length(midata))))
  list("terms"=names(tmp$coefficients), "beta" = par.est, "SE"=se.est, "vcovs"=vcovs,"coefs" = lms)    
}

## function to calculate the p-value of the mean
pvalue <- function(x, x.se, N){
 pvalue <- pt(x/x.se, df=N-1)
 #pvalue <- pnorm(x/x.se) ## if you want to just use a z-score
 temp <- c()
 for(i in 1:length(pvalue)){
  temp[i] <- 2 * min(pvalue[i], 1 - pvalue[i])
 }
 return(temp)
}

data <- test_dat
newdata <- list()
for(i in 1:1000){
  newdata[[i]] <- data
  newdata[[i]]$draw <- rnorm(cbind(rep(1,nrow(data))), mean=data$theta_mean, sd=data$theta_sd)
}


# call the milm function with the list of datasets newdata
fit <- milm(fml="hits_mean ~ draw + amnesty_report_count", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_median ~ theta_mean + amnesty_report_count", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_max ~ theta_mean + amnesty_report_count", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_mean ~ amnesty_report_count", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_median ~ amnesty_report_count", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_max ~ amnesty_report_count", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_mean ~ theta_mean", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_median ~ theta_mean", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)

fit <- milm(fml="hits_max ~ theta_mean", midata=newdata)
temp <- data.frame(fit$terms, fit$beta, fit$SE, fit$beta/fit$SE, pvalue=pvalue(x=fit$beta, x.se=fit$SE, N=N))
print(temp)
