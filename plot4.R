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
# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
submydata$Date <- as.Date(submydata$Date, format="%d/%m/%Y")
submydata$Time <- strptime(submydata$Time, format="%H:%M:%S")
submydata[1:1440,"Time"] <- format(submydata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
submydata[1441:2880,"Time"] <- format(submydata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")







# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(submydata,{
  plot(submydata$Time,as.numeric(as.character(submydata$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(submydata$Time,as.numeric(as.character(submydata$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(submydata$Time,submydata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(submydata,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(submydata,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(submydata,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(submydata$Time,as.numeric(as.character(submydata$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})