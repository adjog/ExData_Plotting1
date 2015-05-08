#exdata-14 hwk 1 part1: simple histogram of power usage

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

# Just want two days
powerdata = subset(
       powerdata,
       powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007"
       )

# png output. Want 480x480 pixels, but this is the default anyway
png(filename="plot1.png")
    
# plot
with(powerdata,
     hist(Global_active_power,
          xlab="Global Active Power (kilowatts)",
          ylab="Frequency",
          main="Global Active Power",
          col="red"
          )
     )

dev.off()
