library(plyr)
library(dplyr)
library(graphics)
library(grDevices)
library(lubridate)

## Read the data from the dataset, for the dates 2007-02-01 and 2007-02-02
hpconsump <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),  sep = ";", na.strings = "?", header = TRUE)

##Give column names to the data frame
colnames(hpconsump) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##Create a png file for plot4
png(file = "plot4.png", width = 480, height = 480) 

##Combine the date and time and convert to a proper POSIXct date format
x <- paste(hpconsump$Date, hpconsump$Time)
y <- as.POSIXct(x, format = "%d/%m/%Y %H:%M:%S")
z <- as.Date(y)
d1 <- wday(z, label=TRUE)
df <- cbind(hpconsump, x, d1)

##Set the margin widths using the par and mar functions
par(mar = c(5,4,4,2))

##Set the number of rows and columns for multiple plots
par(mfrow = c(2,2))

##Plot the four plots 
plot(y, df$Global_active_power, type = "l", xlab = " ", ylab= "Global Active Power")
plot(y, df$Voltage, type = "l", xlab = "datetime", ylab = " Voltage")
plot(y, df$Sub_metering_1, type= "l", xlab = " ", ylab = " Energy sub metering")
lines(y, df$Sub_metering_2, col = "red")
lines(y, df$Sub_metering_3, col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),lwd = c(1,1,1), col = c("black", "red", "blue"), bty = "n")
plot(y, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

##Switch the graphics device off
dev.off()
