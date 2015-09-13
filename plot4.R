#Common Code for reading data#

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile ="./data/data.zip")
unzip("./data/data.zip")

data<-read.table(file = "./data/household_power_consumption.txt",header = TRUE,sep = ";")
str(data)
head(data)
tail(data)
names(data)
lapply(data,class)

data$DateTime<-paste(data$Date,data$Time)
class(data$DateTime)
#Conversion to date format
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")       
class(data$DateTime)
head(data$DateTime,100)
# Subsetting for the stipulated dates
data2<-subset(data,subset = data$DateTime>="2007-02-01 00:00:00" & data$DateTime<="2007-02-02 23:59:00")
str(data2)
head(data2)
tail(data2)
names(data2)
lapply(data2,class)

#Code for plot4.R#

par(mfcol=c(2,2))

plot(data2$DateTime, as.numeric(as.character(data2$Global_active_power)),type='l',ylab="Global Active Power", xlab="")

plot(data2$DateTime, as.numeric(as.character(data2$Sub_metering_1)),type='l', xlab="",ylab ="Energy sub metering")
lines(data2$DateTime, as.numeric(as.character(data2$Sub_metering_2)),type='l', col='red')
lines(data2$DateTime, data2$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"))

plot(data2$DateTime, as.numeric(as.character(data2$Voltage)),type='l', 
     ylab="Voltage",xlab="datetime" )

plot(data2$DateTime, as.numeric(as.character(data2$Global_reactive_power)),type='l', 
     ylab="Global_reactive_power",xlab="datetime" )

dev.copy(png,file="plot4.png")
dev.off()