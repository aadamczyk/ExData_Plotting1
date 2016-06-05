##Prepare data frame for import
colNames = c("date", "time", "globalActivePower", "globalReactivePower", "voltage", 
             "globalIntensity", "subMetering1", "subMetering2", "subMetering3")
colClasses = c("character", "character", rep("numeric",7) )

##Import data
power <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, col.names=colNames, 
                    colClasses=colClasses, na.strings="?")

##Set start and end dates for analysis
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

##Set class for date and subset into relevant days
power$date = as.Date(power$date, format="%d/%m/%Y")
powerSubset <- power[power$date %in% date1:date2, ]

##Set time class
powerSubset$dateTime <- paste(as.character(powerSubset$date),as.character(powerSubset$time), sep = " ")
powerSubset$dateTime <- strptime(powerSubset$dateTime, format = "%Y-%m-%d %H:%M:%S")

##Build plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

##Plot 1
plot(powerSubset$dateTime, y = powerSubset$globalActivePower, type = "n", ylab = "Global Active Power (kilowatts)",
     xlab = "")
lines(powerSubset$dateTime, y = powerSubset$globalActivePower, type = "l")

##Plot 2
plot(powerSubset$dateTime, y = powerSubset$voltage, type = "n", ylab = "Voltage", xlab = "datetime")
lines(powerSubset$dateTime, y = powerSubset$voltage, type = "l")

##Plot 3
plot(powerSubset$dateTime, y = powerSubset$subMetering1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(powerSubset$dateTime, y = powerSubset$subMetering1, type = "l")
lines(powerSubset$dateTime, y = powerSubset$subMetering2, type = "l", col = "red")
lines(powerSubset$dateTime, y = powerSubset$subMetering3, type = "l", col = "blue")
legend(x = "topright", lty = 1,legend = c("Sub_metering_1", "Sub_metering_2", "SubPmetering_3"), 
       col = c("black", "red", "blue"), bty = "n")

##Plot 4
plot(powerSubset$dateTime, powerSubset$globalReactivePower, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
axis(side = 2, at = seq(.1, .5, .1))
lines(powerSubset$dateTime, powerSubset$globalReactivePower, type = "l")

dev.off()