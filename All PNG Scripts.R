NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

yearsum <- tapply(NEI$Emissions,NEI$year,sum)
temissionsbytime <- data.frame(years = names(yearsum),emissions =  yearsum)
with(temissionsbytime,plot(years,emissions,type="n",main = "Total US Emissions"))
lines(temissionsbytime$years,temissionsbytime$emissions)


baltimoreNEI <- subset(NEI,NEI$fips == "24510")
baltimoreyearsum <- tapply(baltimoreNEI$Emissions,baltimoreNEI$year,sum)
baltimoreemissionsbytime <- data.frame(years = names(baltimoreyearsum),emissions =  baltimoreyearsum)
with(baltimoreemissionsbytime,plot(years,emissions,type="n", main = "Total Baltimore Emissions"))
lines(baltimoreemissionsbytime$years,baltimoreemissionsbytime$emissions)



baltimoreNEI$typeyear <- paste(baltimoreNEI$type,baltimoreNEI$year)
baltsums <- tapply(baltimoreNEI$Emissions,baltimoreNEI$typeyear,sum)
baltsumsframe <- data.frame(concat = names(baltsums), emissions = baltsums)
categories <- data.frame(t(data.frame(strsplit(baltsumsframe$concat," "))))
categories <- categories %>% rename(type = X1, year = X2)
baltsumsframe <- cbind(categories,baltsumsframe)
ggplot(baltsumsframe,aes(x=year,y=emissions,color=type,group=type)) +
        geom_point() + 
        geom_line()


library(dplyr)
library(ggplot2)
NEISumbyType <- data.frame()

for (i in unique(baltimoreNEI$type)) {
        NEIloopsubset <- subset(baltimoreNEI,baltimoreNEI$type == i)
        NEIlooptypesum <- tapply(NEIloopsubset$Emissions,NEIloopsubset$year,sum)
        NEISumbyType <- rbind(NEISumbyType,NEIlooptypesum)
}
     
names(NEISumbyType) <- names(baltimoreyearsum)
NEISumbyTypeTranspose <- data.frame(t(NEISumbyType))
names(NEISumbyTypeTranspose) <- unique(baltimoreNEI$type)
NEISumbyTypeTranspose <- cbind(NEISumbyTypeTranspose,names(yearsum))
NEISumbyTypeTranspose <- NEISumbyTypeTranspose %>% rename(years = `names(yearsum)`,ONROAD = 'ON-ROAD',NONROAD = 'NON-ROAD')

ggplot(NEISumbyTypeTranspose,aes(x=years, group = 1)) +
        geom_line(aes(y=POINT),color="red") + 
        geom_line(aes(y=NONPOINT),color="blue") + 
        geom_line(aes(y=ONROAD),color="green") + 
        geom_line(aes(y=NONROAD),color="purple") + 
        geom_lege



row.names(NEISumbyTypeTranspose)