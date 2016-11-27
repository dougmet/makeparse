
#' Parse the variables section of the database
#'
#' Things like environment variables and defaults. Keep as much metadata as possible
#'
#' @param vardf The data frame corresponding to the variables section
#'
#' @return A list of lists, each containing a variable and its metadata
parseVariables <- function(vardf) {

  vardf$SumHash <- cumsum(vardf$StartHash)

  # Where does it all end?
  imax <- which(grepl("[0-9]+ variables in [0-9]+ hash buckets", vardf$Line))
  if(length(imax>0)) {
    vars <- vardf[seq.int(imax[1]-1), ]
  }

  varList <- split(vars, vars$SumHash)
  names(varList) <- NULL

  lapply(varList, parseVar)
}

#' Parse a variable record
#'
#' @param x A 2 row data frame with at least a Line column
#'
#' @return A list which the variable name, type and metadata all extracted
parseVar <- function(x) {

  if(nrow(x)==2) {
  varval <- unlist(strsplit(x[2,"Line"], split = " = "))
  type <- gsub("# ", "", x[1,"Line"])
  type <- unlist(strsplit(type, " "))
  type1 <- type[1]
  type2 <- paste(type[-1], collapse = " ")

  list(variable = varval[1],
       value = varval[2],
       type = type1,
       typenote = type2)
  } else {
    NULL
  }
}
