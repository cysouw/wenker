#' ---
#' title: "Analysis of Wenker sentence 38"
#' author: "Sertkaya & Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("sentence23.R")

# load necessary libraries and ad-hoc functions
source("preamble.R")

#' Word order

namesOrder <- "jetzt müde wir sind sehr müde geworden und wir haben auch ein sehr durstet durstig durst haben uns sehr"

dataOrder <- getAlignSyntax("../data/WS23/WS23_1syntax.txt", 7, names = namesOrder)

# make into syntactically interesting features by using recoding profile
# write.recoding(dataOrder, file = "../data/WS23/tmp.yml", attr = list( 1, c(10,16,17)))
order <- recode(dataOrder, "../data/WS23/tmp.yml")

# plot ordering parameters	

titlesOrder <- list(
	  Vorfeld = "Vorfeldbesetzung"
	, Mittelfeld = "Mittelfeldbesetzung"
	, alle.Leute = "Position \'alle\'"
	, draussen = "Position \'draussen\'"
	, zu.mähen = "Infinitiv"
	, tun.mähen = "Hilfsverb"
	, feld = "Position \'Feld\'"
)


sapply(seq_along(titlesOrder), function(x) {
	plotSingle(order[,names(titlesOrder)[x]], titlesOrder[[x]])
	}) -> silent


#' show Session Info
sessionInfo()
