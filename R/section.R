#' Get the name of a section
#'
#' @param dbsec data frame for that section
#'
#' @return chr(1) Name of section
sectionHeader <- function(dbsec) {
  gsub("^# ", "", dbsec[1,"Line"])
}

#' Strip the section name and following blank line
#'
#' @param dbsec data frame for that section
#'
#' @return data.frame with section heading removed
sectionDropHeader <- function(dbsec) {
  toDrop <- 1
  if(nrow(dbsec)>1 & dbsec[1,"BfBlank"]) {
    toDrop <- 1:2
  }
  dbsec[-toDrop, , drop = FALSE]
}

#' Split the labelled data.frame into section
#'
#' @param dbdf data.frame from \code{labelLines}
#'
#' @return a named list with each section as a data.frame
splitSections <- function(dbdf) {

  sections <- split(dbdf, dbdf$Section)

  names(sections) <- vapply(sections, sectionHeader, "a")

  sections <- lapply(sections, sectionDropHeader)

}
