NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

Merged <- merge(NEI,SCC,by.x = "SCC",by.y = "SCC")
CoalNames <- unique(SCC$EI.Sector)[grep("Coal",unique(SCC$EI.Sector))]
CoalSources <- Merged[Merged$EI.Sector %in% CoalNames,]

coalyearsum <- tapply(CoalSources$Emissions,CoalSources$year,sum)
tcoalemissionsbytime <- data.frame(years = names(coalyearsum),emissions =  coalyearsum)

png(filename = "plot4.png")
with(tcoalemissionsbytime,plot(years,emissions,type="n",main = "Total US Coal Emissions"))
lines(tcoalemissionsbytime$years,tcoalemissionsbytime$emissions)
dev.off()