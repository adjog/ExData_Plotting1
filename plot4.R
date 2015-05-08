# exdata-14 hwk 1 part3: 2x2 grid of various plots

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
png(filename="plot4.png")

# prepare for grid of plots, do column-first
par(mfcol=c(2,2))

# do first plot; same as part 2 of homework
with(powerdata,
     plot(datetime,
          Global_active_power,
          type="l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"
          )
     )

# do second plot; same as part 3 of homework
with(powerdata,
     plot(datetime,
          # actually metering 1 has largest range,
          # but pmax is more generalizable
          pmax(Sub_metering_1,
               Sub_metering_2,
               Sub_metering_3),
          type="n",
          xlab="",
          ylab="Energy sub metering"
          )
     )
with(powerdata, points(datetime, Sub_metering_1, type="l", col="black"))
with(powerdata, points(datetime, Sub_metering_2, type="l", col="red"))
with(powerdata, points(datetime, Sub_metering_3, type="l", col="blue"))
legend(
    "topright",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty=1,
    col=c("black", "red", "blue")
    )

# do third plot (row 1, col 2); time series of voltage
with(powerdata,
     plot(datetime,
          Voltage,
          type="l"
          #xlab = "datetime",
          #ylab = "Voltage"
          )
     )

# do fourth plot (row 2, col 2); time series of reactive power
with(powerdata,
     plot(datetime,
          Global_reactive_power,
          type="l"
          )
     )

dev.off()
