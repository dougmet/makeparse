
#' Parse the files section
#'
#' @param dbfiles A data frame containing the files section
#'
#' @return A list with an item per file
parseFiles <- function(dbfiles) {

  dbfiles <- dbfiles[!dbfiles$Blank, , drop = FALSE]

  # Split by group
  dbfs <- split(dbfiles, dbfiles$Group)

  # Parse each one.
  out <- lapply(dbfs, parseOneFile)
  out <- out[!vapply(out, is.null, logical(1))]
  out
}

#' Parse a single file
#'
#' Usually called from an lapply. This is for pulling apart all the lines related
#'  to a single file and returning that in a list.
#'
#' @param f A data frame containing all of the lines that are relevant to a single file
#'
#' @return A list with the file information
parseOneFile <- function(f) {

  # Catch empty items
  if(nrow(f)>0) {
    target <- !(grepl("Not a target:", f$Line[1]) & f$StartHash[1])
  } else {
    out <- NULL
  }
  out
}
