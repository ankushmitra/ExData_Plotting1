# plot1.R 
# This code reproduces plot 1 - a histogram of the global active power

# Load the data 
loadData <- function(datafilename) 
{
        # Load the CSV file : Only read in the data from 2007-02-01 to 2007-02-02, 
        # which corresponds to lines 66638-69517                
        df <- read.csv(file=datafilename,
                       header=FALSE,
                       sep=";",
                       na.strings="?",
                       colClasses=c("character","character", rep("numeric",7)),
                       skip=66637,nrows=2879
                        )
                 
        # Set up the column names
        # (as we skipped the first row that had the column names)       
        colnames(df) <- c("Date","Time",
                         "Global_active_power","Global_reactive_power",
                         "Voltage","Global_intensity",
                         "Sub_metering_1","Sub_metering_2","Sub_metering_3")
        
        # The first two columns are date and time as characters
        # => convert them to date-time R objects and append as new column DateTime
        library(lubridate)
        df$DateTime <- dmy_hms(paste(df$Date,df$Time))  

        # Return the data-frame
        df
}


# Function to create plot 1 - a histogram of the Global Active Power
plot1 <- function () 
{
        # Load the data 
        power_df <- loadData("household_power_consumption.txt")        
        
        # Setup the output png file (480x480 pixels)
        png("plot1.png",width=480,height=480,units="px")

        # Create the plot
        hist(power_df$Global_active_power, col="red",
             main="Global Active Power",xlab="Global Active Power (kilowatts)")
        
        # close the device
        dev.off()        
}
        
        
        