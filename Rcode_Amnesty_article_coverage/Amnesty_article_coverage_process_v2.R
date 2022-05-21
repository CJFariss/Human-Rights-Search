test_list <- readRDS("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/Amnesty_source_list_0001_5600.RDS")

temp <- readRDS("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/Amnesty_source_list_5601_6260.RDS")

test_list[5601:6260] <- temp[5601:6260]
rm(temp)


table(sapply(test_list[1:6260], length))


new_list <- list()
id <- 0

for(i in 1:length(test_list)){
#for(i in 1:5){ ## for testing
  starts <- grep("<article class=", test_list[[i]])
  stops <- grep("</article>", test_list[[i]])

 for(j in 1:length(starts)){
   id <- id + 1
   coordinates <- starts[j]:stops[j]
   new_list[[id]] <- test_list[[i]][coordinates]
  } 
  
}
id
new_list[[id]]


gsub(pattern="<article class=\"post post--result\" aria-label=\"", "", new_list[[5001]])
gsub(pattern="\t<a class=\"floating-anchor\" href=\"", "", new_list[[5001]])
gsub(pattern="\" aria-hidden=\"true\"></a>", "", new_list[[5001]])
