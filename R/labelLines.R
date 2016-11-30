
labelLines <- function(x) {
  df <- data.frame(ID = seq_along(x),
                   Line = x,
                   StartHash = grepl("^#", x),
                   EndColon = grepl(":\\s*$", x),
                   Blank = grepl("^\\s*$", x),
                   StartTab = grepl("^\\t", x),
                   stringsAsFactors = FALSE)

  df$Object <- !df$StartHash & df$EndColon
  df$Modifier <- df$StartHash & df$EndColon
  df$Comment <- df$StartHash & !df$EndColon
  df$Group <- cumsum(df$Blank)
  df$BfBlank <- c(df$Blank[seq_len(length(x)-1)+1], FALSE)
  df$AfBlank <- c(FALSE, df$Blank[seq_len(length(x)-1)])

  SectionLines <- c("# Variables", "# Directories",
                    "# Implicit Rules",
                    "# Pattern-specific variable values",
                    "# Files", "# VPATH Search Paths")
  df$SectionHeading <- df$Line %in% SectionLines
  df$Section <- cumsum(df$SectionHeading)
  df

}
