NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

baltimoreNEI <- subset(NEI,NEI$fips == "24510")
baltimoreNEI$typeyear <- paste(baltimoreNEI$type,baltimoreNEI$year)
baltsums <- tapply(baltimoreNEI$Emissions,baltimoreNEI$typeyear,sum)
baltsumsframe <- data.frame(concat = names(baltsums), emissions = baltsums)
categories <- data.frame(t(data.frame(strsplit(baltsumsframe$concat," "))))
categories <- categories %>% rename(type = X1, year = X2)
baltsumsframe <- cbind(categories,baltsumsframe)

png(filename = "plot3.png")
ggplot(baltsumsframe,aes(x=year,y=emissions,color=type,group=type)) +
        geom_point() + 
        geom_line()
dev.off()