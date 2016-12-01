context("Files")

mkdbtxt <- readLines("mkdb.txt") # read test file

dbdf <- labelLines(mkdbtxt) # Label each line in data.frame

dbsec <- splitSections(dbdf) # split by section

dbfiles <- dbsec$Files # extract the variables

test_that("Can parse the variables section", {

  files <- parseFiles(dbfiles)

  expect_is(files, "list")
})
