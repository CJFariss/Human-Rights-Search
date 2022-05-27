## gtrends_elated_topics.R

temp <- readRDS("Data_output_location_search_lists_lowsearch/gsearch_location_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-12.RDS")

  
pdf("Rplot_Related_Topics/gtrends_related_searches_2015_2019.pdf", height=9, width=12)

for(i in 1:length(temp)){
  related_topics <- subset(temp[[i]]$related_topics, related_topics=="top")
  related_topics
  
  related_queries <- subset(temp[[i]]$related_queries, related_queries=="top")
  related_queries
  
  related_topics$subject <- as.numeric(related_topics$subject)
  related_queries$subject <- as.numeric(related_queries$subject)
  related_queries
  
  interest_by_city <- subset(temp[[i]]$interest_by_city, !is.na(hits))
  interest_by_city
  
  interest_by_region <- subset(temp[[i]]$interest_by_region, !is.na(hits))
  interest_by_region
  
  par(mfrow=c(2,2), mar=c(2.5,18,2.25,.5))
  
  barplot(related_topics$subject[order(related_topics$subject, decreasing=FALSE)], names.arg=related_topics$value[order(related_topics$subject, decreasing=FALSE)], horiz=TRUE, las=2, space=0, main="Rate for Related Topics", xaxt="n")
  axis(side=1, at=c(0,20,40,60,80,100))
  
  barplot(related_queries$subject[order(related_queries$subject, decreasing=FALSE)], names.arg=related_queries$value[order(related_queries$subject, decreasing=FALSE)], horiz=TRUE, las=2, space=0,  main="Rate for Related Searches (Queries)", xaxt="n")
  axis(side=1, at=c(0,20,40,60,80,100))
  
  barplot(interest_by_city$hits[order(interest_by_city$hits, decreasing=FALSE)], names.arg=interest_by_city$location[order(interest_by_city$hits, decreasing=FALSE)], horiz=TRUE, las=2, space=0, main="Rate of Searches\nby City", xaxt="n")
  axis(side=1, at=c(0,20,40,60,80,100))
  
  barplot(interest_by_region$hits[order(interest_by_region$hits, decreasing=FALSE)], names.arg=interest_by_region$location[order(interest_by_region$hits, decreasing=FALSE)], horiz=TRUE, las=2, space=0, main="Rate of Searches\nby Region", xaxt="n")
  axis(side=1, at=c(0,20,40,60,80,100))

}

dev.off()

