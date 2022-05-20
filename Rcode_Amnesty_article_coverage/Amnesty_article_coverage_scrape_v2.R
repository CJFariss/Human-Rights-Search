

## create list object with first Amnesty.org search page
i <- 1
test_list <- list()
test_list[[1]] <- try(readLines(paste("https://www.amnesty.org/en/search/page/",i,"/", sep="")))


## loop through COUNTRY-YEAR combinations for scrapping at https://www.amnesty.org
## Warning: this code takes a while and generates quite a few errors and warnings, hence the try() function
count <- 0
for(i in 2:5600){
  pause_value <- rgamma(1,.5)+runif(1)+1
  Sys.sleep(pause_value)
  test_list[[i]] <- try(readLines(paste("https://www.amnesty.org/en/search/page/",i,"/", sep="")))
print(c(i, pause_value))
}
saveRDS(test_list, file="Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/Amnesty_source_list_0001_5600.RDS")


i <- 1
test_list <- list()
test_list[[1]] <- try(readLines(paste("https://www.amnesty.org/en/search/page/",i,"/", sep="")))

for(i in 5601:6260){
  pause_value <- rgamma(1,.5)+runif(1)+1
  Sys.sleep(pause_value)
  test_list[[i]] <- try(readLines(paste("https://www.amnesty.org/en/search/page/",i,"/", sep="")))
  print(c(i, pause_value))
}
saveRDS(test_list, file="Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/Amnesty_source_list_5601_6260.RDS")

