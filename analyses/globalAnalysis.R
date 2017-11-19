#' ---
#' title: "Global analysis of Wenker sentences"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("globalAnalysis.R")

# load necessary libraries and ad-hoc functions
source("preamble.R")

#' Global string similarity

rawData9 <- read.delim("../data/WS9/WS9_0source.txt", quote="", colClasses = "character")[,5]
rawData3 <- read.delim("../data/WS3/WS3_0source.txt", quote="", colClasses = "character")[,5]

rawData <- paste(rawData9, rawData3)
plotAggStrings(rawData, "Global string similarity (bigrams)")

#' Global syntactic similarity

# sentence 9
namesOrder <- "ich bin gewesen bei der frau gewesen und ich hab es zu ihr es gesagt und da sie hat sie gesagt sie dass sie hat es will sagen es auch zu ihre tochter es auch will sagen will hat"
dataOrder <- getAlignSyntax("../data/WS9/WS9_1syntax.txt", "WS9Transliteration", names = namesOrder)
order9 <- recode(dataOrder, "../data/WS9/recodingSyntax.yml")

# sentence 3
namesOrder <- "X tu hinein etwas die kohle hinein in den ofen einlegen hinein dass wird kochen die Milch wird bald wird fängt an anfängt zu kochen fängt anfängt wird"
dataOrder <- getAlignSyntax("../data/WS3/WS3_1syntax.txt", 5, namesOrder)
order3 <- recode(dataOrder, "../data/WS3/syntaxRecoding.yml")

# plot
order <- cbind(order3, order9)
plotAgg(order, title = "Agglomerative syntactic similarity")
plotIntAgg(order, n = 15, weight = isqrt, title = "Interpolated agglomerative syntactic similarity")

#' Global lexical similarity

# sentence 9
namesLexicon <- list(
	  bin = "bin sein war hab"
	, bei = "bei von nach zu mit"
	, frau = "Frau Weib Alten Basi Mutter"
	, gewesen = "gewesen gesein"
	, zu1 = "für an zu gegen"
	, ihr = "ihr der sie ihm/ihn"
	, sie1 = "sie die es hij ju"
	, sie2 = "sie ich die es hij ju"
	, will = "will tut geht soll macht"
	, auch = "auch schon gleich"
	, zu2 = "für an zu gegen"
	, ihrer = "ihr der sein mein ene"
	, tochter = "Tochter Mädchen Deern Mensch Lüte Gits Famen"
)
lexicon9 <- getAlignLexicon("../data/WS9/WS9_2lexicon.txt", namesLexicon)

# sentence 3
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
lexicon3 <- getAlignLexicon("../data/WS3/WS3_2lexicon.txt", namesLexicon)

# plot
lexicon <- cbind(lexicon9, lexicon3)
plotAgg(lexicon, title = "Agglomerative lexical similarity")
plotIntAgg(lexicon, n = 10, weight = isqrt, title = "Interpolated agglomerative lexical similarity")

#' Global sound similarity

# sentence 9
namesChars <- list(
	ich1 = "i ch"
	, bin = "b i n"
	, sein1 = "s i n d"
	, gewesen = "g e w e s e n"
	, bei =  "b ei"
	, der1 = "d e r e r"
	, frau = "f r au w e n"
	, weib = "w ei b e n"
	, und1 = "u n d"
	, habe = "h a b e t"
	, es1 = "d a s"
	, gegen1 = "g e g e n"
	, ihr = "h i r e n"
	, gesagt1 = "g e s a g t"
	, und2 = "u n d"
	, sie1 = "s ie"
	, hat1 = "h a f t"
	, es2 = "d a s"
	, will = "w i ll e t e"
	, soll = "s o ll"
	, sagen = "s a g e n"
	, auch = "au ch"
	, an2 = "a n"
	, gegen2 = "g e g e n"
	, ihrer = "h i r e r e r"
	, tochter = "t o ch t e r n e"
	, mädchen = "m ä d e ch e n"
	, deern = "d i r n d l"
)	
dataChars9 <- getAlignChars("../data/WS9/WS9_3characters.txt", namesChars)

# sentence 3
namesChars <- list(
	  tu = "t u n"
	, Kohle = "k o r l e n"
	, Ofen = "d o r f e n t"
	, Milch = "m i r l e ch e"
	, bald = "b a l d e n"
	, kochen = "k o r ch e n e"
	, anfangen = "a n e f a ng e t e"
)
dataChars3 <- getAlignChars("../data/WS3/WS3_3characters.txt", namesChars)

# plot
dataChars <- cbind(dataChars9, dataChars3)
plotAgg(dataChars, "Agglomerative character similarity (IPA transliterated)")
plotIntAgg(dataChars, n = 10, title = "Interpolated agglomerative character similarity")
