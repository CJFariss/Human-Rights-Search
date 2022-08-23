## NOTE: modify this file with your own email and ACLED key and save it as "acled_data_out_function_example.R"


## acled_data_out_function.R
library(acled.api)


## the acled_data_out() function is defined with user specific info which is not provided 
## signup for credentials here: https://acleddata.com/#/dashboard
acled_data_out_function <- function(youremail="", key="", acled_country_name, start_date, end_date){
  acled.api(
    email.address = email,
    access.key = key,
    country = acled_country_name,
    start.date = start_date,
    end.date = end_date
  )
}
