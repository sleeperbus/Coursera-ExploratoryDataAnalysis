## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

# subset Baltimore data from NEI 
baltimore <- subset(NEI, fips == "24510") 
# To add all the emissions across US, group by year and type
summary <- ddply(baltimore, .(year, type), summarise, sum = sum(Emissions))

png("plot3.png", width=480, height=480)  
ggplot(summary, aes(year, sum)) + geom_line(aes(col=type)) + 
    geom_point(aes(col=type), pch = 1, pex = 2) + 
    xlab("Year") + ylab("Emissions") + ggtitle("Emissions by Type(1998 ~ 2008)")

dev.off()
