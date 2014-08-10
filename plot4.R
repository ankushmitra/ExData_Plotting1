# plot4.R 
# This code reproduces plot 4 - grid of 4 plots arranged in a 2x2 grid
# -     top-left: Global active power vs time
# -    top-right: Voltage vs time
# -  bottom-left: The 3 sub-metering values vs time
# - bottom-right: Global reactive power vs time

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


# creates top-left plot: Global active power vs time
top_left_plot <- function(power_df) 
{        
        # Create the plot
        plot(power_df$DateTime,power_df$Global_active_power,type="l",col="black",
             xlab="", ylab="Global Active Power")
}

# creates top-right: Voltage vs time
top_right_plot <- function(power_df)
{
        plot(power_df$DateTime,power_df$Voltage,type="l",col="black",
             xlab="datetime",ylab="Voltage")        
}

# Creates the bottom-left plot: The 3 sub-metering values vs time
bottom_left_plot <- function(power_df)
{
        # - Plot Sub-metering 1 vs time in black        
        with(power_df, plot(DateTime,Sub_metering_1,type="l",col="black",
                            ylab="Energy Sub metering",xlab=""))

        # - Plot Sub-metering 2 vs time in red
        with(power_df, points(DateTime,Sub_metering_2,type="l",col="red"))        

        # - Plot Sub-metering 3 vs time in blue
        with(power_df, points(DateTime,Sub_metering_3,type="l",col="blue"))        

        # - Add legend
        legend("topright",
                col=c("black","red","blue"),lwd=1,
                legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                bty="n"
                )
        
}

# creates bottom-right: Global reactive power vs time
bottom_right_plot <- function(power_df)
{
        plot(power_df$DateTime,power_df$Global_reactive_power,
             xlab="datetime", ylab="Global_reactive_power",
             col="black",pch=19,type="l")
}



# This code reproduces plot 4 - grid of 4 plots arranged in a 2x2 grid
# -     top-left: Global active power vs time
# -    top-right: Voltage vs time
# -  bottom-left: The 3 sub-meterting values vs time
# - bottom-right: Global reactive power vs time
plot4 <- function () 
{
        # Load the data 
        power_df <- loadData("household_power_consumption.txt")        
        
        # Setup the output png file (480x480 pixels)
        png("plot4.png",width=480,height=480,units="px")
        
        # Create the 2x2 grid
        par(mfrow=c(2,2))
        # make the 4 plots
        top_left_plot(power_df)
        top_right_plot(power_df)
        bottom_left_plot(power_df)
        bottom_right_plot(power_df)
        
        # close the device
        dev.off()        
}
