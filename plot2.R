#exdata-14 hwk 1 part2: simple time series of power usage

# Read data and subset to the two dates of concern.
#
# (This code isn't great for efficiency or maintainability
#  in case the file gets much larger and/or if we are interested in
#  varying date ranges, but suffices for the task at hand.)

powerdata = read.table(
    "household_power_consumption.txt",
    sep = ";",
    na.strings = "?",
    header = TRUE,
    )
powerdata = subset(
    powerdata,
    powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007"
    )

# new column is date/time that R can work with
powerdata$datetime = strptime(
    paste(powerdata$Date, powerdata$Time),
    "%d/%m/%Y %H:%M:%S"
    )

# png output. Want 480x480 pixels, but this is the default anyway
png(filename="plot2.png")

# do actual plot
with(powerdata,
     plot(datetime,
          Global_active_power,
          type="l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"
          )
     )

dev.off()
