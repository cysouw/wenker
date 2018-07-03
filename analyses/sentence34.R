#' ---
#' title: "Analysis of Wenker sentence 34"
#' author: "Erdal Ayan & Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("sentence34.R")

# load necessary libraries and ad-hoc functions
source("preamble.R")

#' Word order

namesOrder <- "er das große wort das ist ihm wohl kommt vom Herzen gekommen weg"

dataOrder <- getAlignSyntax("../data/WS34/WS34_1syntax.txt", 7, names = namesOrder)

# make into syntactically interesting features by using recoding profile
# write.recoding(dataOrder, file = "../data/WS34/tmp.yml", attr = list(1, 4, 8, c(6, 9, 12)))
order <- recode(dataOrder, "../data/WS34/syntaxRecoding.yml")

# plot ordering parameters	
sapply(colnames(order), function(x) {plotSingle(feature = order[,x], title = x)}) -> silent

#' show Session Info
sessionInfo()
