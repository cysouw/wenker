#' ---
#' title: "Analysis of Wenker sentence 38"
#' author: "Canan Sertkaya & Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("sentence23.R")

# load necessary libraries and ad-hoc functions
source("preamble.R")

#' Word order

namesOrder <- "jetzt müde wir sind sehr müde geworden und wir/uns/es haben/sind auch ein großen dürstet durstig Durst haben wir/uns auch geworden/gekriegt"

dataOrder <- getAlignSyntax("../data/WS23/WS23_1syntax.txt", 7, names = namesOrder)

# make into syntactically interesting features by using recoding profile
# write.recoding(dataOrder, file = "../data/WS23/tmp.yml", attr = list(1,2,5,13,c(11,19),c(10,16,17),c(10,12,16,17),c(14,15,16)))
order <- recode(dataOrder, "../data/WS23/syntaxRecoding.yml")

# plot ordering parameters	
sapply(colnames(order), function(x) {plotSingle(feature = order[,x], title = x)}) -> silent

#' show Session Info
sessionInfo()
