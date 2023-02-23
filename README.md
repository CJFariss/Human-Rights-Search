# Human-Rights-Search

## Introduction
Project files for an article titled: "The Search for Human Rights: A Global Analysis Using Google Data", conditionally accepted at *American Political Science Review*. The files in this reproduction archive exist here: https://github.com/CJFariss/Human-Rights-Search; and a static version exists at the APSR dataverse archive here: https://dataverse.harvard.edu/dataverse/the_review. The dataverse citation is as follows:

Dancy, Geoff; Fariss, Christopher J., 2022, "Replication Data for: The Global Resonance of Human Rights: What Google Trends Can Tell Us", https://doi.org/10.7910/DVN/AV0CMJ, Harvard Dataverse

Preprints of the article and appendix files are available at the Open Science Foundation here https://osf.io/78c5z/.

## Article Abstract
Where is the human rights discourse most resonant? We use aggregated cross-national Google search data to test two divergent accounts of why human rights appeal to some populations but not others. The top-down model predicts that nationwide interest in human rights is attributable mainly to external factors like foreign direct investment, transnational NGO campaigns, or international legalization, where the bottom-up model highlights the importance of internal factors like economic growth and persistent repression. We find more evidence for the latter model: not only is interest in human rights more concentrated in the Global South, the discourse is most resonant where people face regular violence at the hands of their home government. In drawing these inferences, this article confronts high-level debates over whether human rights will remain relevant in the future, and whether the discourse still animates counter-hegemonic modes of resistance. These answer to both questions, our research suggests, is “yes.”

## Replication and Reproduction File Descriptions

We have created this complete Github repository with all the R code and datasets necessary to replicate or reproduce all reported data analyses presented in the main manuscript and the supplementary appendix. Every single step in our data processing and analysis sequence is available in this repository, such that all procedures and results are fully accessible to any interested reader.

Note about the supplementary appendix: There are two versions of the supplmentary appendix. Both versions are identical with respect to the information contained in the first 25 pages of each document. The 25 page version does not included all tables. An extended, archive-only appendix located at the Github repository (https://github.com/CJFariss/Human-Rights-Search) and Dataverse repository (https://doi.org/10.7910/DVN/AV0CMJ) contains all tables that correspond to coefficient plots in the 25 page supplementary appendix. 

- [Supplementary_Appendices](./Supplementary_Appendices): contains both versions of the Supplementary Appendix document.

### Folder Descriptions 
The primary data source we use in this project is search term rates from [trends.google.com](trends.google.com). We access the data available at this site through the API using the R package [gtrendsR](https://cran.r-project.org/web/packages/gtrendsR/gtrendsR.pdf) and its gtrends() function. 

Many of the folders below contain search term datasets or R files (.RDS files) necessary to create these datasets. When pulling datasets from the google trends APIs, specifically from [trends.google.com](trends.google.com) (the primary data source), we have saved the resulting datasets and the code that pulls the data. This will allow interested readers to reproduce the reported analyses with the same data we used, but readers can also reproduce the search term datasets themselves. 
  
Note that lowsearch is in reference to the low_search_volume argument in the gtrends() function.

- [Data_Input](./Data_input): contains datasets obtained from sources outside of our project code
- [Data_Ouput](./Data_output): contains datasets produced or updated by our project code
- [Data_output_global_search_lists](./Data_output_global_search_lists): RDS files that contain list objects with google trends search results for all countries within a five-year range for a specific search term (lowsearch is off or set to FALSE)
- [Data_output_global_search_lists_lowsearch](./Data_output_global_search_lists_lowsearch): RDS files that contain list objects with google trends search results for all countries within a five-year range for a specific search term (lowsearch is on or set to TRUE) 
- [Data_output_location_search_lists](./Data_output_location_search_lists): RDS files that contain list objects with google trends search results for country-weeks within a five-year range for a specific search term (lowsearch is off or set to FALSE)
- [Data_output_location_search_lists_lowsearch](./Data_output_location_search_lists_lowsearch): RDS files that contain list objects with google trends search results for country-weeks within a five-year range for a specific search term (lowsearch is on or set to TRUE)
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
- [Supplementary_Appendices](./Supplementary_Appendices): contains both versions of the Supplementary Appendix document.
- [Tex Tables](./Tex_Tables): contains all latex tablular output.

### Analysis Information
There are many folders that contain many files. In an effort to make the production of each result presented in our article as transparent as possible, we describe the resources necessary (contained in the project folders described above) to reproduce each figure or table in the main article and by section in the supplementary appendix.

[groundhog_library_func.R](./groundhog_library_func.R) is a function that loads all the necessary R libraries. There are three options in the function: (1) load libraries using the version from when the scripts were originally run, (2) load libraries using their most recent versions, or (3) install the current version of all the libraries. This function will hopefully ensure that all the results reported in the article and supplementary appendix can always be reproduced using the original function versions, even if any updated functions produce dissimilar results in the future.

### Main Article Files

#### Article Figure 1: Pairwise comparisons of relative search term rates
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_search_trends_paired_comparisons.R](./Rcode_Human_Rights_google_search_global/google_search_trends_paired_comparisons.R)
- [Rplots/](./Rplots)
  - [Google_search_term_pairs_shortlist.pdf](./Rplots/Google_search_term_pairs_shortlist.pdf)

#### Article Figure 2: Global weekly search rates from Google Trends for five language groups (2015- 2019)
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_global_HR_yearly_trends_2015_2019_weeks.R](./Rcode_Human_Rights_google_search_global/google_global_HR_yearly_trends_2015_2019_weeks.R)
- [Rplots/](./Rplots)
  - [Global_search_hits_mean_CI_2015_2019.pdf](./Rplots/Global_search_hits_mean_CI_2015_2019.pdf)

