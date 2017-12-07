#' ---
#' title: "Analysis of Wenker sentence 9"
#' author: "Michael Cysouw"
#' date: "`r Sys.Date()`"
#' ---

# make html-version of this manual with:
# rmarkdown::render("sentence9.R")

# load necessary libraries and ad-hoc functions
source("preamble.R")

#' Word order

namesOrder <- "ich bin gewesen bei der frau gewesen und ich hab es zu ihr es gesagt und da sie hat sie gesagt sie dass sie hat es will sagen es auch zu ihre tochter es auch will sagen will hat"

dataOrder <- getAlignSyntax("../data/WS9/WS9_1syntax.tsv", "WS9Transliteration", names = namesOrder)

# make into syntactically interesting features by using recoding profile
# write.recoding(dataOrder, file = "../data/WS9/recodingSyntax", attr = list( c(3,7), 8, 9, c(11,14), c(12,13), 16, c(17,18), c(19,21), 23, c(25,28,37,39), c(27,28,36,37,38), c(27,28,36,37,38), c(29,34), c(30, 35), 31, c(23,27,28,36,37,38) ))

order <- recode(dataOrder, "../data/WS9/recodingSyntax.yml")

titlesOrder <- list(
	  tense.BIN.GEWESEN = "Tense and order of \'ich bin gewesen\'"
	, first.conjunction = "Overt conjunction in \'ich bin gewesen UND habe gesagt\'"
	, repetition.ICH = "Repeated pronoun in \'ich bin gewesen und ICH habe gesagt\'"
	, order.ES.IHR = "Order of \'ich habe ES IHR gesagt\'"
	, preposition.ZU.IHR = "Preposition before \'ihr\'"
	, second.conjunction = "Overt conjunction in \'Ich habe gesagt UND sie hat gesagt\'"
	, connector.DA = "Connector \'da\'"
	, tense.HAT.GESAGT = "Tense of \'sie hat gesagt\'"
	, complementizer.DASS = "Overt complementizer in \'sie sagte, DASS sie will\'"
	, order.WILL.SAGEN = "Order of \'sie WILL SAGEN\'"
	, interaction.DASS.WILL = "Interaction \'… DASS sie WILL sagen\'"
	, tense.HAT.WOLLEN.SAGEN = "Tense of \'sie hat sagen wollen"
	, absence.WILL.sagen = "Absence of \'sie WILL sagen\'"
	, order.ES.IHRE.TOCHTER = "Order of \'sie will ES IHRER TOCHTER sagen\'"
	, order.AUCH.IHRE.TOCHTER = "Order of \'sie will es AUCH IHRER TOCHTER sagen\'"
	, preposition.ZU.IHRE.TOCHTER = "Preposition before \'ihrer Tochter\'"
)

sapply(seq_along(titlesOrder), function(x) {
	plotSingle(order[,names(titlesOrder)[x]], titlesOrder[[x]])
	}) -> silent

#' Lexicon

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

lexicon <- getAlignLexicon("../data/WS9/WS9_2lexicon.tsv", namesLexicon)

titlesLexicon <- list(
	  bin = "ich BIN bei der Frau gewesen"
	, bei = "ich bin BEI der Frau gewesen"
	, frau = "ich bin bei der FRAU gewesen"
	, gewesen = "ich bin bei der Frau GEWESEN"
	, zu1 = "ich habe es ZU ihr gesagt"
	, ihr = "ich habe es zu IHR gesagt"
	, sie1 = "und SIE hat gesagt"
	, sie2 = "SIE will es auch zu ihrer Tochter sagen"
	, will = "sie WILL es auch zu ihrer Tochter sagen"
	, auch = "sie will es AUCH zu ihrer Tochter sagen"
	, zu2 = "sie will es auch ZU ihrer Tochter sagen"
	, ihrer = "sie will es auch zu IHRER Tochter sagen"
	, tochter = "sie will es auch zu ihrer TOCHTER sagen"
)

sapply(seq_along(titlesLexicon), function(x) {
	plotSingle(lexicon[,names(titlesLexicon)[x]], titlesLexicon[[x]])
	}) -> silent

#' Characters

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
	
dataChars <- getAlignChars("../data/WS9/WS9_3characters.tsv", namesChars)

# profiles different for dutch and german because of different orthographic traditions
dataChars <- recodeChars(dataChars, langs = c("11","100"), "../data/WS9/graphemesNLD.tsv")
dataChars <- recodeChars(dataChars, langs = c("1","10"), "../data/WS9/graphemesDEU.tsv")

# write.recoding(dataChars, file = "../data/WS9/tmp.yml")
chars <- recode(dataChars, "../data/WS9/recodingChars.yml")

# plot character parameters
end <- which(colnames(chars) == "s_es13")

sapply(1:end, function(x) {
	plotSingle(chars[,x], colnames(chars)[x])
	}) -> silent

#' Agreement

agreement <- data.frame(
				chars$r_der13
				, lexicon$frau
				, lexicon$ihr
				, lexicon$sie1
				, lexicon$sie2
				, lexicon$ihrer
)

#' show Session Info
sessionInfo()
