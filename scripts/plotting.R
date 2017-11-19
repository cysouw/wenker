# to make voronoi diagram
# add manual separation of separate areas by adding white polygons
# I used locator() to determine these coordinates

loc <- meta[,1:2]
sep <- cbind( Longitude = c(11.34162, 11.19866, 18.78059, 29.87453)
			, Latitude  = c(46.09955, 46.07597, 49.33322, 46.15076)
			)

# voronoi takes some time
# determine window for the drawing
# window <- qlcVisualize::hullToOwin(rbind(loc, sep), shift = 0.1, alpha = 0.3)

# within the window, make a voronoi polygon division
# v <- qlcVisualize::voronoi(rbind(loc, sep), window)

# save data for quicker plotting
# save(v, file = "scripts/v.Rdata")
load("../scripts/v.Rdata")

# plotting voronoi diagram of a single feature

plotSingle <- function(feature, title = "", voronoi = v, separators = sep) {
	
	# get some suitable colors
	n <- length(levels(feature))-1
	cols <- c("grey70", brewer.pal(max(3,n), "Dark2")[1:n])
	# order by frequency
	names(cols) <- names(sort(table(feature), decreasing = TRUE))
	# make vector of colours, adding white for separation
	colVector <- c( cols[as.character(feature)], rep("white", nrow(separators)))
	# add lightgrey for NA
	colVector[is.na(colVector)] <- "grey90"
	
	vmap(voronoi, colVector, border = NA, outer = NA)
	legend("right", fill = cols, legend = names(cols), cex = 0.4)
	title(main =  title)

}

# plotting aggregate maps

plotAgg <- function(features, title, method = "weighted", heeringa = "eigs") {

	nas <- apply(features, 1, function(x){sum(is.na(x))}) == ncol(features)
	sim <- qlcMatrix::sim.obs(features[!nas,], method = method)
	cols <- qlcVisualize::heeringa(max(sim)-sim, method = heeringa)
	allcols <- rep("grey90", times = nrow(features))
	allcols[!nas] <- cols
	vmap(v, col = allcols, border = NA, outer.border =  NA) 
	title(main = title)

}

plotAggStrings <- function(strings, title, heeringa = "eigs") {

	langs <- (meta$Sprache %in% c("1","10","11","100"))
	sim <- qlcMatrix::sim.strings(strings[langs])
	cols <- qlcVisualize::heeringa(max(sim)-sim, method = heeringa)
	allcols <- rep("grey90", times = length(strings))
	allcols[langs] <- cols
	vmap(v, col = allcols, border = NA, outer.border =  NA) 
	title(main = title)

}

# interpolate aggregate to nearest n around each features

plotIntAgg <- function(features, n, weight = NULL, title = "", equal = F) {
	
	allNA <- apply(features, 1, function(x){sum(is.na(x))}) == ncol(features)
	
	neighb <- t(knearneigh(as.matrix(loc), n, longlat=T)$nn)
	dim(neighb) <- NULL
	M <- sparseMatrix( i = rep(1:nrow(features), each = n), j = neighb)	
	
	N <- splitTable(features)
	P <- t(M) %*% N$OV + N$OV # alternatively: add diagonal to M!
	if (equal) { P <- as(P, "nMatrix") }
	sim <- cosRow(t(P), t(N$AV), weight = weight)

	h <- heeringa(1-sim)
	h[allNA] <- NA
	vmap(v, h, outer = NA, border = NA)
	title(main = title)
	
}