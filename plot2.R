##############################################################################
# 
# 1. This is a standalone file to produce Plot 2 from Assignment 1
# 2. The steps are as follows:
#         - Step 1. Download raw zipped data from the web if it has not been 
#                   downloaded yet
#         - Step 2. Reading data into data.frame (as part of assignment)
#         - Step 3. Converting Date/Time columns to POSIXt class
#         - Step 4. Subsetting to 2007-02-01:2007-02-02
#         - Step 5. Making plot on screen
#         - Step 6. Exporting to png
#         (Steps 1-4 are the same for all plots; only 5-6 differ)
# 3. The code was run on:
#          OS: UBUNTU 12.04.4 x64
#         IDE: RStudio 0.98.953
#           R: 3.1.1
#
##############################################################################

# Step 1. Download raw zipped data from the web if it has not been downloaded yet

if (!file.exists("tmP.zip")) {
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url = url,
                      destfile = "tmP.zip",
                      method = "curl")
        dateDownloaded <- Sys.time()
}
dateDownloaded

# Step 2. Reading data into data.frame (as part of assignment)

con <- unz("tmP.zip", "household_power_consumption.txt")
powerConsumption <- read.table(file = con,
                               header = T,
                               sep = ";",
                               stringsAsFactors = F,
                               na.strings = "?")

# Step 3. Converting Date/Time columns to POSIXt class

powerConsumption$DateTime <- paste(powerConsumption$Date, powerConsumption$Time)
head(powerConsumption$Date)
powerConsumption$DateTime <- strptime(powerConsumption$DateTime, 
                                      "%d/%m/%Y %H:%M:%S",
                                      tz = "GMT")


# Step 4. Subsetting to 2007-02-01:2007-02-02

begin <- as.POSIXlt("2007-02-01", "%Y-%m-%d", tz = "GMT")
end <- as.POSIXlt("2007-02-03", "%Y-%m-%d", tz = "GMT")
plottingDataSubset <- powerConsumption[powerConsumption$DateTime >= begin & powerConsumption$DateTime < end, ]

# Step 5. Make plot 2 on screen
plot(x = plottingDataSubset$DateTime,
     y = plottingDataSubset$Global_active_power,
     type = "l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     main= "")

# Step 6. Export to png
dev.copy(png,
         file = "plot2.png",
         height = 480,
         width = 480,
         unit = "px")
dev.off()

# END


