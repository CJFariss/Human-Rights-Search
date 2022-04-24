## google_book_ngrams.R
##########################################################################
##
## Authors: Geoff Dancy and Christopher J. Fariss
##
## Title: "The Search for Human Rights: A Global Analysis Using Google Data"
##
## Contact Information: 
##  Geoff Dancy <gdancy@tulane.edu>
##  Christopher J. Fariss <cjf0006@gmail.com>
##  
##  Copyright (c) 2022, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
## For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
##  All rights reserved. 
##
##########################################################################
##
## This script generate Rplots based on data taken from the Google N-gram program available here: 
## https://books.google.com/ngrams
##
##########################################################################
##
## Specific Google N-gram search in English:
##https://books.google.com/ngrams/graph?content=human+rights+%2B+human+right%2Crights%2Cliberty+%2B+liberties&year_start=1800&year_end=2000&corpus=15&smoothing=3&share=&direct_url=t1%3B%2C%28human%20rights%20%2B%20human%20right%29%3B%2Cc0%3B.t1%3B%2Crights%3B%2Cc0%3B.t1%3B%2C%28liberty%20%2B%20liberties%29%3B%2Cc0
##
##########################################################################

## Do this (set to TRUE) to load libraries using the version from when the scripts were originally run
if(FALSE){
  ## load an older version of the libraries
  remotes::install_github('CredibilityLab/groundhog')
  library(groundhog)
  pkgs <- c("ngramr")
  groundhog.library(pkgs,'2022-04-19')
} else{
  ## or load the more recent version of the libraries
  install.packages("ngramr")
  library(ngramr)
}

## create graph file
pdf("Rplots/Google_book_corpus_ngram.pdf", height=8, width=8)

## generate list to store ngram data
var_data <- list()

## for plotting
exp.y <- list(expression(10^-1), expression(10^-2), expression(10^-3), expression(10^-4), expression(10^-5), expression(10^-6), expression(10^-7), expression(10^-8), expression(10^-9), expression(10^-10), expression(10^-11), expression(10^-12), expression(10^-13), expression(10^-14))

## English ngram terms
TERMS <- c("human rights + human right", "rights", "liberty + liberties")

