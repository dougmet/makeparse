library(dplyr)
library(devtools)
load_all()

df <- readLines("tests/testthat/mkdb.txt") %>%
  labelLines

sections <- splitSections(df)
