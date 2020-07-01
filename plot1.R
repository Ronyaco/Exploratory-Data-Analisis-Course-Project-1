
#Downloading, unzipping the data
activity_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(activity_url, temp, destfile = "C:\Users\Moral\Documents\database" )
unzip(temp, "household_power_consumption.txt")
#Reading the dataset 
mydata <- read.table("household_power_consumption.txt", skip =1, sep = ";" )
unlink(temp)
# adding the names to the rows in table
names(mydata) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#Subsetting the data within the range of dates 2007-02-01 and 2007-02-02
submydata <- subset(mydata,mydata$Date=="1/2/2007" | mydata$Date =="2/2/2007")
# Creating the histogram
hist(as.numeric(as.character(submydata$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
