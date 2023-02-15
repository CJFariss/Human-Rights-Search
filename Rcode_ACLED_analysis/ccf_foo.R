## ccf_foo.R
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
## this is a year over year correlation function

ccf_foo <- function(var1, var2, X){
  c0 <- c()
  
  index <- -X:X
  
  middle <- cor(var1, var2, use="pairwise", method="spearman")
  
  lags <- leads <- c()
  
  for(i in 1:X){
    ##c0[i] <- cor(sub_newdata$hits[-length(sub_newdata$hits)], sub_newdata$event_rate[-1])
    lags[i] <- cor(var1[-((length(var1)-i+1):length(var1))], var2[-(1:(i))], use="pairwise", method="spearman")
    leads[i] <- cor(var2[-((length(var2)-i+1):length(var2))], var1[-(1:(i))], use="pairwise", method="spearman")
    #lags[i] <- cor(var1[-((length(var1)-i+1):length(var1))], var2[-(1:(i))], use="pairwise", method="pearson")
    #leads[i] <- cor(var2[-((length(var2)-i+1):length(var2))], var1[-(1:(i))], use="pairwise", method="pearson")
  }
  
  c0 <- c(rev(lags), middle, leads)
  return(c0)
}

#out <- ccf_foo(var=sub_newdata$hits, var2=sub_newdata$event_rate, X=10)
#points(-22:22, out, col=4)
#barplot(out, space=0)
