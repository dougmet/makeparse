context("Split into sections")

mkdbtxt <- readLines("mkdb.txt")

dbdf <- labelLines(mkdbtxt)

dbsec <- splitSections(dbdf)

names(dbsec)

test_that("Section Names", {

  expect_is(dbsec, "list")

  expect_equal(names(dbsec),
               c("GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.",
                 "Variables", "Directories", "Implicit Rules", "Pattern-specific variable values",
                 "Files", "VPATH Search Paths"))

})
