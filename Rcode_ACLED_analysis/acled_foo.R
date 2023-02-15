## acled_foo.R
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
##
acled_foo <- function(search_term="derechos humanos", ISO2="GT", acled_country_name="Guatemala", start_date="2018-01-01", end_date="2021-11-26"){
  
  ## function defaults for error checking
  #search_term="derechos humanos"; ISO2="GT"; acled_country_name="Guatemala"; start_date="2018-01-01"; end_date="2021-11-26"; 
  
  library(boot)
  library(countrycode)
  library(stm)
  library(tm)
  library(MASS)
  library(bcp)
  library(forecast)
  library(acled.api)
  library(gtrendsR)
  library(stargazer)
  
  ## user defined function
  source("Rcode_ACLED_analysis/ccf_foo.R")
  
  ## the acled_data_out() function is defined with user specific info which is not provided 
  #acled_data_out_function <- function(email="youremail", key="youracledaccesskey", acled_country_name, start_date, end_date){
  #  acled.api(
  #    email.address = email,
  #    access.key = key,
  #    country = acled_country_name,
  #    start.date = start_date,
  #    end.date = end_date
  #  )
  #}
  
  source("Rcode_ACLED_analysis/acled_data_out_function.R")
  
  acled_data_out <- acled_data_out_function(acled_country_name=acled_country_name, start_date=start_date, end_date=end_date)
  acled_data_out <- acled_data_out[order(acled_data_out$event_date),]
  
  #### matching date format to acled data 
  acled_data_out$date <- as.Date(acled_data_out$event_date)
  acled_data_out$week_of_year <- strftime(acled_data_out$date, format = "%V")
  
  head(acled_data_out)
  
  #subset(acled_data_out, week_of_year==53)
  
  data_tab <- as.data.frame(xtabs( ~ event_type + week_of_year + year, data=acled_data_out))
  data_tab$number_of_events <- data_tab$Freq
  
  dim(data_tab)
  head(data_tab)
  
  ## ------------------------------------------------------------ ##
  temp <- gtrends(search_term, geo=ISO2, time=paste(start_date, end_date))
  #temp <- gtrends(search_term, geo=ISO2, time="2018-01-01 2021-11-21")
  #temp <- gtrends(TERMS[1], geo="UG", time="2018-01-01 2021-11-21")
  #temp <- gtrends(TERMS[2], geo=ISO2, time="2018-01-01 2021-11-21")
  #temp <- gtrends(TERMS[6], geo=ISO2, time="2018-01-01 2021-11-21")
  #temp <- gtrends("protest", geo="UG", time="2018-01-01 2021-11-21")
  #temp <- gtrends("protesta", geo="UG", time="2018-01-01 2021-11-21")
  #temp <- gtrends("%2Fm%2F01nd_n", geo="UG", time="2018-01-01 2021-11-21")
  #temp <- gtrends("violence", geo="GT", time="2018-01-01 2021-11-21")
  #temp <- gtrends("violencia", geo="GT", time="2018-01-01 2021-11-21")
  #temp <- gtrends("%2Fm%2F0chbx", geo="GT", time="2018-01-01 2021-11-21")
  hits_data <- temp$interest_over_time
  hits_data$week_of_year <- strftime(hits_data$date, format = "%V")
  hits_data$year <- strftime(hits_data$date, "%Y")
  newdata <- merge(hits_data, data_tab, by.x=c("week_of_year", "year"), by.y=c("week_of_year", "year"), all=TRUE)
  newdata <- newdata[order(newdata[,1]),]
  newdata <- newdata[order(newdata[,2]),]
  #sub_newdata <- na.omit(subset(newdata, event_type=="Battles", select=c(hits, number_of_events)))
  #sub_newdata <- na.omit(subset(newdata, event_type=="Explosions/Remote violence", select=c(hits, number_of_events)))
  #sub_newdata <- na.omit(subset(newdata, event_type=="Protests", select=c(hits, number_of_events)))
  #sub_newdata <- na.omit(subset(newdata, event_type=="Riots", select=c(hits, number_of_events)))
  #sub_newdata <- na.omit(subset(newdata, event_type=="Strategic developments", select=c(hits, number_of_events)))
  sub_newdata <- na.omit(subset(newdata, event_type=="Violence against civilians", select=c(week_of_year, year, date, hits, number_of_events)))
  sub_newdata$event_rate <- 100*(sub_newdata$number_of_events/max(sub_newdata$number_of_events, na.rm=T))
  
  
  Ccf(ts(sub_newdata$hits), ts(sub_newdata$event_rate), type="correlation", main=paste("Correlations between Search Rates \nand Violence Against Civilians in ", acled_country_name, sep=""))#, ylab="Correlation")#, )
  out <- ccf_foo(var=sub_newdata$hits, var2=sub_newdata$event_rate, X=22)
  points(-22:22, out, col=2)
  abline(v=0, col=2, lty=2, lwd=.5)
  
  saveRDS(sub_newdata, file="sub_newdata.RDS")
  
  plot(sub_newdata$hits, type="l")
  lines(sub_newdata$event_rate, col=2)
  fit_bcp <- bcp(y=sub_newdata$hits, x=sub_newdata$number_of_events)
  plot(fit_bcp)
  
  #Ccf(ts(sub_newdata$hits), ts(sub_newdata$number_of_events))
  #abline(v=0, col=2, lty=2)
  #out <- ccf_foo(var=sub_newdata$hits, var2=sub_newdata$event_rate, X=22)
  #points(-22:22, out, col=2)
  
  sub_newdata$hits_lag1 <- c(sub_newdata$hits[-1], NA)
  sub_newdata$hits_lag2 <- c(sub_newdata$hits[-c(1:2)], NA, NA)
  sub_newdata$hits_lag3 <- c(sub_newdata$hits[-c(1:3)], NA, NA, NA)
  sub_newdata$hits_lag4 <- c(sub_newdata$hits[-c(1:4)], NA, NA, NA, NA)
  sub_newdata$event_rate_lag1 <- c(sub_newdata$event_rate[-1], NA)
  sub_newdata$event_rate_lag2 <- c(sub_newdata$event_rate[-c(1:2)], NA, NA)
  sub_newdata$event_rate_lag3 <- c(sub_newdata$event_rate[-c(1:3)], NA, NA, NA)
  sub_newdata$event_rate_lag4 <- c(sub_newdata$event_rate[-c(1:4)], NA, NA, NA, NA)
  
  sub_newdata$number_of_events_lag1 <- c(sub_newdata$number_of_events[-1], NA)
  sub_newdata$number_of_events_lag2 <- c(sub_newdata$number_of_events[-c(1:2)], NA, NA)
  sub_newdata$number_of_events_lag3 <- c(sub_newdata$number_of_events[-c(1:3)], NA, NA, NA)
  sub_newdata$number_of_events_lag4 <- c(sub_newdata$number_of_events[-c(1:4)], NA, NA, NA, NA)
  
  
  fit0 <- lm(hits ~ hits_lag1, data=sub_newdata)
  summary(fit0)
  
  fit1 <- lm(hits ~ hits_lag1 + event_rate_lag1, data=sub_newdata)
  summary(fit1)
  
  fit2 <- lm(hits ~ hits_lag1 + hits_lag2 + event_rate_lag1 + event_rate_lag2, data=sub_newdata)
  summary(fit2)
  
  fit3 <- lm(hits ~ hits_lag1 + hits_lag2 + hits_lag3 + event_rate_lag1 + event_rate_lag2 + event_rate_lag3, data=sub_newdata)
  summary(fit3)
  
  fit4 <- lm(hits ~ hits_lag1 + hits_lag2 + hits_lag3 + hits_lag4 + event_rate_lag1 + event_rate_lag2 + event_rate_lag3 + event_rate_lag4, data=sub_newdata)
  summary(fit4)
  
  
  fit5 <- lm(hits ~ hits_lag1 + event_rate, data=sub_newdata)
  summary(fit5)
  
  fit6 <- lm(hits ~ hits_lag1 + event_rate + event_rate_lag1, data=sub_newdata)
  summary(fit6)
  
  fit7 <- lm(hits ~ hits_lag1 + hits_lag2 + event_rate + event_rate_lag1 + event_rate_lag2, data=sub_newdata)
  summary(fit7)
  
  fit8 <- lm(hits ~ hits_lag1 + hits_lag2 + hits_lag3 + event_rate + event_rate_lag1 + event_rate_lag2 + event_rate_lag3, data=sub_newdata)
  summary(fit8)
  
  fit9 <- lm(hits ~ hits_lag1 + hits_lag2 + hits_lag3 + hits_lag4 + event_rate + event_rate_lag1 + event_rate_lag2 + event_rate_lag3 + event_rate_lag4, data=sub_newdata)
  summary(fit9)
  
  #stargazer(fit0, fit1, fit2, fit3, fit4)
  #stargazer(fit5, fit6, fit7, fit8, fit9)
  
  
  ## create vectors for storing predictions
  sub_newdata$y_hat_fit0 <- NA
  sub_newdata$y_hat_fit1 <- NA
  sub_newdata$y_hat_fit11 <- NA
  sub_newdata$y_hat_loess_fit0 <- NA
  sub_newdata$y_hat_loess_fit1 <- NA
  sub_newdata$y_hat_loess_fit11 <- NA
  
  ## folds by year
  sub_newdata$folds <- as.numeric(sub_newdata$year) - min(as.numeric(sub_newdata$year)) + 1
  #sub_newdata$folds <- as.numeric(sub_newdata$week_of_year) - min(as.numeric(sub_newdata$week_of_year)) + 1
  table(sub_newdata$folds)
  
  k <- length(table(sub_newdata$folds))
  k
  
  ##  function to
  for(i in 1:k){
    
    ## fit a linear model
    fit_temp <- lm(hits ~ hits_lag1, data=subset(sub_newdata, folds!=i))
    pred_temp <- predict(fit_temp, newdata=subset(sub_newdata, folds==i))
    sub_newdata$y_hat_fit0[sub_newdata$fold==i] <- as.numeric(pred_temp)
    
    ## fit a linear model
    fit_temp <- lm(hits ~ hits_lag1 + event_rate_lag1, data=subset(sub_newdata, folds!=i))
    pred_temp <- predict(fit_temp, newdata=subset(sub_newdata, folds==i))
    sub_newdata$y_hat_fit1[sub_newdata$fold==i] <- as.numeric(pred_temp)
    
    ## fit a linear model
    fit_temp <- lm(hits ~ hits_lag1 + event_rate + event_rate_lag1, data=subset(sub_newdata, folds!=i))
    pred_temp <- predict(fit_temp, newdata=subset(sub_newdata, folds==i))
    sub_newdata$y_hat_fit11[sub_newdata$fold==i] <- as.numeric(pred_temp)
    
    ## fit loess regression
    fit_temp <- loess(hits ~ hits_lag1, span = .4, data=sub_newdata)
    pred_temp <- predict(fit_temp, newdata=subset(sub_newdata, folds==i))
    sub_newdata$y_hat_loess_fit0[sub_newdata$fold==i] <- as.numeric(pred_temp)
    
    ## fit loess regression
    fit_temp <- loess(hits ~ hits_lag1 + event_rate_lag1, span = .4, data=sub_newdata)
    pred_temp <- predict(fit_temp, newdata=subset(sub_newdata, folds==i))
    sub_newdata$y_hat_loess_fit1[sub_newdata$fold==i] <- as.numeric(pred_temp)
    
    ## fit loess regression
    fit_temp <- loess(hits ~ hits_lag1 + event_rate + event_rate_lag1, span = .4, data=sub_newdata)
    pred_temp <- predict(fit_temp, newdata=subset(sub_newdata, folds==i))
    sub_newdata$y_hat_loess_fit11[sub_newdata$fold==i] <- as.numeric(pred_temp)
    
    
  }
  
  rmse_fit0 <- sqrt(mean((sub_newdata$y_hat_fit0 - sub_newdata$hits)^2, na.rm=T))
  rmse_fit0
  
  rmse_fit1 <- sqrt(mean((sub_newdata$y_hat_fit1 - sub_newdata$hits)^2, na.rm=T))
  rmse_fit1
  
  rmse_loess_fit0 <- sqrt(mean((sub_newdata$y_hat_loess_fit0 - sub_newdata$hits)^2, na.rm=T))
  rmse_loess_fit0
  
  rmse_loess_fit1 <- sqrt(mean((sub_newdata$y_hat_loess_fit1 - sub_newdata$hits)^2, na.rm=T))
  rmse_loess_fit1
  
  c(rmse_fit0, rmse_fit1, rmse_loess_fit0, rmse_loess_fit1)
  
  
  cor_fit0 <- cor(sub_newdata$y_hat_fit0, sub_newdata$hits, use="pairwise", method="spearman")
  cor_fit0
  
  cor_fit1 <- cor(sub_newdata$y_hat_fit1, sub_newdata$hits, use="pairwise", method="spearman")
  cor_fit1
  
  cor_fit11 <- cor(sub_newdata$y_hat_fit11, sub_newdata$hits, use="pairwise", method="spearman")
  cor_fit11
  
  cor_loess_fit0 <- cor(sub_newdata$y_hat_loess_fit0, sub_newdata$hits, use="pairwise", method="spearman")
  cor_loess_fit0
  
  cor_loess_fit1 <- cor(sub_newdata$y_hat_loess_fit1, sub_newdata$hits, use="pairwise", method="spearman")
  cor_loess_fit1
  
  cor_loess_fit11 <- cor(sub_newdata$y_hat_loess_fit11, sub_newdata$hits, use="pairwise", method="spearman")
  cor_loess_fit11
  
  c(cor_fit0, cor_fit1,cor_fit11, cor_loess_fit0, cor_loess_fit1, cor_loess_fit11)
  
  par(mar=c(4,4.5,1,.5), mfrow=c(3,2))
  plot(sub_newdata$hits, sub_newdata$y_hat_fit0, main="OLS with Lagged DV", xlab="", ylab="CV Predicted Search Value", ylim=c(0,100), xlim=c(0,100), cex.lab=1.5)
  abline(a=0,b=1,col=2,lty=2)
  text(x=0,y=94, expression(paste(rho=="")), pos=4, cex=2)
  text(x=12.55,y=95, round(cor_fit0,2), pos=4, cex=1.75)
  plot(sub_newdata$hits, sub_newdata$y_hat_loess_fit0, main="Loess with Lagged DV", xlab="", ylab="CV Predicted Search Value", ylim=c(0,100), xlim=c(0,100), cex.lab=1.5)
  abline(a=0,b=1,col=2,lty=2)
  text(x=0,y=94, expression(paste(rho=="")), pos=4, cex=2)
  text(x=12.55,y=95, round(cor_loess_fit0,2), pos=4, cex=1.75)
  plot(sub_newdata$hits, sub_newdata$y_hat_fit1, xlab="", main="OLS with Lagged DV and Lagged Predictor", ylab="CV Predicted Search Value", ylim=c(0,100), xlim=c(0,100), cex.lab=1.5)
  abline(a=0,b=1,col=2,lty=2)
  text(x=0,y=94, expression(paste(rho=="")), pos=4, cex=2)
  text(x=12.55,y=95, round(cor_fit1,2), pos=4, cex=1.75)
  plot(sub_newdata$hits, sub_newdata$y_hat_loess_fit1, xlab="", main="Loess with Lagged DV and Lagged Predictor", ylab="CV Predicted Search Value", ylim=c(0,100), xlim=c(0,100), cex.lab=1.5)
  abline(a=0,b=1,col=2,lty=2)
  text(x=0,y=94, expression(paste(rho=="")), pos=4, cex=2)
  text(x=12.55,y=95, round(cor_loess_fit1,2), pos=4, cex=1.75)
  plot(sub_newdata$hits, sub_newdata$y_hat_fit11, main="OLS with Lagged DV and Predictor and Lagged Predictor", xlab="Observed Searched Value", ylab="CV Predicted Search Value", ylim=c(0,100), xlim=c(0,100), cex.lab=1.5)
  abline(a=0,b=1,col=2,lty=2)
  text(x=0,y=94, expression(paste(rho=="")), pos=4, cex=2)
  text(x=12.55,y=95, round(cor_fit11,2), pos=4, cex=1.75)
  plot(sub_newdata$hits, sub_newdata$y_hat_loess_fit11, main="Loess with Lagged DV and Predictor and Lagged Predictor", xlab="Observed Searched Value", ylab="CV Predicted Search Value", ylim=c(0,100), xlim=c(0,100), cex.lab=1.5)
  abline(a=0,b=1,col=2,lty=2)
  text(x=0,y=94, expression(paste(rho=="")), pos=4, cex=2)
  text(x=12.55,y=95, round(cor_loess_fit11,2), pos=4, cex=1.75)
  
  return(sub_newdata)
  
}

