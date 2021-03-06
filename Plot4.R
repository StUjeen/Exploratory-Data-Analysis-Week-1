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

## Convert character value to date
hpc1 <- mutate(hpc1, Date_Time = paste(hpc1$Date,hpc1$Time))
hpc1$Date_Time = strptime(hpc1$Date_Time, format = "%d/%m/%Y %H:%M:%S")

### PLOTTING
## Open graph device
png(filename = "Plot4.png"
    , width = 480, height = 480
)

## Wide graph space for 4 plots
par(mfcol = c(2,2))

## Draw GAP\Time plot 
with(hpc1
     , plot(hpc1$Date_Time
            , hpc1$Global_active_power
            , type = "l"
            , xlab = ""
            ,ylab = "Global Active Power"
     )
)

## Draw Submetering\Time plot
# Show Sub_metering_1 trend crossed with Date row
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
       , cex = 0.35
       )

## Draw Voltage plot
with( hpc1
      , plot( hpc1$Date_Time
              , hpc1$Voltage
              , type = "l"
              , xlab = "datetime"
              , ylab = "Voltage"
              )
      )


## Draw Global Active Power (GAP) plot
with( hpc1
      , plot( hpc1$Date_Time
              , hpc1$Global_reactive_power
              , type = "l"
              , xlab = "datetime"
              , ylab = "Global_reactive_power"
      )
)


# Close graph device
dev.off()
message("find your plot here ->  ", getwd())