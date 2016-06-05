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
png("plot2.png", width = 480, height = 480)

plot(powerSubset$dateTime, y = powerSubset$globalActivePower, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(powerSubset$dateTime, y = powerSubset$globalActivePower, type = "l")

dev.off()