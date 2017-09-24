##load libraries
library(proto)
library(gsubfn)
library(lubridate)
library(dplyr)

## Read the dataset
setwd("~/crsra/c4w1/hpc/")
fpath <- list.files(getwd(), pattern = "(*.)+txt$", full.names = T)

hpc <- read.table(fpath
           , header = T
           , sep=";"
           , stringsAsFactors = F
           , na.strings = "?"
           #, colClasses
           )
hpc1 <- subset(hpc, grepl("^[12]/2/2007", hpc$Date))
rm(hpc, fpath)

## Plotting
# Open graph device
png(filename = "Plot1.png"
    , width = 480, height = 480
    )
# Draw histogram
hist(hpc1$Global_active_power
     , col = "orange"
     , main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)"
     , ylab = "Frequency"
      )

# Close graph device
dev.off()
message("find your plot here ->  ", getwd())