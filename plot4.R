#########################################################################
#
#   Exploratory Data Analysis Course Project 1 - plot4.R
#   Written by: Madrxn (https://github.com/madrxn)
#
#########################################################################


#loads plyr
library(plyr)

# reads only data from 2/1/2007 and 2/2/2007
pwr <- read.table("./household_power_consumption.txt", 
                  header = FALSE,
                  sep = ";",
                  col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage", "Global_instensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                  na.strings = "?",
                  colClasses = c("character", "character", rep("numeric",7)),
                  nrows = 2880,
                  skip = 66637)

# combines Date and Time columns into DateTime column and adds column to data table
pwr <- mutate(pwr, DateTime = paste(pwr$Date, pwr$Time))
pwr <- mutate(pwr, DateTime = strptime(DateTime, "%d/%m/%Y %H:%M:%S"))

# opens png device; creates 'plot4.png' in working directory
png(filename = "plot4.png", width = 480, height = 480, 
    units = "px", bg = "transparent")

# makes two col and two rows for the four plots
par(mfrow = c(2, 2))

# creates top-left plot
with(pwr, plot(DateTime, Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power"))

# creates top-right plot
with(pwr, plot(DateTime, Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage"))

# creates bottom-left plot with legend
with(pwr, plot(DateTime, Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering"))
with(pwr, lines(DateTime, Sub_metering_2, col = "red"))
with(pwr, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", bty = "n", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

# creates bottom-right plot
with(pwr, plot(DateTime, Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(pwr)[4]))

# close the png file device
dev.off()