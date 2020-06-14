NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreNEI <- subset(NEI,NEI$fips == "24510")
baltimoreyearsum <- tapply(baltimoreNEI$Emissions,baltimoreNEI$year,sum)
baltimoreemissionsbytime <- data.frame(years = names(baltimoreyearsum),emissions =  baltimoreyearsum)

png(filename = "plot2.png")
with(baltimoreemissionsbytime,plot(years,emissions,type="n", main = "Total Baltimore Emissions"))
lines(baltimoreemissionsbytime$years,baltimoreemissionsbytime$emissions)
dev.off()