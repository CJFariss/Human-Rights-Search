# Human-Rights-Search

## Introduction
Project files for an article titled: "The Search for Human Rights: A Global Analysis Using Google Data", conditionally accepted at *American Political Science Review*.

## Article Abstract
Critics of the human rights discourse claim that it is losing global resonance, while supporters counter that the language of human rights remains politically relevant. In this article, we address this question using aggregated data from Google search trends. Specifically, we test two divergent accounts of why human rights might appeal in a population. The top-down model predicts that level of nationwide interest in human rights is attributable mainly to external factors like NGO campaigns, where the bottom-up model highlights the importance of internal factors like economic growth and repressive violence. In testing these models, this article confronts high-level debates over whether the human rights discourse is best conceived as a tool of outside imposition or of local resistance. We find more evidence for the latter: not only is interest in human rights more concentrated in the Global South, the discourse is most resonant where people face government violence.

## Replication and Reproduction File Descriptions

We have created this complete Github repository with all the R code and datasets necessary to replicate or reproduce all reported data analyses presented in the main manuscript and this appendix. Every single step in our data processing and analysis sequence is available in this repository such that all procedures and results are fully accessible to any interested reader.


### Folder Descriptions 
The primary datas source we use in this project is serach term rates from [trends.google.com](trends.google.com). We access the data available at this site through the API using the R package [gtrendsR](https://cran.r-project.org/web/packages/gtrendsR/gtrendsR.pdf), using the the gtrends() function. 

Many of the folders below contain search term datasets or R files (.RDS files) necessary to create these datasets. When pulling datasets from the google trends APIs, specifically from [trends.google.com](trends.google.com) (the primary data source), we have saved the resulting datasets and the code that pulls the data. This will allow interested readers to reproduce the reported analyses with the same data we used or reproduce the search term datasets themselves. 
  
Note that lowsearch is in reference to the low_search_volume argument in the gtrends() function.

- [Data_Input](./Data_input): contains datasets obtained from sources outside of our project code
- [Data_Ouput](./Data_output): contains datasets produced or updated by our project code
- [Data_output_global_search_lists](./Data_output_global_search_lists): RDS files that contain list objects with google trends search results for all countries in a given time period for a specific search term (lowsearch is off or set to FALSE)
- [Data_output_global_search_lists_lowsearch](./Data_output_global_search_lists_lowsearch): RDS files that contain list objects with google trends search results for all countries in a given time period for a specific search term (lowsearch is on or set to TRUE) 
- [Data_output_location_search_lists](./Data_output_location_search_lists): RDS files that contain list objects with google trends search results for weeks for each country in a given time period for a specific search term (lowsearch is off or set to FALSE)
- [Data_output_location_search_lists_lowsearch](./Data_output_location_search_lists_lowsearch): RDS files that contain list objects with google trends search results for weeks for each country in a given time period for a specific search term (lowsearch is on or set to TRUE)
- [Data_output_search_cy_datasets](./Data_output_search_cy_datasets): csv dataset files for each search term, time period combination (search terms are 'human rights' in several languages) 
- [Data_output_search_cy_datasets_lowsearch](./Data_output_search_cy_datasets_lowsearch): csv dataset files for each search term, time period combination (search terms are 'human rights' in several languages)
- [Data_output_search_cy_datasets_lowsearch_AI](./Data_output_search_cy_datasets_lowsearch_AI): csv dataset files for each search term, time period combination (search terms are 'Amnesty International' in several languages) 
- [Data_output_search_cy_topic_datasets](./Data_output_search_cy_topic_datasets): csv dataset files for each search term, time period combination (search terms are 'human rights' using the internal google trends topic model)
- [Rcode_ACLED_analysis](./Rcode_ACLED_analysis): Rcode to pull [ACLED](https://acleddata.com/) data for weekly level analysis
- [Rcode_Amnesty_article_coverage](./Rcode_Amnesty_article_coverage): Rcode and files to scrape Amnesty report files from the [amnesty.org](amnesty.org) website
- [Rcode_Descriptive_Stats](./Rcode_Descriptive_Stats): Rcode that generates descriptive statistics
- [Rcode_Global_Survey_analysis](./Rcode_Global_Survey_analysis): Rcode for analyzing several surveys ([World Values Survey](https://www.worldvaluessurvey.org/wvs.jsp), [Latin American Public Opinion Project](https://www.vanderbilt.edu/lapop/), [Afrobarometer](https://www.afrobarometer.org/about/), and [Open Global Rights](https://www.openglobalrights.org/))
- [Rcode_gtrends_related_topics](./Rcode_gtrends_related_topics): Rcode to create co-occuring topics data and Rplots
- [Rcode_HR_treaty](./Rcode_HR_treaty): Rcode to update country-year UN human rights treaty dataset 
- [Rcode_Human_Rights_google_ngrams](./Rcode_Human_Rights_google_ngrams): Rcode for analyzing [google ngrams data](https://books.google.com/ngrams)
- [Rcode_Human_Rights_google_search_country](./Rcode_Human_Rights_google_search_country): country-year analysis files
- [Rcode_Human_Rights_google_search_global](./Rcode_Human_Rights_google_search_global): global analysis files 
- [Rcode_Human_Rights_google_search_Maps](./Rcode_Human_Rights_google_search_Maps): Rcode for generating global maps of relative search rates across countries
- [Rcode_min_max_examples](./Rcode_min_max_examples): Rcode examples using the min-max transformation
- [Rcode_Search_engine_use_analysis](./Rcode_Search_engine_use_analysis): Rcode for analyzing variation in search engine use across regions and countries
- [Rcode_WDI](./Rcode_WDI): Rcode for pulling World Development Indicators directly from the WDI API
- [Rplot_Related_Topics](./Rplot_Related_Topics): Rplot graphs of related topics and within-country regions for all country-language search terms
- [Rplot_search_rate_examples](./Rplot_search_rate_examples): Rplot graphs with relative search rate examples 
- [Rplots](./Rplots): Rplot graphs (all the other Rplots)
- [Rplots_coefplots](./Rplots_coefplots): Rplot graphs coefficient plots from regression models
- [Rplots_country_search_ranks](./Rplots_country_search_ranks): Rplot graphs of within-country weekly time series data, ranked by overall country search rates (all langugage groups and topics)
- [Rplots_survey_data](./Rplots_survey_data): Rplot graphs from the analyses of the global survey datasets

### Analysis Information
There are many folders that contain many files. In an effort to make the production of each result presented in our article as transparent as possible, we describe the resources necessary (contained in the project folders described above) to reproduce each figure or table in the main article and by section in the supplementary appendix.

#### Article Figure 1: Pairwise comparisons of relative search term rates
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_search_trends_paired_comparisons.R](./Rcode_Human_Rights_google_search_global/google_search_trends_paired_comparisons.R)

#### Article Figure 2: Global weekly search rates from Google Trends for five language groups (2015- 2019)
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_global_HR_yearly_trends_2015_2019_weeks.R](./Rcode_Human_Rights_google_search_global/google_global_HR_yearly_trends_2015_2019_weeks.R)

#### Article Figure 3: Rate of google searches for “human rights” in the english language across countries
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_HR_language_maps.R](./Rcode_Human_Rights_google_search_global/google_HR_language_maps.R)

#### Article Figure 4: Rate of google searches for “human rights” in the English language for country-weeks from 2015-2019
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_data_country_Rplot_function.R](./Rcode_Human_Rights_google_search_country/google_search_data_country_Rplot_function.R)

#### Article Figure 5: Rate of google searches for “derechos humanos” in the Spanish language across countries
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_HR_language_maps.R](./Rcode_Human_Rights_google_search_global/google_HR_language_maps.R)
  
