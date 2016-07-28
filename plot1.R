# for read data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./fc.zip")
unzip("./fc.zip")
dataset <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

# change the type of data and select the date between 20070201 to 20070202
dataset$Date <- as.character(dataset$Date) 
dataset1 <- subset(dataset, (Date == "1/2/2007")|(Date == "2/2/2007"))
dataset1$Global_active_power <- as.numeric(as.character(dataset1$Global_active_power))

# make the plot
par(mfrow = c(1,1))
hist(dataset1$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)"
     ,main = "Global Active Power")
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
