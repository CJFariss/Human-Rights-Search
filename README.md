# Human-Rights-Search

## Introduction
Project files for an article titled: "The Search for Human Rights: A Global Analysis Using Google Data", conditionally accepted at *American Political Science Review*.

## Article Abstract
Critics of the human rights discourse claim that it is losing global resonance, while supporters counter that the language of human rights remains politically relevant. In this article, we address this question using aggregated data from Google search trends. Specifically, we test two divergent accounts of why human rights might appeal in a population. The top-down model predicts that level of nationwide interest in human rights is attributable mainly to external factors like NGO campaigns, where the bottom-up model highlights the importance of internal factors like economic growth and repressive violence. In testing these models, this article confronts high-level debates over whether the human rights discourse is best conceived as a tool of outside imposition or of local resistance. We find more evidence for the latter: not only is interest in human rights more concentrated in the Global South, the discourse is most resonant where people face government violence.

## Replication and Reproduction File Descriptions

We have created this complete Github repository with all the R code and datasets necessary to replicate or reproduce all reported data analyses presented in the main manuscript and this appendix. Every single step in our data processing and analysis sequence is available in this repository such that all procedures and results are fully accessible to any interested reader.

When pulling datasets from certain APIs, specifically from [trends.google.com](trends.google.com) (the primary data source), we have saved the resulting datasets and the code that pulls the data. This will allow interested readers to reproduce the reported analyses with the same data we used or reporduce the search term datasets themselves. 

### Folder Descriptions 

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
- [Rcode_ACLED_analysis](./Rcode_ACLED_analysis):
- [Rcode_Amnesty_article_coverage](./Rcode_Amnesty_article_coverage):
- [Rcode_Descriptive_Stats](./Rcode_Descriptive_Stats):
- [Rcode_Global_Survey_analysis](./Rcode_Global_Survey_analysis):
- [Rcode_gtrends_related_topics](./Rcode_gtrends_related_topics):
- [Rcode_HR_treaty](./Rcode_HR_treaty):
- [Rcode_Human_Rights_google_ngrams](./Rcode_Human_Rights_google_ngrams):
- [Rcode_Human_Rights_google_search_country](./Rcode_Human_Rights_google_search_country):
- [Rcode_Human_Rights_google_search_global](./Rcode_Human_Rights_google_search_global):
- [Rcode_Human_Rights_google_search_Maps](./Rcode_Human_Rights_google_search_Maps):
- [Rcode_min_max_examples](./Rcode_min_max_examples):
- [Rcode_Search_engine_use_analysis](./Rcode_Search_engine_use_analysis):
- [Rcode_WDI](./Rcode_WDI):
- [Rplot_Related_Topics](./Rplot_Related_Topics):
- [Rplot_search_rate_examples](./Rplot_search_rate_examples):
- [Rplots](./Rplots):
- [Rplots_coefplots](./Rplots_coefplots):
- [Rplots_country_search_ranks](./Rplots_country_search_ranks):
- [Rplots_survey_data](./Rplots_survey_data):