TERMS <- c("human rights", "derechos humanos", "direitos humanos", "حقوق الانسان", "droits", "%2Fm%2F03ll3")

sub_newdata <- acled_foo(search_term=TERMS[6], 
                         ISO2="GT", 
                         acled_country_name="Guatemala", 
                         start_date="2018-01-01", 
                         end_date="2022-12-31"
)

sub_newdata <- acled_foo(search_term=TERMS[3], 
                         ISO2="MZ", 
                         acled_country_name="Mozambique", 
                         start_date="2018-01-01", 
                         end_date="2021-12-31"
)

par(mar=c(4,4,1,1), mfrow=c(1,1))
plot(sub_newdata$hits)
lines(sub_newdata$hits, col=grey(.5))
lines(sub_newdata$y_hat_fit0, col=2)
lines(sub_newdata$y_hat_fit1, col=3)
lines(sub_newdata$y_hat_loess_fit0, col=4)
lines(sub_newdata$y_hat_loess_fit1, col=1)

rmse_fit0 <- sqrt(mean((sub_newdata$y_hat_fit0 - sub_newdata$hits)^2, na.rm=T))
rmse_fit0

rmse_fit1 <- sqrt(mean((sub_newdata$y_hat_fit1 - sub_newdata$hits)^2, na.rm=T))
rmse_fit1

