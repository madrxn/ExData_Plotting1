#########################################################################
#
#   Exploratory Data Analysis Course Project 1 - plot1.R
#   Written by: Madrxn (https://github.com/madrxn)
#
#########################################################################

#reads only data from 2/1/2007 and 2/1/2007
pwr <- read.table("./household_power_consumption.txt", 
                  header = FALSE,
                  sep = ";",
                  col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage", "Global_instensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                  na.strings = "?",
                  colClasses = c("character", "character", rep("numeric",7)),
                  nrows = 2880,
                  skip = 66637)

# opens png device; creates 'plot1.png' in working directory
png(filename = "plot1.png", width = 480, height = 480, 
    units = "px", bg = "transparent")

# creats histogram of glabal active power data
with(pwr, hist(Global_active_power,
     freq = TRUE,
     col = "red",
     main = "Histogram of Global Active Power",
     xlab = "Global Active Power (kilowatts)"))

# close the png file device
dev.off()
