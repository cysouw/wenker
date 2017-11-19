


#' Global similarity

both <- cbind(order,lexicon)

rawData <- read.delim("../data/WS3/WS3_0source.txt", quote="", colClasses = "character")[,5]
plotAggStrings(rawData, "Global string similarity (bigrams)")

plotAgg(dataOrder, "Agglomerative syntactic similarity (raw data)")
plotAgg(order, "Agglomerative syntactic similarity (selected features)")
plotAgg(lexicon, "Agglomerative lexical similarity")
plotAgg(both, "Agglomerative lexical+syntactic similarity", )
plotAgg(dataChars, "Agglomerative character similarity")

plotIntAgg(dataOrder, n=15, weight=isqrt)
plotIntAgg(order, n=15, weight=isqrt)
plotIntAgg(lexicon, n=15, weight=isqrt)
plotIntAgg(both, n=15, weight=isqrt)
plotIntAgg(dataChars, n=15, weight=isqrt)



#' Global similarity

rawData <- read.delim("../data/WS9/WS9_0source.txt", quote="", colClasses = "character")[,5]
plotAggStrings(rawData, "Global string similarity (bigrams)")

plotAgg(order[,-16], "Agglomerative syntactic similarity")
plotAgg(lexicon, "Agglomerative lexical similarity")
both <- cbind(order[,-16],lexicon)
plotAgg(both, "Agglomerative lexical+syntactic similarity", )
plotAgg(dataChars, "Agglomerative character similarity (IPA transliterated)")

plotIntAgg(order[,-16], n = 10, title = "Interpolated agglomerative syntactic similarity")
plotIntAgg(lexicon, n = 10, title = "Interpolated agglomerative lexical similarity")
plotIntAgg(both, n = 10, title = "Interpolated agglomerative lexical+syntactic similarity")
plotIntAgg(dataChars, n = 10, title = "Interpolated agglomerative character similarity")
