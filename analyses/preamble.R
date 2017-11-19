library(qlcVisualize)
library(qlcMatrix)
library(qlcData)
library(RColorBrewer)
library(spdep)

# load functions to process data
source("../scripts/readData.R")

# load metadata
meta <- read.delim("../data/metadata.txt")

# make voronoi for plotting and load plotting functions
source("../scripts/plotting.R")
