#' ---
#' title: "Analysis of Wenker sentence 38"
#' author: "Stephanie Winter & Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("sentence38.R")

# load necessary libraries and ad-hoc functions
source("preamble.R")

#' Word order

namesOrder <- "alle die leute heute X sind heute die leute X alle X leute heute draussen aufm feld draussen und tun zu mähen aufm feld draussen"

dataOrder <- getAlignSyntax("../data/WS38/WS38_1syntax.txt", 7, names = namesOrder)

# make into syntactically interesting features by using recoding profile
# write.recoding(dataOrder, file = "../data/WS38/tmp.yml", attr = list( c(3, 4), c(1,3,9,11,13) ,c(7,11,14), c(15, 18, 25), c(19, 21), 20, c(17, 24)))
order <- recode(dataOrder, "../data/WS38/syntaxRecoding.yml")

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
