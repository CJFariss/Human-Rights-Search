## min_max_example_Rcode.R
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

search_volume <- c(100,50,10)
hr_search_volume <- c(10,1,1)

make_min_max_func <- function(search_volume = c(100,50,10), hr_search_volume = c(10,1,1)){
  
  par(mfrow=c(4,1), mar=c(3,3,3,1))
  
  barplot(search_volume, names.arg=c("Country A", "Country B", "Country C"), main="Total Search Volume", las=1, yaxt="n")
  axis(side=2, at=c(0,.25*max(search_volume), .5*max(search_volume), .75*max(search_volume), max(search_volume)), las=2)
  
  barplot(hr_search_volume, names.arg=c("Country A", "Country B", "Country C"), main="Human Rights Search Volume", ylim=c(0,max(hr_search_volume)), las=1, yaxt="n")
  axis(side=2, at=c(0,.25*max(hr_search_volume), .5*max(hr_search_volume), .75*max(hr_search_volume), max(hr_search_volume)), las=2)
  
  search_ratio <- hr_search_volume/search_volume
  
  barplot(search_ratio, names.arg=c("Country A", "Country B", "Country C"), main="Human Rights Search Ratio", ylim=c(0,1), las=1, yaxt="n")
  axis(side=2, at=c(.0,.20,.40,.60,.80,1.00), las=2)
  
  
  search_rate <- 100 * (search_ratio - min(search_ratio)) / (max(search_ratio) - min(search_ratio))
  
  barplot(search_rate, names.arg=c("Country A", "Country B", "Country C"), main="Human Rights Search Rate (min-max normalization)", las=1, yaxt="n")
  axis(side=2, at=c(0,20,40,60,80,100), las=2)
  
}

pdf("Rplot_search_rate_examples/Rplot_search_rate_examples_wide.pdf", height=6, width=9)

make_min_max_func(search_volume = c(1000,500,100), hr_search_volume = c(50,10,10))
make_min_max_func(search_volume = c(1000,500,100), hr_search_volume = c(50,10,50))
make_min_max_func(search_volume = c(1000,500,100), hr_search_volume = c(50,50,50))
make_min_max_func(search_volume = c(1000,500,100), hr_search_volume = c(100,10,10))
make_min_max_func(search_volume = c(1000,500,100), hr_search_volume = c(100,50,50))

dev.off()
