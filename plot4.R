# for read data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./fc.zip")
unzip("./fc.zip")
dataset <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

# change the type of data and select the date between 20070201 to 20070202
dataset$Date <- as.character(dataset$Date) 
dataset1 <- subset(dataset, (Date == "1/2/2007")|(Date == "2/2/2007"))
dataset1$Date <- as.character(dataset1$Date) 
dataset1$Sub_metering_1 <- as.numeric(as.character(dataset1$Sub_metering_1))
dataset1$Sub_metering_2 <- as.numeric(as.character(dataset1$Sub_metering_2))
dataset1$Sub_metering_3 <- as.numeric(as.character(dataset1$Sub_metering_3))
dataset1$Voltage <- as.numeric(as.character(dataset1$Voltage))
dataset1$Global_reactive_power <- as.numeric(as.character(dataset1$Global_reactive_power))
dataset1$Global_active_power <- as.numeric(as.character(dataset1$Global_active_power))
dataset1$Date <- sub("1/2/", "01/02/", dataset1$Date)
dataset1$Date <- sub("2/2/", "02/02/", dataset1$Date)
timepaste <- paste(dataset1$Date, dataset1$Time)
dataset1$timetype <- strptime(timepaste, format = "%d/%m/%Y %H:%M:%S")

# make the plot
par(mfrow = c(2,2))
# first plot2
plot(dataset1$timetype, dataset1$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")
# second
plot(dataset1$timetype, dataset1$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")
# third plot3
plot(dataset1$timetype, dataset1$Sub_metering_1, type = "n",
     ylab = "Energy sub metering", xlab = "")
lines(dataset1$timetype, dataset1$Sub_metering_1)
lines(dataset1$timetype, dataset1$Sub_metering_2, col = "red")
lines(dataset1$timetype, dataset1$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# forth
plot(dataset1$timetype, dataset1$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()