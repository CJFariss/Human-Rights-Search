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
