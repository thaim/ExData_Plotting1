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


# plot as plot2

# define function to plot into file and display windows in same parameter
draw <- function() {
  # do not draw x axis ticks with xaxt="n"
  plot(dataset$Global_active_power,
       xlab="", ylab="Global Active Power (kilowatts)",
       type="l", xaxt="n")

  # assume dataset contains 2*24*60=2880 data and sorted in date/time
  axis(1,
       at=c(0, nrow(dataset)/2, nrow(dataset)),
       labels=c("Thu", "Fri", "Sat"))
}

# plot in display windows
draw()

# plot in file
# width = 480, height = 480 is default parameter for grDevices functions.
png(filename="plot2.png")
draw()
dev.off()
