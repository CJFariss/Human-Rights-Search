## gtrends_related_topics.R

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from April-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

## get file names
files_names <- list.files("Data_output_location_search_lists_lowsearch")
files_names


for(j in 1:length(files_names)){
  

  temp <- readRDS(paste("Data_output_location_search_lists_lowsearch/", files_names[j], sep=""))
  
  temp <- temp[which(sapply(temp, length)==7)]
    
  pdf(paste("Rplot_Related_Topics/related_topics_", gsub(".RDS", "", files_names[j]), ".pdf", sep=""), height=9, width=12)
  
  for(i in 1:length(temp)){
   
    par(mfrow=c(2,2), mar=c(2.5,20,2.25,1))
    
    if(!is.null(temp[[i]]$related_topics)){
      related_topics <- subset(temp[[i]]$related_topics, related_topics=="top")
      related_topics$subject[related_topics$subject=="<1"] <- .5
      related_topics$subject <- as.numeric(related_topics$subject)
      related_topics
      
      if(any(!is.na(related_topics$subject))) barplot(related_topics$subject[order(related_topics$subject, decreasing=FALSE)], names.arg=related_topics$value[order(related_topics$subject, decreasing=FALSE)], horiz=TRUE, las=2, space=0, main="Rate for Related Topics", xaxt="n"); axis(side=1, at=c(0,20,40,60,80,100))
      
    }
    
    if(!is.null(temp[[i]]$related_queries)){
      related_queries <- subset(temp[[i]]$related_queries, related_queries=="top")
      related_queries$subject[related_queries$subject=="<1"] <- .5
      related_queries$subject <- as.numeric(related_queries$subject)
      related_queries
      
      if(any(!is.na(related_queries$subject))) barplot(related_queries$subject[order(related_queries$subject, decreasing=FALSE)], names.arg=related_queries$value[order(related_queries$subject, decreasing=FALSE)], horiz=TRUE, las=2, space=0,  main="Rate for Related Searches (Queries)", xaxt="n"); axis(side=1, at=c(0,20,40,60,80,100))
      
    }
    
    if(!is.null(temp[[i]]$interest_by_city)){
      interest_by_city <- subset(temp[[i]]$interest_by_city, !is.na(hits))
      interest_by_city
      
      if(any(!is.na(interest_by_city$hits))) barplot(interest_by_city$hits[order(interest_by_city$hits, decreasing=FALSE)], names.arg=interest_by_city$location[order(interest_by_city$hits, decreasing=FALSE)], horiz=TRUE, las=2, space=0, main="Rate of Searches\nby City", xaxt="n"); axis(side=1, at=c(0,20,40,60,80,100))
    
    }
    
    if(!is.null(temp[[i]]$interest_by_region)){
      interest_by_region <- subset(temp[[i]]$interest_by_region, !is.na(hits))
      interest_by_region
      
      
      if(any(!is.na(interest_by_region$hits))) barplot(interest_by_region$hits[order(interest_by_region$hits, decreasing=FALSE)], names.arg=interest_by_region$location[order(interest_by_region$hits, decreasing=FALSE)], horiz=TRUE, las=2, space=0, main="Rate of Searches\nby Region", xaxt="n"); axis(side=1, at=c(0,20,40,60,80,100))
    }  
    
  }
  
  dev.off()

}

