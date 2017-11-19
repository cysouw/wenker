#' ---
#' title: "Analysis of Wenker sentence 3"
#' author: "Michael Cysouw, data preparation bei Zoia Nemidko"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("sentence3.R")

# load necessary libraries and ad-hoc functions
source("preamble.R")

#' Word order

namesOrder <- "X tu hinein etwas die kohle hinein in den ofen einlegen hinein dass wird kochen die Milch wird bald wird fängt an anfängt zu kochen fängt anfängt wird"

dataOrder <- getAlignSyntax("../data/WS3/WS3_1syntax.txt", 5, namesOrder)

# make into syntactically interesting features by using recoding profile
# write.recoding(dataOrder, file = "../data/WS3/tmp.yml", attr = list( c(3,7,12), 5, c(9,10), 11, c(15,25), c(16,17), c(24,21,23,26,27), c(21,22,23,26,27), c(14,15,18,20,21,23,25:28)))
order <- recode(dataOrder, "../data/WS3/syntaxRecoding.yml")

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

#' Lexicon

namesLexicon <- list(
	  tu = "tu leg mach schmeiß schütt stopp steck gooi wirf krieg holz gib"
	, kohle = "Kohle Scheid Holz Grüß Feuer Glut Brand Torf"
	, in1 = "in op bei"
	, ofen = "Ofen Kachel Herd Stoof Küche Feuer Kachelofen"
	, dass = "dass dann damit"
	, wird = "tut wird soll kann beginnt geht"
	, milch = "Milch Rahm"
	, bald = "bald gleich geschwind gauw schnell rasch enta hortig vlug"
	, zu = "zu mit"
	, kochen = "kochen sieden wellen"
	, anfangen = "anfangen anheben ankommen"
	)

lexicon <- getAlignLexicon("../data/WS3/WS3_2lexicon.txt", namesLexicon)

titlesLexicon <- list(
	  tu = "TU Kohle in den Ofen"
	, kohle = "tu KOHLE in den Ofen"
	, in1 = "tu Kohle IN den Ofen"
	, ofen = "to Kohle in den OFEN"
	, dass = "DASS die Milch bald zu kochen anfangen wird"
	, wird = "dass die Milch bald zu kochen anfangen WIRD"
	, milch = "dass die MILCH bald zu kochen anfangen wird"
	, bald = "dass die Milch BALD zu kochen anfangen wird"
	, zu = "dass die Milch bald ZU kochen anfangen wird"
	, kochen = "dass die Milch bald zu KOCHEN anfangen wird"
	, anfangen = "dass die Milch bald zu kochen ANFANGEN wird"
)

sapply(seq_along(titlesLexicon), function(x) {
	plotSingle(lexicon[,names(titlesLexicon)[x]], titlesLexicon[[x]])
	}) -> silent

#' Characters

namesChars <- list(
	  tu = "t u n"
	, Kohle = "k o r l e n"
	, Ofen = "d o r f e n t"
	, Milch = "m i r l e ch e"
	, bald = "b a l d e n"
	, kochen = "k o r ch e n e"
	, anfangen = "a n e f a ng e t e"
)

dataChars <- getAlignChars("../data/WS3/WS3_3characters.txt", namesChars)

sapply(1:ncol(dataChars), function(x) {
	plotSingle(dataChars[,x], colnames(dataChars)[x])
	}) -> silent

#' show Session Info
sessionInfo()