#### Article Figure 3: Map of Google search rates for “human rights” in the English language (also for other language groups, Github only)
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_HR_language_maps.R](./Rcode_Human_Rights_google_search_Maps/google_HR_language_maps.R)
- [Rplots/](./Rplots)
  - [Maps_Human_Rights_language_groups.pdf](./Rplots/Maps_Human_Rights_language_groups.pdf)

#### Article Figure 4: Rate of Google searches for “human rights” in the English language for country-weeks from 2015-2019
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_data_country_Rplot_function.R](./Rcode_Human_Rights_google_search_country/google_search_data_country_Rplots_function.R)
- [Rplots_country_search_ranks/](./Rplots_country_search_ranks)
  - [human_rights_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf](./Rplots_country_search_ranks/human_rights_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf)

#### Article Figure 5: Map of Google search rates for “derechos humanos” in the Spanish language (also for other language groups, Github only)
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_HR_language_maps.R](./Rcode_Human_Rights_google_search_Maps/google_HR_language_maps.R)
- [Rplots/](./Rplots)
  - [Maps_Human_Rights_language_groups.pdf](./Rplots/Maps_Human_Rights_language_groups.pdf)

#### Article Figure 6: Rate of google searches for “derechos humanos” in the Spanish language for country-weeks from 2015-2019
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_data_country_Rplot_function.R](./Rcode_Human_Rights_google_search_country/google_search_data_country_Rplots_function.R)
- [Rplots_country_search_ranks/](./Rplots_country_search_ranks)
  - [derechos_humanos_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf](./Rplots_country_search_ranks/derechos_humanos_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf)

#### Article Figure 7: Coefficient plot of results from regression models with language fixed effects
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_amnesty_amnesty_report_rate_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2015_2019_Rplot.pdf)

#### Article Figure 8: Human rights survey validation
- [Rcode_Global_Survey_analysis/](./Rcode_Global_Survey_analysis)
  - [LAPOP_analysis_weighted_means.R](./Rcode_Global_Survey_analysis/LAPOP_analysis_weighted_means.R)
  - [WorldValuesSurvey_analysis_weighted.R](./Rcode_Global_Survey_analysis/WorldValuesSurvey_analysis_weighted_means.R)
- [Rplots_survey_data/](./Rplots_survey_data)
  - [LAPOP_country_plots.pdf](./Rplots_survey_data/LAPOP_country_plots.pdf)
  - [WVS_LA_country_plots.pdf](./Rplots_survey_data/WVS_LA_country_plots.pdf)

