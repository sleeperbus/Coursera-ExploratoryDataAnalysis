## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
# I know there is issue that each year does not have same observation
# size. But I ignore that thing and just add total emissions 
# To add all the emissions across US, group by year 
summary <- ddply(NEI, .(year), summarise, sum = sum(Emissions))

# make a plot
png("plot1.png", width=480, height=480)
with(summary, 
     plot(year, sum, type = "l", xlab = "Year",  ylab = "Emissions",
          main = "Total Emissions from 1999 to 2008",
          col = "red"))
points(summary$year, summary$sum, pch = 19, col = "red", cex = 1)
dev.off()
