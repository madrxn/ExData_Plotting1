#########################################################################
#
#   Exploratory Data Analysis Course Project 1 - plot3.R
#   Written by: Madrxn (https://github.com/madrxn)
#
#########################################################################

library(plyr)

#reads only data from 2/1/2007 and 2/2/2007
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

# opens png device; creates 'plot3.png' in working directory
png(filename = "plot3.png", width = 480, height = 480, 
    units = "px", bg = "transparent")

# creates line x-y plot 
with(pwr, plot(DateTime, Sub_metering_1,
               type = "l",
               xlab = "",
               ylab = "Energy sub metering"))

# adds sub_metering_2 and 3 to plot with legend
with(pwr, lines(DateTime, Sub_metering_2, col = "red"))
with(pwr, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

# close the png file device
dev.off()