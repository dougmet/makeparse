
R_FILES=$(wildcard R/*.R)

.PHONY : pkg
pkg: $(R_FILES) make.R
	Rscript make.R