rmse_loess_fit0 <- sqrt(mean((sub_newdata$y_hat_loess_fit0 - sub_newdata$hits)^2, na.rm=T))
rmse_loess_fit0

rmse_loess_fit1 <- sqrt(mean((sub_newdata$y_hat_loess_fit1 - sub_newdata$hits)^2, na.rm=T))
rmse_loess_fit1

c(rmse_fit0, rmse_fit1, rmse_loess_fit0, rmse_loess_fit1)


cor_fit0 <- cor(sub_newdata$y_hat_fit0, sub_newdata$hits, use="pairwise", method="spearman")
cor_fit0

cor_fit1 <- cor(sub_newdata$y_hat_fit1, sub_newdata$hits, use="pairwise", method="spearman")
cor_fit1

cor_fit11 <- cor(sub_newdata$y_hat_fit11, sub_newdata$hits, use="pairwise", method="spearman")
cor_fit11

cor_loess_fit0 <- cor(sub_newdata$y_hat_loess_fit0, sub_newdata$hits, use="pairwise", method="spearman")
cor_loess_fit0

cor_loess_fit1 <- cor(sub_newdata$y_hat_loess_fit1, sub_newdata$hits, use="pairwise", method="spearman")
cor_loess_fit1

cor_loess_fit11 <- cor(sub_newdata$y_hat_loess_fit11, sub_newdata$hits, use="pairwise", method="spearman")
cor_loess_fit11

c(cor_fit0, cor_fit1,cor_fit11, cor_loess_fit0, cor_loess_fit1, cor_loess_fit11)


par(mfrow=c(2,1))
plot(pred[[1]]$fit, ylim=c(0,100), type="n")
for(i in 1:10) lines(pred[[i]]$fit, ylim=c(0,100), col=i, lwd=i/10)
plot(ecdf(sub_newdata$number_of_events))


