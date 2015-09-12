library(plyr)
library(dplyr)
library(graphics)
library(grDevices)

## Read the data from the dataset, for the dates 2007-02-01 and 2007-02-02
hpconsump <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), sep = ";")

##Give column names to the data frame
colnames(hpconsump) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##Create a png file for the plot1
png(file = "plot1.png")

##Plot the histogram of the Global Active Power 
hist(hpconsump$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

##Reset margin parameters using the par() function
par(mar = c(4,4,2,2))

##Switch off the graphics device
dev.off()