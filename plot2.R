#######################################################################################
#                                                                                     #
# Author: Anderson Hitoshi Uyekita                                                    #
# Exploratory Data Analysis                                                           #
# Course Project 02 - Week 3 - Coursera                                               #
# File: plot2.R                                                                       #
#                                                                                     #
#######################################################################################

############################### 1. Work Directory #####################################
# Saving the original work directory
root_original <- getwd()

# All manipulation data will start in the root.
setwd("~")

################################ 2. Work Directory ####################################
# Create a project directory
if(!file.exists("Project02"))
{
        dir.create("Project02")
}

# Set as Work Directory
setwd("Project02")

################################ 3. Download Data #####################################
library(httr) 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("FNEI_data.zip"))
{
        download.file(url, "FNEI_data.zip")
}

# Removing the URL
rm(url)

# Unzipping the power_consumption file
if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
{
        unzip("FNEI_data.zip", list = FALSE, overwrite = TRUE)
}

file_unzipped <- c("./Source_Classification_Code.rds","./summarySCC_PM25.rds")

################################ 4. Loading the data ##################################
raw_dataset = list(data.frame(),data.frame())

for (i in 1:length(file_unzipped))
{
        raw_dataset[[i]] <- readRDS(file_unzipped[i])
}

names(raw_dataset) <- c("SCC","NEI")


rm(file_unzipped)

#################################### 5. Plot 2  #######################################
baltimore <- subset(raw_dataset$NEI, raw_dataset$NEI$fips == "24510")

with(baltimore, {
        
        png(filename = "plot2.png")  
        
        y <- baltimore$Emissions
        x <- baltimore$year
        plot_data <- tapply(y, x, FUN = sum)
        
        barplot(plot_data, main = expression('Total PM'[2.5] ~ ' in Baltimore City'), ylab = expression('PM'[2.5] ~ 'Emissions'), xlab = "Year")
        
        dev.off()
        
})
