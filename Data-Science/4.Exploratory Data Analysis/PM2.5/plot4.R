# Problem 4:
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

# Answer:
# Coal combustion related sources decreased significantly from 1999 to 2008.

# Load the NEI & SCC data frames.
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subset NEI data by coal combustion.
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustion & coal)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

# Open the PNG device
png(filename = "plot4.png", width = 480, height = 480, units="px", bg="transparent")

# Plot the distribution of the coal combustion.
library(ggplot2)

ggp <- ggplot(combustionNEI, aes(factor(year), Emissions / 10^5), col = "red") +
  geom_bar(stat = "identity", fill = "grey", width = 0.75) +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM2.5 Emission (10^5 Tons)")) + 
  labs(title = expression("PM2.5 Coal Combustion from 1999-2008"))

print(ggp)


# Close the PNG device
dev.off()