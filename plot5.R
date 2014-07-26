## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

# first I tried to see what values in Short.Name
# But I'm not convinced the result is right. It has all the junks like 'Motor
# Vehicles Fires' 
tmpIndex <- grep("veh", SCC$Short.Name, ignore.case = T)
unique(SCC$Short.Name[tmpIndex])

# Hm, Look at the EI.Sector. It looks like emissions sources.
# I could find On-Road blah, blah, blah... The data looks like what I need.
unique(SCC$EI.Sector)
listOnRoad <- SCC[grep(" on-road", SCC$EI.Sector, ignore.case = T), c("SCC")]   

# I subset the data only I needed
baltimore <- subset(NEI, fips == "24510" & SCC %in% listOnRoad)
summary <- ddply(baltimore, .(year), summarise, sum = sum(Emissions))
png("plot5.png", width=480, height=480)  
ggplot(summary, aes(year, sum)) + geom_line(col = "red") +
    geom_point(col = "blue") + xlab("Year") + ylab("Emissions") +
    ggtitle("Emissions from Motor Vehicles in Baltimore")  
dev.off()
