context("Get the variables")

mkdbtxt <- readLines("mkdb.txt") # read test file

dbdf <- labelLines(mkdbtxt) # Label each line in data.frame

dbsec <- splitSections(dbdf) # split by section

dbvariables <- dbsec$Variables # extract the variables

test_that("Can parse the variables section", {

  variables <- parseVariables(dbvariables)

  varTypes <- vapply(variables, `[[`, "type", "type")

  uniqueVarTypes <- unique(varTypes)

  # Maybe check there aren't too many variable types
  expect_lt(length(uniqueVarTypes), 10)

  expect_true("environment" %in% uniqueVarTypes)

})