#### Article Figure 9: Google search proportions
- [Rcode_Search_engine_use_analysis/](./Rcode_Search_engine_use_analysis)
  - [Rcode_Search_engine_use_analysis.R](./Rcode_Search_engine_use_analysis/Search_engine_use_analysis.R)
- [Rplots/](./Rplots)
  - [Rplot_search_months.pdf](./Rplots/Rplot_search_months.pdf)
  
#### Article Figure 10: Related co-occurring search queries and search topics for Guatemala (top row) and relative search rates by city and region (bottom row)
- [Rcode_gtrends_related_topics/](./Rcode_gtrends_related_topics)
  - [gtrends_related_topics.R](./Rcode_gtrends_related_topics/gtrends_related_topics.R)
- [Rplot_Related_Topics/](./Rplot_Related_Topics)
  - [related_topics_gsearch_location_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-12.pdf](./Rplot_Related_Topics/related_topics_gsearch_location_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-12.pdf)

#### Article Table 1: Country-year regression analysis with language fixed effects 
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis.R)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_amnesty_report_rate_2015_2019.tex](./Tex_tables/main_results_lowsearch_amnesty_report_rate_2015_2019.tex)

### Supplementary Appendix Files

#### Supplementary Appendix Section A: Min-max normalization of Google Trends search data
- [Rcode_min_max_examples/](./Rcode_min_max_examples/)
  - [Rcode_min_max_examples/Rplot_search_rate_examples.pdf](./Rplot_search_rate_examples/min_max_transformation_example.R)
- [Rplot_search_rate_examples/](./Rplot_search_rate_examples)
  - [Rplot_search_rate_examples/Rplot_search_rate_examples.pdf](./Rplot_search_rate_examples/Rplot_search_rate_examples.pdf)

#### Supplementary Appendix Section B: Variable definitions, references, and summary statistics
- [Rcode_Descriptive_Stats/](./Rcode_Descriptive_Stats)
  - [Descriptive_Stats.R](./Rcode_Descriptive_Stats/Descriptive_Stats.R)
- [Tex_tables/](./Tex_tables/)
  - [stats_2015_2019.tex](./Tex_tables/stats_2015_2019.tex)
  - [stats_2014_2018.tex](./Tex_tables/stats_2014_2018.tex)
  - [stats_2013_2017.tex](./Tex_tables/stats_2013_2017.tex)
  - [stats_2012_2016.tex](./Tex_tables/stats_2012_2016.tex)
  - [cors_2015_2019.tex](./Tex_tables/cors_2015_2019.tex)
  - [cors_2014_2018.tex](./Tex_tables/cors_2014_2018.tex)
  - [cors_2013_2017.tex](./Tex_tables/cors_2013_2017.tex)
  - [cors_2012_2016.tex](./Tex_tables/cors_2012_2016.tex)
  - [cor_search_theta_2012_2016.tex](./Tex_tables/cor_search_theta_2012_2016.tex)
  - [cor_search_amnesty_attention_count_2012_2016.tex](./Tex_tables/cor_search_amnesty_attention_count_2012_2016.tex)
  - [cor_search_amnesty_attention_rate_2012_2016.tex](./Tex_tables/cor_search_amnesty_attention_rate_2012_2016.tex)

#### Supplementary Appendix Section C: Global search rates
##### C.1 Global Pairwise Search Rates
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_search_trends_paired_comparisons.R](./Rcode_Human_Rights_google_search_global/google_search_trends_paired_comparisons.R)
- [Rplots/](./Rplots)
  - [Google_search_term_pairs.pdf](./Rplots/Google_search_term_pairs.pdf)
  - [Google_topic_pairs.pdf](./Rplots/Google_topic_pairs.pdf)
  
