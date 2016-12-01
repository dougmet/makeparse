
#' Parse the make database
#'
#' Takes the text output from \code{make -p} and parses it into structured text
#' that is easier to query.
#'
#' @param mkdb Path to a text file containing the result of \code{make -p}. If left
#' out then it will attempt to call \code{make -p} from the current working directory.
#'
#' @return A list with each section from the make file
#' @export
#'
#' @examples
#' \dontrun{
#'   makeParse("mkdb.txt")
#'   makeParse()
#' }
makeParse <- function(mkdb = NULL) {

  # Experimental
  if(is.null(mkdb)) {
    mkdbtxt <- system2("make", args = c("-p"), stdout = TRUE)
    if(is.integer(mkdbtxt)) {
      stop("Failed to run make -p")
    }
  } else {
    mkdbtxt <- readLines(mkdb) # read test file
  }

  dbdf <- labelLines(mkdbtxt) # Label each line in data.frame

  dbsec <- splitSections(dbdf) # split by section

  output <- list(Variables = parseVariables(dbsec$Variables),
                 Directories = parseDirectories(dbsec$Directories))

  output

}
