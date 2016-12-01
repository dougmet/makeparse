context("makeParse function")

test_that("top level function runs", {

  result <- makeParse("mkdb.txt")

  # Nothing to demanding just yet
  expect_is(result, "list")

  expect_gt(length(result), 0)
})
