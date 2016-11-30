context("Load the test db")

mkdbtxt <- readLines("mkdb.txt") # read test file

dbdf <- labelLines(mkdbtxt) # Label each line in data.frame

test_that("It makes a data frame", {

  expect_is(dbdf, "data.frame")

})
