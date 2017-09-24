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
## Subset data for 1st and 2nd Feb 2007
hpc1 <- subset(hpc, grepl("^[12]/2/2007", hpc$Date))

## clear environment
rm(hpc, fpath)

#convert character value to date
hpc1 <- mutate(hpc1, Date_Time = paste(hpc1$Date,hpc1$Time))
hpc1$Date_Time = strptime(hpc1$Date_Time, format = "%d/%m/%Y %H:%M:%S")

### PLOTTING
## Open graph device
png(filename = "Plot3.png"
    , width = 480, height = 480
)


## Drawing the Plot
# show Sub_metering_1 trend crossed with Date row
with(hpc1,
     plot(hpc1$Date_Time
          , hpc1$Sub_metering_1
          , type = "l"
          , xlab = ""
          , ylab = "Energy sub metering"
     )
)

# Add Sub_metering_2 trend
lines(hpc1$Date_Time
      , hpc1$Sub_metering_2
      , type = "l"
      , col = "red"
      )

# Add Sub_metering_3 trend
lines(hpc1$Date_Time
      , hpc1$Sub_metering_3
      , type = "l"
      , col = "blue"
      )
# Add a legend
legend("topright"
       , legend = c("Sub_metereing_1","Sub_metereing_2","Sub_metereing_3")
       , col = c("black","red","blue")
       , lty = 1
)

## Close graph device
dev.off()
message("find your plot here ->  ", getwd())