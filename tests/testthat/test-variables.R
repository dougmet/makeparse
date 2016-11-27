context("Get the variables")

mkdbtxt <- readLines("mkdb.txt")

dbdf <- labelLines(mkdbtxt)

dbsec <- splitSections(dbdf)

dbvariables <- dbsec$Variables

test_that("Can parse the variables section", {

  variables <- parseVariables(dbvariables)

  varTypes <- vapply(variables, `[[`, "type", "type")

  uniqueVarTypes <- unique(varTypes)

  # Maybe check there aren't too many variable types
  expect_lt(length(uniqueVarTypes), 10)

  expect_true("environment" %in% uniqueVarTypes)

})