var_data[[1]] <- ngram(TERMS[1], corpus = "eng_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "eng_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "eng_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## create dataframe to save ngram data
dat <- rbind(var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colobrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (English Corpus)", line=3.75, cex=1)



##########################################################################
##
## Specific Google N-gram search in French:
##https://books.google.com/ngrams/graph?content=droits+de+l%27homme%2Cdroits%2Clibert%C3%A9s%2Blibert%C3%A9&year_start=1800&year_end=2008&corpus=19&smoothing=3
##
##########################################################################

## generate list to store ngram data
var_data <- list()

## French ngram terms
TERMS <- c("droit de l'homme + droits de l'homme", "droits", "libertés + liberté")

var_data[[1]] <- ngram(TERMS[1], corpus = "fre_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "fre_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "fre_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## update dataframe to save ngram data
dat <- rbind(dat, var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colorbrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (French Corpus)", line=3.75, cex=1)


##########################################################################
##
## Specific Google N-gram search in Spanish:
##https://books.google.com/ngrams/graph?content=derechos+humanos+%2B+derecho+humano%2Cderechos%2Clibertad+%2B+libertades&year_start=1800&year_end=2000&corpus=21&smoothing=3
##
##########################################################################

## generate list to store ngram data
var_data <- list()

## Spanish ngram terms
TERMS <- c("derechos humanos + derecho humano", "derechos", "libertad + libertades")

var_data[[1]] <- ngram(TERMS[1], corpus = "spa_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "spa_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "spa_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## update dataframe to save ngram data
dat <- rbind(dat, var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colorbrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (Spanish Corpus)", line=3.75, cex=1)


##########################################################################
##
## Specific Google N-gram search in Russian:
##https://books.google.com/ngrams/graph?content=%D0%BF%D1%80%D0%B0%D0%B2%D0%B0+%D1%87%D0%B5%D0%BB%D0%BE%D0%B2%D0%B5%D0%BA%D0%B0%2C%D0%BF%D1%80%D0%B0%D0%B2%D0%B0%2C%D1%81%D0%B2%D0%BE%D0%B1%D0%BE%D0%B4%D0%B0&year_start=1800&year_end=2020&corpus=36&smoothing=3
##
##########################################################################

## generate list to store ngram data
var_data <- list()

## Russian ngram terms
TERMS <- c("права человека","права","свобода")

var_data[[1]] <- ngram(TERMS[1], corpus = "rus_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "rus_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "rus_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## update dataframe to save ngram data
dat <- rbind(dat, var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colorbrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (Russian Corpus)", line=3.75, cex=1)


##########################################################################
##
## Specific Google N-gram search in Italian:
##https://books.google.com/ngrams/graph?content=diritti+umani%2Clibert%C3%A0%2Cdiritti&year_start=1800&year_end=2019&corpus=33&smoothing=3&direct_url=t1%3B%2Cdiritti%20umani%3B%2Cc0%3B.t1%3B%2Clibert%C3%A0%3B%2Cc0%3B.t1%3B%2Cdiritti%3B%2Cc0
##
##########################################################################

## generate list to store ngram data
var_data <- list()

## Italian ngram terms
TERMS <- c("diritti umani","libertà","diritti")

var_data[[1]] <- ngram(TERMS[1], corpus = "ita_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "ita_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "ita_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## update dataframe to save ngram data
dat <- rbind(dat, var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colorbrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (Italian Corpus)", line=3.75, cex=1)


##########################################################################
##
## Specific Google N-gram search in German:
##https://books.google.com/ngrams/graph?content=Menschenrechte%2CFreiheit%2CRechte&year_start=1800&year_end=2019&corpus=31&smoothing=3
##
##########################################################################

## generate list to store ngram data
var_data <- list()

## German ngram terms
TERMS <- c("Menschenrechte","Freiheit","Rechte")

var_data[[1]] <- ngram(TERMS[1], corpus = "ger_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "ger_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "ger_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## update dataframe to save ngram data
dat <- rbind(dat, var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colorbrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (German Corpus)", line=3.75, cex=1)


##########################################################################
##
## Specific Google N-gram search in Hebrew:
##https://books.google.com/ngrams/graph?content=%D7%96%D7%9B%D7%95%D7%99%D7%95%D7%AA+%D7%90%D7%93%D7%9D%2C+%D7%97%D7%95%D6%B9%D7%A4%D6%B6%D7%A9+%2C%D7%96%D7%9B%D7%95%D7%99%D7%95%D7%AA&year_start=1800&year_end=2019&corpus=35&smoothing=3&direct_url=t1%3B%2C%D7%96%D7%9B%D7%95%D7%99%D7%95%D7%AA%20%D7%90%D7%93%D7%9D%3B%2Cc0%3B.t1%3B%2C%D7%97%D7%95%D7%A4%D7%A9%3B%2Cc0%3B.t1%3B%2C%D7%96%D7%9B%D7%95%D7%99%D7%95%D7%AA%3B%2Cc0#t1%3B%2C%D7%96%D7%9B%D7%95%D7%99%D7%95%D7%AA%20%D7%90%D7%93%D7%9D%3B%2Cc0%3B.t1%3B%2C%D7%97%D7%95%D7%A4%D7%A9%3B%2Cc0%3B.t1%3B%2C%D7%96%D7%9B%D7%95%D7%99%D7%95%D7%AA%3B%2Cc0
##
##########################################################################

## generate list to store ngram data
var_data <- list()

## Hebrew ngram terms
TERMS <- c()
TERMS[1] <- "זכויות אדם"
TERMS[2] <- "חוֹפֶשׁ"
TERMS[3] <- "זכויות"

var_data[[1]] <- ngram(TERMS[1], corpus = "heb_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "heb_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "heb_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## update dataframe to save ngram data
dat <- rbind(dat, var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colorbrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (Hebrew Corpus)", line=3.75, cex=1)



##########################################################################
##
## Specific Google N-gram search in Chinese:
##https://books.google.com/ngrams/graph?content=%E4%BA%BA%E6%9D%83%2C%E8%87%AA%E7%94%B1%2C%E6%9D%83%E5%88%A9&year_start=1800&year_end=2019&corpus=34&smoothing=3
##
##########################################################################

## generate list to store ngram data
var_data <- list()

## Italian ngram terms
TERMS <- c("人权","自由","权利")

var_data[[1]] <- ngram(TERMS[1], corpus = "chi_sim_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[2]] <- ngram(TERMS[2], corpus = "chi_sim_2019", year_start = 1800, year_end = 2020, smoothing = 3)
var_data[[3]] <- ngram(TERMS[3], corpus = "chi_sim_2019", year_start = 1800, year_end = 2020, smoothing = 3)

## update dataframe to save ngram data
dat <- rbind(dat, var_data[[1]], var_data[[2]], var_data[[3]])

## Color choice qualitative from colorbrewer2.org
COLOR <- c("#7570b3", "#d95f02", "#1b9e77")

## Rplot
par(mar=c(3,5,0.5,12))
plot(log10(var_data[[1]]$Frequency), type="l", ylim=c(-8,-3), col=COLOR[1],lwd=2, yaxt="n", xaxt="n", ylab="", xlab="")

#abline(h=-2, lwd=.5, col=grey(.5), lty=2)
abline(h=-3, lwd=.5, col=grey(.5), lty=2)
abline(h=-4, lwd=.5, col=grey(.5), lty=2)
abline(h=-5, lwd=.5, col=grey(.5), lty=2)
abline(h=-6, lwd=.5, col=grey(.5), lty=2)
abline(h=-7, lwd=.5, col=grey(.5), lty=2)
abline(h=-8, lwd=.5, col=grey(.5), lty=2)

for(i in 1:3){lines(log10(var_data[[i]]$Frequency), col=COLOR[i], lwd=2)}

axis(side=1, at=1:length(1800:2020), labels=rep("",length(1800:2020)))
axis(side=1, at=(seq(1800,2020,20)-1799), labels=seq(1800,2020,20), las=2)

coord <- -1:-14
for(i in 1:length(coord)){axis(side=2, at=c(coord[i]), labels=exp.y[[i]], font=1, cex.axis=1.35, padj=0, las=2)}

axis(side=4, at=c(-3,-4,-5,-6,-7, -8), labels=c("0.001", "0.0001", "0.00001", "0.000001", "0.0000001", "0.00000001"), las=2)

COLOR.TERMS <- COLOR

## add lables on the right-side axis
for(i in c(1:3)) axis(side=4, at=log10(var_data[[i]]$Frequency[nrow(var_data[[i]])]), labels=TERMS[i], col.axis=COLOR[i], las=2, tick=F)

mtext(side=2, "Freqency of N-gram from Google Books Corpus (Chinese (simplified) Corpus)", line=3.75, cex=1)


## close connection to graph file
dev.off()

## set today's date for saving files below
current_date <- as.Date(Sys.time())
current_date

## save data.frame
write.csv(dat, paste("Data_output/Google_book_corpus_ngram_", current_date, ".csv", sep=""), row.names=FALSE)


