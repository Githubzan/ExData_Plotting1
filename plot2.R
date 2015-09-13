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

#Code for plot2.R#
with(data2,{
        plot(DateTime,as.numeric(as.character(Global_active_power)),type = "l",xlab="",ylab="Global Active Power (kilowatts)")}
)

dev.copy(png,file="plot2.png")
dev.off()