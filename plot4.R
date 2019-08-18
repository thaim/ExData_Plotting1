# download and extract original data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/Dataset.zip", method="curl")

# unarchive downloaded data
unzip("data/Dataset.zip", exdir = "data")
datasetFile <- "data/household_power_consumption.txt"

# load data from file
dataset <- read.table(datasetFile, sep=";", header=TRUE,
                      colClasses=c("character", "character", rep("numeric", 7)),
                      na.strings="?")
dataset$Date = as.Date(dataset$Date, format="%d/%m/%Y")

# We will only be using data from the dates 2007-02-01 and 2007-02-02
dataset = dataset[dataset$Date >= as.Date("2007-02-01") &
                    dataset$Date <= as.Date("2007-02-02"),]


# plot as plot4

# define function to plot into file and display windows in same parameter
draw <- function() {
  
  par(mfcol = c(2, 2))
  
  # plot similar to plot2
  plot(dataset$Global_active_power,
       xlab="", ylab="Global Active Power",
       type="l", xaxt="n")
  axis(1,
       at=c(0, nrow(dataset)/2, nrow(dataset)),
       labels=c("Thu", "Fri", "Sat"))

  
  # plot similar to plot3  
  plot(dataset$Global_active_power,
       xlab="", ylab="Energy sub metering",
       type="n", xaxt="n", yaxt="n", ylim=c(0, 40))
  axis(1,
       at=c(0, nrow(dataset)/2, nrow(dataset)),
       labels=c("Thu", "Fri", "Sat"))
  axis(2, at=c(0, 10, 20, 30))
  lines(dataset$Sub_metering_1)
  lines(dataset$Sub_metering_2, col = "red")
  lines(dataset$Sub_metering_3, col = "blue")
  # remove the box line arround the legend with bty="n"
  # show legend smaller by cex = 0.75
  legend("topright", bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col=c("black", "red", "blue"), lty=c(rep(1, 3)), cex = 0.75)
  
  # plot topright
  plot(dataset$Voltage,
       xlab="datetime", ylab="Voltage",
       type="l", xaxt="n")
  axis(1,
       at=c(0, nrow(dataset)/2, nrow(dataset)),
       labels=c("Thu", "Fri", "Sat"))
  
  # plot bottomright
  plot(dataset$Global_reactive_power,
       xlab="datetime", ylab="Global_reactive_power",
       type="l", xaxt="n", yaxt="n")
  axis(1,
       at=c(0, nrow(dataset)/2, nrow(dataset)),
       labels=c("Thu", "Fri", "Sat"))
  # show axis annotation smaller by cex.axis=0.75
  axis(2, cex.axis=0.75,
       at=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))
}


# plot in display windows
draw()


# plot in file
# width = 480, height = 480 is default parameter for grDevices functions.
png(filename="plot4.png")
draw()
dev.off()
