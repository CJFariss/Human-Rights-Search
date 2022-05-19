## gtrends_country_search_ratios.R

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2012-01-01_2016-12-31_saved_2022-05-11.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2013-01-01_2017-12-31_saved_2022-05-11.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2014-01-01_2018-12-31_saved_2022-05-11.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]

dat$interest_by_country$hits[dat$interest_by_country$location=="Guatemala"]/dat$interest_by_country$hits[dat$interest_by_country$location=="Argentina"]

##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-11.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]


##
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2012-01-01_2016-12-31_saved_2022-05-12.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]

##
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2013-01-01_2017-12-31_saved_2022-05-12.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]

##
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2014-01-01_2018-12-31_saved_2022-05-12.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]

## 
dat <- readRDS("Data_output_global_search_lists_lowsearch/gsearch_global_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-12.RDS")

dat$interest_by_country$hits[dat$interest_by_country$location=="Uganda"]/dat$interest_by_country$hits[dat$interest_by_country$location=="United States"]



##
dat <- readRDS("Data_output_global_search_lists/gsearch_global_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-11.RDS")

as.numeric(dat$interest_by_country$hits[dat$interest_by_country$location=="Guatemala"])/as.numeric(dat$interest_by_country$hits[dat$interest_by_country$location=="Argentina"])

