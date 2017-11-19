# extract alignment out of tab-separated file with alignment
# function are slightly different for different kind of data

getAlignSyntax <- function(file, column, names = NULL, internal.sep = " ") {
	
	# read file
	data <- read.delim(file, colClasses = "character", quote = "")

	# extract columns
	features <- strsplit(data[,column], internal.sep)
	features <- do.call(rbind, features)	
	features[features != "-"] <- "X"
	
	features <- addOtherLangs(features, data, meta)
	
	# add names
	if (!is.null(names)) {
		tmp <- strsplit(names, split = internal.sep)[[1]]
		colnames(features) <- paste0(tmp, 1:length(tmp))
	}

	return(features)
}

getAlignLexicon <- function(file, names, internal.sep = " ") {
	
	# read file
	data <- read.delim(file, colClasses = "character", quote = "")
	columns <- names(names)
	
	features <- c()
	for (i in columns) {
		feature <- strsplit(data[,i], split = internal.sep)
		feature <- do.call(rbind, feature)
		feature[feature != "-"] <- "X"
		
		levs <- strsplit(names[[i]], split = internal.sep)[[1]]
		for (j in 1:ncol(feature)) {
			feature[,j][feature[,j]=="X"] <- levs[j]
		}
		feature <- apply(feature, 1, paste, collapse = "")
		feature <- gsub("-", "", feature)
		
		tmp <- table(feature)
		if (names(tmp)[which(tmp==max(tmp))] == "") {
			feature[feature == ""] <- "(absent)"
		} else {	
			feature[feature == ""] <- NA
		}
		features <- cbind(features, feature)
	}
	
	features <- addOtherLangs(features, data, meta)
	colnames(features) <- columns
	return(features)
}


getAlignChars <- function(file, names, internal.sep = " ") {
	
	# read file
	data <- read.delim(file, colClasses = "character", quote = "")
	columns <- names(names)
	
	features <- c()
	for (i in columns) {
		feature <- strsplit(data[,i], split = internal.sep)
		feature <- do.call(rbind, feature)
		
		chars <- strsplit(as.character(names[i]), split = internal.sep)[[1]]
		charnames <- paste0(chars, "_", i, 1:length(chars))
		colnames(feature) <- charnames
		
		nas <- apply(feature, 1, function(x){sum(x == "-") == ncol(feature) }) 
		feature[nas,] <- NA
		
		features <- cbind(features, feature)
	}
	
	features <- addOtherLangs(features, data, meta)
	return(features)
	
}

addOtherLangs <- function(features, data, meta) {
	
	# add all previously ignored data as NA
	features <- cbind(Bogennummer = data$Bogennummer, features)
	features <- merge(meta[,"Bogennummer", drop = F], features, all = TRUE)
	rownames(features) <- features[,1]
	features <- features[,-1]
	features <- features[meta$Bogennummer,]

	
}

recodeChars <- function(chars, langs, profile) {
	
	chars <- as.matrix(chars)

	sel <- meta$Sprache %in% langs
	recoded <- apply(chars[sel,], 2, function(x) {
		tokenize(x, profile = profile, trans = "IPA", sep =" ")$strings$transliterated
	})
	chars[sel,] <- recoded
	
	return(data.frame(chars))
}


