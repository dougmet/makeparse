context("Get the directories")

mkdbtxt <- readLines("mkdb.txt") # read test file

dbdf <- labelLines(mkdbtxt) # Label each line in data.frame

dbsec <- splitSections(dbdf) # split by section

dbdir <- dbsec$Directories # extract the directories

test_that("Can parse the directories section", {

  directories <- parseDirectories(dbdir)

  dirNames <- vapply(directories, `[[`, "char", "directory")

  names(dirNames) <- NULL # Don't care if it's named

  expect_equal(dirNames, c("SCCS", "books/SCCS", "books/RCS", "RCS"))

})
