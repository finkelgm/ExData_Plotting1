#Prepare the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile= "~/cons.zip")
unzip("~/cons.zip")
household_power_consumption <- read.csv("~/household_power_consumption.txt", sep=";",stringsAsFactors=FALSE, 
                                        header = TRUE,dec = ".",na.strings = "?",
                                        colClasses = c(rep('character',2),rep('numeric',7)))
household_power_consumption$DDate<-
  strptime(paste(household_power_consumption$Date,household_power_consumption$Time),"%d/%m/%Y %H:%M:%S")
# Make the short dataset (only 2 days)
HPCCut<-subset(household_power_consumption,DDate>=strptime("1.02.2007","%d.%m.%Y") & DDate<strptime("3.02.2007","%d.%m.%Y"))
# Plot 1
with(HPCCut,{
  png("plot1.png")
  hist(Global_active_power,main="Global Active Power",xlab = "Global Active Power (kilowatts)", col="Red")
  dev.off()
})
# Plot 2
with(HPCCut,{
  png("plot2.png")
  plot(y=Global_active_power,x=DDate,type = "l",ylab = "Global Active Power (kilowatts)",xlab = "") #main="Global Active Power",xlab = "Global Active Power (kilowatts)", col="Red")
  dev.off()
})
#Plot 3
with(HPCCut,{
  png("plot3.png")
  plot(x=DDate,y=Sub_metering_1,type="n",ylab = "Energy Sub metering",xlab="")
  lines(x=DDate,y=Sub_metering_1,col="Black",lty=1)
  lines(x=DDate,y=Sub_metering_2,col="Red",lty=1)
  lines(x=DDate,y=Sub_metering_3,col="Blue",lty=1)
  legend("topright", lty=1, col = c("Black", "red","Blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  dev.off()
})
# Plot 4
with(HPCCut,{
  png("plot4.png")
  par(mfrow=c(2,2),mar=c(4,4,1,1))
  plot(y=Global_active_power,x=DDate,type = "l",ylab = "Global Active Power",xlab = "")
  plot(y=Voltage,x=DDate,type = "l",ylab = "Voltage",xlab = "datetime")
  plot(x=DDate,y=Sub_metering_1,type="n",ylab = "Energy Sub metering",xlab="")
  lines(x=DDate,y=Sub_metering_1,col="Black",lty=1)
  lines(x=DDate,y=Sub_metering_2,col="Red",lty=1)
  lines(x=DDate,y=Sub_metering_3,col="Blue",lty=1)
  legend("topright", lty=1, col = c("Black", "red","Blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(y=Global_reactive_power,x=DDate,type = "l",ylab = "Global reactive power",xlab = "datetime")
  dev.off()
})
