library(plyr)
library(dplyr)
library(graphics)
library(grDevices)
library(lubridate)

## Read the data from the dataset, for the dates 2007-02-01 and 2007-02-02
hpconsump <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),  sep = ";", na.strings = "?", header = TRUE)

##Give column names to the data frame
colnames(hpconsump) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##Create a png file for plot3
png(file = "plot3.png", width = 480, height = 480) 

##Combine the date and time and then convert it to a proper POSIXct date format
x <- paste(hpconsump$Date, hpconsump$Time)
y <- as.POSIXct(x, format = "%d/%m/%Y %H:%M:%S")
z <- as.Date(y)
d1 <- wday(z, label=TRUE)
df <- cbind(hpconsump, x, d1)

##Plot multiple graphs on the same line plot using the plot and lines functions
plot(y, df$Sub_metering_1, type= "l", xlab = " ", ylab = " Energy sub metering")
lines(y, df$Sub_metering_2, col = "red")
lines(y, df$Sub_metering_3, col= "blue")

##Add legend on the topright corner of the plot 
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
lty = c(1,1,1), lwd = c(1,1,1), col = c("black", "red", "blue"))

##Switch off the graphics device
dev.off()