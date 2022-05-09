## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

dat <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2012-01-01_2016-12-31_saved_2022-04-27.csv")
dat <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2013-01-01_2017-12-31_saved_2022-04-27.csv")
dat <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2014-01-01_2018-12-31_saved_2022-04-28.csv")
dat <- read.csv("Data_output_search/gsearch_cy_data_human_rights_2015-01-01_2019-12-31_saved_2022-04-27.csv")
head(dat)

HRPS <- read.csv("Data_output/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv")
HRPS <- subset(HRPS, YEAR>=min(dat$year))
head(HRPS)

test_dat <- merge(dat, HRPS, by.x=c("CCODE", "year"), by.y=c("COW", "YEAR"), all=TRUE)

head(test_dat)
dim(test_dat)

test_dat$hits_mean[is.na(test_dat$hits_mean)] <- 0
test_dat$hits_median[is.na(test_dat$hits_median)] <- 0
test_dat$hits_max[is.na(test_dat$hits_max)] <- 0
test_dat$hits_sd[is.na(test_dat$hits_sd)] <- 0


## correlations
cor.test(test_dat$hits_mean, test_dat$theta_mean)
cor.test(test_dat$hits_mean, test_dat$amnesty_report_count)

cor.test(test_dat$hits_median, test_dat$theta_mean)
cor.test(test_dat$hits_median, test_dat$amnesty_report_count)

cor.test(test_dat$hits_max, test_dat$theta_mean)
cor.test(test_dat$hits_max, test_dat$amnesty_report_count)

## linear models
fit <- lm(hits_mean ~ theta_mean + amnesty_report_count, data=test_dat)
#summary(fit)
coeftest(fit, vcov = vcovHC, type = "HC1", cluster=~ISO)

fit <- lm(hits_median ~ theta_mean + amnesty_report_count, data=test_dat)
#summary(fit)
coeftest(fit, vcov = vcovHC, type = "HC1", cluster=~ISO)

fit <- lm(hits_max ~ theta_mean + amnesty_report_count, data=test_dat)
#summary(fit)
coeftest(fit, vcov = vcovHC, type = "HC1", cluster=~ISO)


N <- nrow(fit$model)
N

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
  se.within <- apply(ses, 1, mean)
  se.between <- apply(lms, 1, var)
  se.est <- sqrt(se.within^2 + se.between*(1 + (1/length(midata))))
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
