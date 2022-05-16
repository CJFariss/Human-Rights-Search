
files_names <- list.files("Data_output_location_search_lists")
#files_names <- list.files("Data_output_location_search_lists_lowsearch")
files_names

dat_list <- list()
ISO_location <- c()
for(i in 1:length(files_names)){
  dat_list[[i]] <- readRDS(paste("Data_output_location_search_lists/", files_names[i], sep=""))
  ISO_location[i] <- dat_list[[i]]$interest_over_time$geo[1]
}

par(mfrow=c(4,3), mar=c(2,2.5,1,.5))
for(i in 1:length(dat_list)){
  plot(dat_list[[i]]$hits, main=location[i], lwd=1, col=grey(.75), ylim=c(0, 100), xaxt="n", yaxt="n", type="n")
  
  id2012 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2011-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2012-12-31"))
  id2013 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2012-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2013-12-31"))
  id2014 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2013-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2014-12-31"))
  id2015 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2014-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2015-12-31"))
  id2016 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2015-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2016-12-31"))
  id2017 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2016-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2017-12-31"))
  id2018 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2017-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2018-12-31"))
  id2019 <- which(as.Date(dat_list[[i]]$interest_over_time$date) > as.Date("2018-12-31") & as.Date(dat_list[[i]]$interest_over_time$date) <= as.Date("2019-12-31"))
  
  if(length(id2013)>0) polygon(x=c(min(id2013), min(id2013), max(id2013), max(id2013)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  if(length(id2015)>0) polygon(x=c(min(id2015), min(id2015), max(id2015), max(id2015)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  if(length(id2017)>0) polygon(x=c(min(id2017), min(id2017), max(id2017), max(id2017)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  if(length(id2019)>0) polygon(x=c(min(id2019), min(id2019), max(id2019), max(id2019)), y=c(-10,110,110,-10), col=grey(.95), border=NA)
  box()
  
  lines(dat_list[[i]]$interest_over_time$hits, lwd=1, col="#bdd7e7")
  axis(side=2, at=c(0,25,50,75,100), las=2)
  if(length(id2013)>0) axis(side=1, at=c(median(id2013)), labels=c(2013), las=1)
  if(length(id2015)>0) axis(side=1, at=c(median(id2015)), labels=c(2015), las=1)
  if(length(id2017)>0) axis(side=1, at=c(median(id2017)), labels=c(2017), las=1)
  if(length(id2019)>0) axis(side=1, at=c(median(id2019)), labels=c(2019), las=1)
  #axis(side=1, at=c(median(id2015), median(id2017), median(id2019)), labels=c(2015, 2017, 2019), las=1)
  model <- bcp(y= dat_list[[i]]$interest_over_time$hits)
  lines(model$posterior.mean, lwd=.75, col="#08519c")
}
