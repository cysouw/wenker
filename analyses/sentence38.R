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

namesOrder <- "X1 X2 Die1 Leute2 heute1 es alles sind heute2 die2 Leute2"

dataOrder <- getAlignSyntax("../data/WS38/WS38_1syntax.txt", 7)

# make into syntactically interesting features by using recoding profile
# write.recoding(dataOrder, file = "../data/WS38/tmp.yml", attr = list( c(3,7,12), 5, c(9,10), 11, c(15,25), c(16,17), c(24,21,23,26,27), c(21,22,23,26,27), c(14,15,18,20,21,23,25:28)))
order <- recode(dataOrder, "../data/WS38/syntaxRecoding.yml")

# plot ordering parameters	

titlesOrder <- list(
	  tu.hinein = "Tu HINEIN"
	, die.kohle = "Article before \'Kohle\'"
	, den.ofen = "Article before \'Ofen\'"
	, alternative.verb = "Extra verb like \'tu Kohle EINLEGEN"
	, presence.etwas = "ETWAS Kohle"
	, die.milch = "Article before \'Milch\'"
	, position.kochen = "Position \'kochen\'"
	, absence.zu = "anfängt ZU kochen"
	, anfangen = "ANFÄNGT zu kochen"
	, order.verbs = "Order Auxiliary verb and \'kochen\'"
)  

sapply(seq_along(titlesOrder), function(x) {
	plotSingle(order[,names(titlesOrder)[x]], titlesOrder[[x]])
	}) -> silent


#' show Session Info
sessionInfo()
