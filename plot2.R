# for read data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./fc.zip")
unzip("./fc.zip")
dataset <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

# change the type of data and select the date between 20070201 to 20070202
dataset$Date <- as.character(dataset$Date) 
dataset1 <- subset(dataset, (Date == "1/2/2007")|(Date == "2/2/2007"))
dataset1$Date <- as.character(dataset1$Date) 
dataset1$Global_active_power <- as.numeric(as.character(dataset1$Global_active_power))
dataset1$Date <- sub("1/2/", "01/02/", dataset1$Date)
dataset1$Date <- sub("2/2/", "02/02/", dataset1$Date)
timepaste <- paste(dataset1$Date, dataset1$Time)
dataset1$timetype <- strptime(timepaste, format = "%d/%m/%Y %H:%M:%S")

# make the plot
par(mfrow = c(1,1))
plot(dataset1$timetype, dataset1$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()