##### C.2 Global search rates by language group
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_global_HR_yearly_trends_2013_2017_weeks.R](./Rcode_Human_Rights_google_search_global/google_global_HR_yearly_trends_2013_2017_weeks.R)
  - [google_global_HR_yearly_trends_2014_2018_weeks.R](./Rcode_Human_Rights_google_search_global/google_global_HR_yearly_trends_2014_2018_weeks.R)
  - [google_global_HR_yearly_trends_2015_2019_weeks.R](./Rcode_Human_Rights_google_search_global/google_global_HR_yearly_trends_2015_2019_weeks.R)
  - [google_global_HR_yearly_trends_2016_2020_weeks.R](./Rcode_Human_Rights_google_search_global/google_global_HR_yearly_trends_2016_2020_weeks.R)
  - [google_global_HR_yearly_trends_2017_2021_weeks.R](./Rcode_Human_Rights_google_search_global/google_global_HR_yearly_trends_2017_2021_weeks.R)
- [Rplots/](./Rplots)
  - [Global_search_hits_mean_CI_2013_2017.pdf](./Rplots/Global_search_hits_mean_CI_2013_2017.pdf)
  - [Global_search_hits_mean_CI_2014_2018.pdf](./Rplots/Global_search_hits_mean_CI_2014_2018.pdf)
  - [Global_search_hits_mean_CI_2015_2019.pdf](./Rplots/Global_search_hits_mean_CI_2015_2019.pdf)
  - [Global_search_hits_mean_CI_2016_2020.pdf](./Rplots/Global_search_hits_mean_CI_2016_2020.pdf)
  - [Global_search_hits_mean_CI_2017_2021.pdf](./Rplots/Global_search_hits_mean_CI_2017_2021.pdf)

#### Supplementary Appendix Section D: Examples of related searches
- [Rcode_gtrends_related_topics/](./Rcode_gtrends_related_topics)
  - [gtrends_related_topics.R](./Rcode_gtrends_related_topics/gtrends_related_topics.R)
- [Rplot_Related_Topics/](./Rplot_Related_Topics)
  - [related_topics_gsearch_location_data_lists_human_rights_2015-01-01_2019-12-31_saved_2022-05-12.pdf](./Rplot_Related_Topics/related_topics_gsearch_location_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-12.pdf)
  - [related_topics_gsearch_location_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-12.pdf](./Rplot_Related_Topics/related_topics_gsearch_location_data_lists_derechos_humanos_2015-01-01_2019-12-31_saved_2022-05-12.pdf)
  - [related_topics_gsearch_location_data_lists_direitos_humanos_2015-01-01_2019-12-31_saved_2022-05-12.pdf](./Rplot_Related_Topics/related_topics_gsearch_location_data_lists_direitos_humanos_2015-01-01_2019-12-31_saved_2022-05-12.pdf)

#### Supplementary Appendix Section E: Mapping the geographic distribution of Google searching
- [Rcode_Human_Rights_google_search_global/](./Rcode_Human_Rights_google_search_global)
  - [google_HR_language_maps.R](./Rcode_Human_Rights_google_search_Maps/google_HR_language_maps.R)
  - [Maps_Human_Rights_language_groups.pdf](./Rplots/Maps_Human_Rights_language_groups.pdf)
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_data_country_Rplot_function.R](./Rcode_Human_Rights_google_search_country/google_search_data_country_Rplots_function.R)
-[Rplots_country_search_ranks/](./Rplots_country_search_ranks)
  - [human_rights_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf](./Rplots_country_search_ranks/human_rights_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf)
  - [derechos_humanos_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf](./Rplots_country_search_ranks/derechos_humanos_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf)
  - [direitos_humanos_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf](./Rplots_country_search_ranks/direitos_humanos_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf)
  - [droit_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf](./Rplots_country_search_ranks/droit_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf)
  - [huquq_alansan_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf](./Rplots_country_search_ranks/huquq_alansan_country_week_time_series_lowsearch_2015-01-01_2019-12-31.pdf)
  
#### Supplementary Appendix Section F: Variation in term usage for French speakers
- [Rcode_Human_Rights_google_search_Maps/](./Rcode_Human_Rights_google_search_Maps/)
  - [google_HR_french_validation_maps.R](./Rcode_Human_Rights_google_search_Maps/google_HR_french_validation_maps.R)
- [Rplots/](./Rplots)
  - [Maps_French_validation.pdf](./Rplots/Maps_French_validation.pdf)

