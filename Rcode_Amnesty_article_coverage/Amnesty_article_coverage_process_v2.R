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

## testing
table(sapply(new_list, length))
which(sapply(new_list, length)>9)

out_list <- list()
for(i in 1:length(new_list)){
  temp <- new_list[[i]]
  temp
  
  post_result_id <- grep("post post--result", temp)
  post_result_id
  post_href_id <- grep("floating-anchor", temp)
  post_href_id
  post_location_id <- grep("post-location", temp)
  post_location_id
  post_topic_id <- grep("post-topic", temp)
  post_topic_id
  post_title_id <- grep("post-title", temp)
  post_title_id
  post_excerpt_id <- grep("post-excerpt", temp)
  post_excerpt_id
  post_publication_date_id <- grep("Post published date", temp) 
  post_publication_date_id
  post_updated_date_id <- grep("Post updated date", temp)
  post_updated_date_id
  end_article_id <- grep("</article>", temp) 
  end_article_id
  
  ## regular expression patterns to remove
  text_patterns <- c("<article class=\"post post--result\" aria-label=\"", 
                    "\">", 
                    "\t<a class=\"floating-anchor\" href=\"", 
                    "\" aria-hidden=\"true\"></a>", 
                    "\" aria-hidden=\"true</a>", 
                    "\t<a class=\"post-location\" href=\"", 
                    "\t<a class=\"post-topic\" href=\"",
                    "\t<h1 class=\"post-title\"><a href=\"",
                    "\t<h1 class=\"post-title<a href=\"",
                    "\t<div class=\"post-excerpt\">",
                    "\t<div class=\"post-excerpt",
                    "</div>",
                    "\t<span class=\"post-byline\" aria-label=\"Post published date\">",
                    "</span>",
                    "\t<strong class=\"post-byline\" aria-label=\"Post updated date\">",
                    "\t<span class=\"post-byline\" aria-label=\"Post published date",
                    "</strong>",
                    "</a>",
                    "</h1>"
                    )
  
  for(k in 1:length(text_patterns)){
    temp <- gsub(pattern=paste(text_patterns[k]), "", temp)
  }
  temp
  
  ## regular expression patterns to use as seperators
  text_sep_patterns <- c("\" tabindex=\"0")
  for(k in 1:length(text_sep_patterns)){
    temp <- gsub(pattern=paste(text_sep_patterns[k]), ";", temp)
  }
  temp
  
  
  out <- c(ifelse(is.null(temp[post_result_id]), NA, temp[post_result_id]),
            ifelse(is.null(temp[post_href_id]), NA, temp[post_href_id]),
            ifelse(is.null(unlist(strsplit(temp[post_location_id], split=";"))[1]), NA, unlist(strsplit(temp[post_location_id], split=";"))[1]),
            ifelse(is.null(unlist(strsplit(temp[post_location_id], split=";"))[2]), NA, unlist(strsplit(temp[post_location_id], split=";"))[2]),
            ifelse(is.null(unlist(strsplit(temp[post_topic_id], split=";"))[1]), NA, unlist(strsplit(temp[post_topic_id], split=";"))[1]),
            ifelse(is.null(unlist(strsplit(temp[post_topic_id], split=";"))[2]), NA, unlist(strsplit(temp[post_topic_id], split=";"))[2]),
            ifelse(is.null(unlist(strsplit(temp[post_title_id], split=";"))[1]), NA, unlist(strsplit(temp[post_title_id], split=";"))[1]),
            ifelse(is.null(unlist(strsplit(temp[post_title_id], split=";"))[2]), NA, unlist(strsplit(temp[post_title_id], split=";"))[2]),
            ifelse(is.null(temp[post_excerpt_id]), NA, temp[post_excerpt_id]),
            ifelse(is.null(temp[post_publication_date_id]), NA, temp[post_publication_date_id]),
            ifelse(is.null(temp[post_updated_date_id]), NA, temp[post_updated_date_id]),
            ifelse(is.null(temp[end_article_id]), NA, temp[end_article_id])
           ) 
  
  out_list[[i]] <- out

}
## check dimensions
table(sapply(out_list, length))

## new dataset
out_dat <- do.call("rbind", out_list)

dim(out_dat)



write.csv(out_dat, file="Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/amnesty_article_meta_data.csv")


out_dat <- read.csv("Rcode_Amnesty_article_coverage/Amnesty_webpage_source_files_v2/amnesty_article_meta_data.csv")
out_dat[3,]
names(out_dat) <- c("id", "article_title", "article_url", "location_url", "location", "topic_url", "topic", "article_url_2", "article_title_2", "post_excerpt", "article_publication_date", "post_updated_date", "end_article_code")
names(out_dat)

out_dat$article_publication_date <- gsub(",", "", out_dat$article_publication_date)

for(i in 1:nrow(out_dat)){
  out_dat$YEAR <- strsplit(out_dat$article_publication_date, split=" ")
}