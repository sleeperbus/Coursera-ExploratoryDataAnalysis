## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)

# subset Baltimore data from NEI 
baltimore <- subset(NEI, fips == "24510")
# To add all the emissions across US, group by year 
summary <- ddply(baltimore, .(year), summarise, sum = sum(Emissions))

png("plot2.png", width=480, height=480)
with(summary, 
     plot(year, sum, type = "l", xlab = "Year",  ylab = "Total Emissions",
          main = "Total Emissions for Baltimore(1999 ~ 2008)",
          col = "red"))
points(summary$year, summary$sum, pch = 19, col = "red", cex = 1)
dev.off()
