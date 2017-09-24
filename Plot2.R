##load libraries
library(proto)
library(gsubfn)
library(lubridate)
library(dplyr)

### DATA PROCEEDING
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
## Subset data for 1st and 2nd Feb 2007
hpc1 <- subset(hpc, grepl("^[12]/2/2007", hpc$Date))

## clear environment
rm(hpc, fpath)

#convert character value to date
hpc1 <- mutate(hpc1, Date_Time = paste(hpc1$Date,hpc1$Time))
hpc1$Date_Time = strptime(hpc1$Date_Time, format = "%d/%m/%Y %H:%M:%S")

### PLOTTING

## Open graph device
# Open graph device
png(filename = "Plot2.png"
    , width = 480, height = 480
)

## Draw GAP\Time plot
with(hpc1
     , plot(hpc1$Date_Time
            , hpc1$Global_active_power
            , type = "l"
            , xlab = ""
            ,ylab = "Global Active Power (kilowatts)"
           )
      )

# Close graph device
dev.off()
message("find your plot here ->  ", getwd())