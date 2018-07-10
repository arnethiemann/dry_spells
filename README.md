# dry_spells
Two R functions for finding dry spells in precipitation time series.

## Description
This script was written to filter out dry spells in climate time series data and obtain a human-readable summary.

`count_consecutive(x)` retains a numeric vector with a count of days since the last precipitation was measured.

`dryspells_readable(x, dates, threshold = 0)` creates a dataframe with start and end date of dryspells, and gives the length in a separate column.

## Usage
Before you can use the function, make sure to `source("count_consecutive.R")` resp. `source("dryspells_readable.R")` to load the function into your environment. Alternatively, you can also copy the function code into your own script and parse it before using.

```
## For a simple count since the last precipitation measured
count_consecutive(x)

## For a readable start and end dataframe with length of the period
dryspells_readable(x, dates, threshold = 0)

```

## Arguments
<dl>
  <dt>x</dt>
  <dd>A numeric vector, containing the measured precipitation.</dd>
  
  <dt>dates</dt>
  <dd>A vector of dates, formatted as a date class. Will be used for the output of start and end dates as well as for calculating the length of the period.</dd>
  
  <dt>threshold</dt>
  <dd>Numeric or integer stating up to which amount of measured precipitation a day is considered to be dry.</dd>
</dl>

## Examples

```
# create random data for testing
measurements <- data.frame(
  precipitation = abs(rnorm(200, 0, 1)),
  date = seq.Date(
    from = as.Date("2017-05-01"),
    by = "day",
    length.out = 200
  )
)

# to obtain some more dry periods in the test data
measurements$precipitation[
  measurements$precipitation < .5
] <- 0

# source functions
source("count_consecutive.R")
source("dryspells_readable.R")

# run functions
dry_daycount <- count_consecutive(measurements$precipitation)
dry_readable <- find_dryspells(
  x = measurements$precipitation,
  dates = measurements$date,
  threshold = .6
)

# view the results
print(dry_daycount)
View(dry_readable)
```