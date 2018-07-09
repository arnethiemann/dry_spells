

find_dryspells <- function(
  x,                    # a numeric vector with precipitation data
  dates,                # vector containing the dates of above values
  threshold = 0         # upper threshold
) {
  
  # check if the day was dry
  res_vec <- ifelse(x > threshold, 0, 1)
  
  # eliminate single days
  if(res_vec[1] == 1 & res_vec[2] == 0) res_vec[1] <- 0
  if(res_vec[length(res_vec)] == 1 & 
     res_vec[length(res_vec)-1] == 0) res_vec[length(res_vec)] <- 0
  for (i in 2:(length(res_vec)-1)) {
    if(res_vec[i] & !res_vec[i-1] & !res_vec[i+1]) res_vec[i] <- 0
  }
  
  # make human-readable
  tag_vec <- vector()
  tag_vec[1] <- ifelse(res_vec[1] == 1, "start", NA)
  for (i in seq(res_vec)[c(-1, -length(res_vec))]) {
    if(res_vec[i] & !res_vec[i-1]) tag_vec[i] <- "start"
    if(res_vec[i] & !res_vec[i+1]) tag_vec[i] <- "end"
  }
  
  readable <- as.data.frame(
    matrix(
      strftime(dates)[tag_vec %in% c("start", "end")],
      ncol = 2,
      byrow = T
    )
  )
  
  colnames(readable) <- c("start", "end")
  
  readable$length_in_days <- as.integer(
    difftime(
      as.POSIXlt(readable$end),
      as.POSIXlt(readable$start),
      units = "days"
    ) + 1
  )
  
  return(readable)
}


