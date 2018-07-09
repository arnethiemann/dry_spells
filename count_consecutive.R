count_consecutive <- function(x) {

    # ensure a time series with leading 0s is working
  res_vec <- ifelse(d > 0, 0, 1)
  
  # loop everything, from the second
  for (i in 2:length(x)) {
    if (x[i] > 0) {
      res_vec[i] <- 0
    } else {
      res_vec[i] <- 1 + res_vec[i-1]
    }
  }
  
  return(res_vec)
}