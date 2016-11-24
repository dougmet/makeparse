x <- read.dcf("DESCRIPTION")
old_x <- x

v <- as.integer(unlist(strsplit(x[1,"Version"], split = "[.]")))
v[length(v)] <- v[length(v)] + 1
x[1,"Version"] <- paste(v, collapse = ".")

write.dcf(x, "DESCRIPTION")

res <- devtools::check()
if(length(res$errors)>0) {
  write.dcf(old_x, "DESCRIPTION")
}
