# Problem 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, 

# which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? 
# Answer:
# nonroad, nonpoint, onroad.

# Which have seen increases in emissions from 1999–2008?
# Answer:
# point.

# Load the NEI & SCC data frames.
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subset NEI data by Baltimore's fip.
library(plyr)
library(ggplot2)

subsetNEI <- NEI[which(NEI$fips == "24510"), ]

baltimoreNEI <- with(subsetNEI, 
                     aggregate(Emissions, by = list(year), sum))
colnames(baltimoreNEI) <- c("year", "Emissions")

baltimoreType <- ddply(subsetNEI, .(type, year), 
                       summarize, Emissions = sum(Emissions))

# Open the PNG device
png(filename = "plot3.png", width = 480, height = 480, 
    units = "px", bg = "transparent")

# Plot the annual emission
qplot(year, Emissions, data = baltimoreType, group = type, 
      color = type, geom = c("point", "line"), 
      ylab = expression("Total Emissions, PM2.5"), 
      xlab = "Year", main = "Total Emissions of Different Pollutant")


# Close the PNG device
dev.off()