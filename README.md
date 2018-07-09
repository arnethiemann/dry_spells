# dry_spells
Two R functions for finding dry spells in precipitation time series.

`count_consecutive(x)` retains a numeric vector with a count of days since the last precipitation was measured.

`dryspells_readable(x, dates, threshold = 0)` creates a dataframe with start and end date of dryspells, and gives the length in a separate column.