#### Supplementary Appendix Section G: Searching for “human rights” and “rights” in English
- [Rcode_Human_Rights_google_search_Maps/](./Rcode_Human_Rights_google_search_Maps/)
  - [google_HR_english_validation_maps.R](./Rcode_Human_Rights_google_search_Maps/google_HR_english_validation_maps.R)
- [Rplots/](./Rplots)
  - [Maps_English_validation.pdf](./Rplots/Maps_English_validation.pdf)

#### Supplementary Appendix Section H: Searching for “Amnesty International”
- [Rcode_Human_Rights_google_search_Maps/](./Rcode_Human_Rights_google_search_Maps/)
  - [google_Amnesty_International_search_maps.R](./Rcode_Human_Rights_google_search_Maps/google_Amnesty_International_search_maps.R)
- [Rplots/](./Rplots)
  - [Maps_Amnesty_International_search.pdf](./Rplots/Maps_Amnesty_International_search.pdf)

#### Supplementary Appendix Section I: Validation: Google searches for “malaria”  
- [Rcode_Human_Rights_google_search_Maps/](./Rcode_Human_Rights_google_search_Maps/)
  - [google_malaria_search_validation.R](./Rcode_Human_Rights_google_search_Maps/google_malaria_search_validation.R)
- [Rplots/](./Rplots)
  - [Maps_google_malaria.pdf](./Rplots/Maps_google_malaria.pdf)

#### Supplementary Appendix Section J: Validation: Google search volumes vs. competitor search volumes
- [Rcode_Search_engine_use_analysis/](./Rcode_Search_engine_use_analysis)
  - [Rcode_Search_engine_use_analysis.R](./Rcode_Search_engine_use_analysis/Search_engine_use_analysis.R)
- [Rplots/](./Rplots)
  - [Rplot_search_months.pdf](./Rplots/Rplot_search_months.pdf)

#### Supplementary Appendix Section K: Google n-grams (1800-2008)
- [Rcode_Human_Rights_google_ngrams](./Rcode_Human_Rights_google_ngrams/)
  - [google_book_ngrams.R](./Rcode_Human_Rights_google_ngrams/google_book_ngrams.R)
- [Rplots/](./Rplots)
  - [Google_book_corpus_ngram.pdf](./Rplots/Google_book_corpus_ngram.pdf)

#### Supplementary Appendix Section L: Additional regression results
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis_merges.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis_merges.R)

##### L.1 Regression models from early time periods
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_amnesty_amnesty_report_rate_2014_2018_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2014_2018_Rplot.pdf)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_amnesty_report_rate_2014_2018.tex](./Tex_tables/main_results_lowsearch_amnesty_report_rate_2014_2018.tex)

##### L.2 Regression Models with Alternative Measure of Amnesty Report (Counts)
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_amnesty_amnesty_report_count_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_2015_2019_Rplot.pdf)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_amnesty_report_count_2015_2019.tex](./Tex_tables/main_results_lowsearch_amnesty_report_count_2015_2019.tex)

##### L.3 Regression Models with Alternative Measure of Human Rights NGOs
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis_NGO_alt.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis_NGO_alt.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_NGO_rate_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_NGO_rate_2015_2019_Rplot.pdf)
  - [coefs_lowsearch_NGO_count_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_NGO_count_2015_2019_Rplot.pdf)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_NGO_rate_2015_2019.tex](./Tex_tables/main_results_lowsearch_NGO_rate_2015_2019.tex)
  - [main_results_lowsearch_NGO_rate_2015_2019.tex](./Tex_tables/main_results_lowsearch_NGO_count_2015_2019.tex)

##### L.4 Regression Models without the United States
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis_excludeUS.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis_excludeUS.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_amnesty_amnesty_report_rate_excludeUS_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_excludeUS_2015_2019_Rplot.pdf)
  - [coefs_lowsearch_amnesty_amnesty_report_count_excludeUS_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_excludeUS_2015_2019_Rplot.pdf)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_amnesty_report_rate_excludeUS_2015_2019.tex](./Tex_tables/main_results_lowsearch_amnesty_report_rate_excludeUS_2015_2019.tex)
  - [main_results_lowsearch_amnesty_report_count_excludeUS_2015_2019.tex](./Tex_tables/main_results_lowsearch_amnesty_report_count_excludeUS_2015_2019.tex)

