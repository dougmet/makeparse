
#' Parse the directory section
#'
#' @param dirdf the directory section from the split data frame
#'
#' @return a list with directory name and note in each sub item
parseDirectories <- function(dirdf) {

  dirdf$isDir <- grepl(":", dirdf$Line) & dirdf$StartHash &!grepl("inode [0-9]+", dirdf$Line)
  dirdf$dirGroup <- cumsum(dirdf$isDir)

  dirList <- split(dirdf, dirdf$dirGroup)

  lapply(dirList, getDirSubList)
}

#' Split a directory line into bits
#'
#' @param x A data frame with a single directory in it
#' (can have more than one line but just one valid dir)
#'
#' @return a list with \code{directory} and \code{note} items
getDirSubList <- function(x) {

  lne <- gsub("^# ", "", x$Line[1])
  lne <- unlist(strsplit(lne, split = ": "))

  out <- list(directory = lne[1])
  if(length(lne>1)) out$note <- lne[2]
  out
}
