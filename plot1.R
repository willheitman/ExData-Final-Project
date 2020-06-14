NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

yearsum <- tapply(NEI$Emissions,NEI$year,sum)
temissionsbytime <- data.frame(years = names(yearsum),emissions =  yearsum)

png(filename = "plot1.png")
with(temissionsbytime,plot(years,emissions,type="n",main = "Total US Emissions"))
lines(temissionsbytime$years,temissionsbytime$emissions)
dev.off()