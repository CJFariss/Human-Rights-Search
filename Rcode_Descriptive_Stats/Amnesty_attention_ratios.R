

## load necessary libraries 
## change groundhog to TRUE to install original versions of libraries from May-2022
source("groundhog_library_func.R")
groundhog_library_func(groundhog=FALSE, regular_install=FALSE)

data <- try(read.csv("Data_input/HumanRightsProtectionScores_v4.01_amnesty_report_count_v2.csv"))

amnesty_cy <- data.frame(table(amnesty_attention$CCODE, amnesty_attention$YEAR))
names(amnesty_cy) <- c("CCODE", "YEAR", "amnesty_attention_count")
head(amnesty_cy)

WDI <- read.csv("Data_input/WDI_data_2012_2019_saved_2022-05-23.csv")

data <- merge(data, amnesty_cy, by.x=c("COW", "YEAR"), by.y=c("CCODE", "YEAR"), all.x=TRUE, all.y=FALSE)

data$ISO <- countrycode(data$COW, origin="cown", destination="iso2c")

data <- merge(data, WDI, by.x=c("ISO", "YEAR"), by.y=c("iso2c", "year"), all.x=TRUE, all.y=FALSE)


report_count <- data.frame(xtabs(amnesty_attention_count ~ COW, data=subset(data, YEAR>=2015)))
report_count[order(report_count$Freq, decreasing=TRUE),]

report_count$COUNTRY <- countrycode(report_count$COW, origin="cown", destination="country.name")

report_count[order(report_count$Freq, decreasing=TRUE),]


total_pop <- data.frame(xtabs(Population ~ COW, data=subset(data, YEAR>=2015))/5)

#total_pop$Freq <- total_pop$Freq/median(total_pop$Freq)

report_count_2 <- merge(report_count, total_pop, by="COW")


report_count_2$amnesty_attention_rate <- 100000*(report_count_2$Freq.x / report_count_2$Freq.y)

cor(report_count_2$Freq.x, report_count_2$amnesty_attention_rate, method="spearman")
cor(report_count_2$Freq.x, report_count_2$amnesty_attention_rate, method="spearman")


report_count_2[order(report_count_2$amnesty_attention_rate, decreasing=TRUE),]
