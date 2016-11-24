context("Load the test db")

mkdbtxt <- readLines("mkdb.txt")

dbdf <- labelLines(mkdbtxt)

test_that("It makes a data frame", {

  expect_is(dbdf, "data.frame")

})