#### Article Figure 6: Rate of google searches for “derechos humanos” in the Spanish language for country-weeks from 2015-2019
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_data_country_Rplot_function.R](./Rcode_Human_Rights_google_search_country/google_search_data_country_Rplot_function.R)

#### Article Figure 7: Results of Regression Models with Language Fixed Effects
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis.R)

#### Article Figure 8: Human rights survey validation
- [Rcode_Global_Survey_analysis/](./Rcode_Global_Survey_analysis)
  - [LAPOP_analysis_weighted_means.R](./Rcode_Global_Survey_analysis/LAPOP_analysis_weighted_means.R)
  - [WorldValuesSurvey_analysis_weighted.R](./Rcode_Global_Survey_analysis/WorldValuesSurvey_analysis_weighted_means.R)

#### Article Figure 9: Google search proportions
- [Rcode_Search_engine_use_analysis/](./Rcode_Search_engine_use_analysis)
  - [Rcode_Search_engine_use_analysis.R](./Rcode_Search_engine_use_analysis/Search_engine_use_analysis.R)

#### Article Figure 10: Related co-occurring search queries (upper left panel), search topics (upper right panel) for Guatemala, and relative search rates for regions (lower left panel) and cities (lower right panel)
- [Rcode_gtrends_related_topics/](./Rcode_gtrends_related_topics)
  - [gtrends_related_topics.R](./Rcode_gtrends_related_topics/gtrends_related_topics.R)

#### Article Table 1: 
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis.R)




  



