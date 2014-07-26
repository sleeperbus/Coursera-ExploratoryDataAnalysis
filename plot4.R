## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

# There is no exact category, no explanation where I can get coal data. 
# But two variables, Short.Name and EI.Sector is suitable for coal data.
# subset indices of two variables and union two vectors to make one big index
listEI.Sector <- SCC$SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE)]
listShort.Name <- SCC$SCC[grep("coal", SCC$Short.Name, ignore.case = TRUE)]
fullList <- union(listEI.Sector, listShort.Name)
coalData <- subset(NEI, SCC %in% fullList)
summary <- ddply(coalData, .(year), summarise, sum = sum(Emissions))

png("plot4.png", width=480, height=480)  
ggplot(summary, aes(year, sum)) + geom_line(col = "red") +
    geom_point(col = "blue", pch = 19, pex = 1) + xlab("Year") + ylab("Emissions") +
    ggtitle("Emissions from Coal")  
dev.off()