##### L.5 Regression Models with Interaction Term between Amnesty Report Rate and Human Rights Protection Scores
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis_NGO_interaction.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis_NGO_interaction.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_amnesty_amnesty_report_rate_2015_2019_NGO_interaction_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2015_2019_NGO_interaction_Rplot.pdf)
  - [coefs_lowsearch_amnesty_amnesty_report_count_2015_2019_NGO_interaction_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_2015_2019_NGO_interaction_Rplot.pdf)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_amnesty_report_rate_2015_2019_NGO_interaction.tex](./Tex_tables/main_results_lowsearch_amnesty_report_rate_2015_2019_NGO_interaction.tex)
  - [main_results_lowsearch_amnesty_report_count_2015_2019_NGO_interaction.tex](./Tex_tables/main_results_lowsearch_amnesty_report_count_2015_2019_NGO_interaction.tex)

##### L.6 Regression Models with Interaction Term between HR Treaty Ratifications and Human Rights Protection Scores
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis_treaty_count_interaction.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis_treaty_count_interaction.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_amnesty_amnesty_report_rate_2015_2019_treaty_count_interaction_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_rate_2015_2019_treaty_count_interaction_Rplot.pdf)
  - [coefs_lowsearch_amnesty_amnesty_report_count_2015_2019_treaty_count_interaction_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_amnesty_amnesty_report_count_2015_2019_treaty_count_interaction_Rplot.pdf)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_amnesty_report_rate_2015_2019_treaty_count_interaction.tex](./Tex_tables/main_results_lowsearch_amnesty_report_rate_2015_2019_treaty_count_interaction.tex)
  - [main_results_lowsearch_amnesty_report_count_2015_2019_treaty_count_interaction.tex](./Tex_tables/main_results_lowsearch_amnesty_report_count_2015_2019_treaty_count_interaction.tex)
 
##### L.7 Google Search Models: Cross Validation using Leave-One-Out (loo) Country
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis_cross_validation.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis_cross_validation.R)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_amnesty_report_rate_cross_validation_cor.tex](./Tex_tables/main_results_lowsearch_amnesty_report_rate_cross_validation_cor.tex)
  - [main_results_lowsearch_amnesty_report_rate_cross_validation_rmse.tex](./Tex_tables/main_results_lowsearch_amnesty_report_rate_cross_validation_rmse.tex)

##### L.8 Google Search Models with other Dependent Variable: Amnesty International Search Rates
- [Rcode_Human_Rights_google_search_country/](./Rcode_Human_Rights_google_search_country)
  - [google_search_cy_analysis_AI_search.R](./Rcode_Human_Rights_google_search_country/google_search_cy_analysis_AI_search.R)
- [Rplots_coefplots/](./Rplots_coefplots)
  - [coefs_lowsearch_AI_amnesty_amnesty_report_rate_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_AI_amnesty_amnesty_report_rate_2015_2019_Rplot.pdf)
  - [coefs_lowsearch_AI_amnesty_amnesty_report_count_2015_2019_Rplot.pdf](./Rplots_coefplots/coefs_lowsearch_AI_amnesty_amnesty_report_count_2015_2019_Rplot.pdf)
- [Tex_tables/](./Tex_tables/)
  - [main_results_lowsearch_AI_amnesty_report_rate_2015_2019.tex](./Tex_tables/main_results_lowsearch_AI_amnesty_report_rate_2015_2019.tex)
  - [main_results_lowsearch_AI_amnesty_report_count_2015_2019.tex](./Tex_tables/main_results_lowsearch_AI_amnesty_report_count_2015_2019.tex)

#### Supplementary Appendix Section M: Guatemala week-level analysis
- [Rcode_Human_Rights_google_search_country/](./Rcode_ACLED_analysis)
  - [acled_foo.R](./Rcode_ACLED_analysis/acled_foo.R)
- [Rplots_acled/](./Rplots_acled)
  - [Cross_validated_predictions_Guatemala_v2.pdf](./Rplots_acled/Cross_validated_predictions_Guatemala_v2.pdf)

