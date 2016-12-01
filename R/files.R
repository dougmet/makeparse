
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
  names(out) <- NULL
  # return
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
  out <- list()
  f$NU <- TRUE # Flag unused lines
  if(nrow(f)>0) {

    # Get the file out and tag the lines as used
    target <- !(grepl("Not a target:", f$Line[1]) & f$StartHash[1])
    if(target) {
      out$file <- gsub(":.*$", "", f$Line[1])
      f$NU[1] <- FALSE
    }
    else{
      out$file <- gsub(":.*$", "", f$Line[2])
      f$NU[1:2] <- FALSE
    }
    out$target <- target

    # Pull out the variables
    f$isVar <- f$StartHash & grepl(":=", f$Line)
    if(any(f$isVar)) {
      f$bfVar <- FALSE
      f$bfVar[which(f$isVar)-1] <- TRUE
      # Mark as used
      f$NU[f$isVar] <- FALSE
      f$NU[f$bfVar] <- FALSE
      # Keep only the variables and their labels
      fvar <- f[f$isVar | f$bfVar, ]
      fvar$VarGroup <- cumsum(fvar$bfVar)
      # Now split into each variables
      varList <- split(fvar, fvar$VarGroup)
      varListComb <- lapply(varList, parseFileVar)
      names(varListComb) <- NULL
      out$variables <- varListComb
    }

    # Command
    cmdLine <- which(grepl("commands to execute", f$Line))[1]
    if(!is.na(cmdLine)) {
      if(cmdLine < nrow(f)) {
        cmd <- f$Line[cmdLine+1]
        f$NU[cmdLine:(cmdLine+1)] <- FALSE
      } else {
        cmd <- ""
        f$NU[cmdLine] <- FALSE
      }
      out$commands <- cmd
    }

  # Get the messages out
  # Basically all of these need turning into something
  fmsg <- f[f$NU, "Line"]
  fmsg <- grep("#  ", fmsg, value = TRUE)
  fmsg <- gsub("#  ", "", fmsg)
  if(length(fmsg)>0) {
    if("File has been updated" %in% fmsg) out$update <- TRUE
    if("Successfully updated" %in% fmsg) out$update_success <- TRUE
    lastmod <- grep("Last modified", fmsg, value = TRUE)
    if(length(lastmod)>0) out$last_modified <- gsub("Last modified ", "", lastmod)

  }

  } else {
    out <- NULL
  }
  out
}

parseFileVar <- function(vl) {
  list(variable = gsub("# ", "", vl[2, "Line"]),
       type = gsub("# ", "", vl[1, "Line"]))
}
