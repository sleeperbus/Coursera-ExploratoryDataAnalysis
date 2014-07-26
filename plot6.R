## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)
 
motorVehicleSCC <- SCC[grep(" on-road", SCC$EI.Sector, ignore.case = T), c("SCC")]
# Select two cities, Baltimore and Los Angeles
cities <- subset(NEI, (fips == "24510" | fips == "06037") &  
                     SCC %in% motorVehicleSCC)
# change fips number to city name
cities$fips <- ifelse(cities$fips == "24510", "Baltimore", "Los Angeles")
# summary
summary <- ddply(cities, .(year, fips), summarise, sum = sum(Emissions))

png("plot6.png", width=480, height=480)  
ggplot(summary, aes(year, sum)) + geom_point(aes(col = fips)) + 
    geom_line(aes(col = fips)) + 
    geom_smooth(aes(col = fips), method="lm", linetype = 3, size = 2) +
    xlab("Year") + ylab("Emissions") + 
    ggtitle("Emissions from Baltimore and Los Angeles")
dev.off()
