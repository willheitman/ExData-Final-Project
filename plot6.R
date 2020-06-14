NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

Merged <- merge(NEI,SCC,by.x = "SCC",by.y = "SCC")

MotorVehicleNames <-unique(SCC$EI.Sector)[21:24]
MotorVehicle <- Merged[Merged$EI.Sector %in% MotorVehicleNames,]

MotorVehicleBalt <- subset(MotorVehicle,MotorVehicle$fips == "24510")
BaltVehYearSum <- tapply(MotorVehicleBalt$Emissions,MotorVehicleBalt$year,sum)
BaltVehEmissions <- data.frame(years = names(BaltVehYearSum),emissions =  BaltVehYearSum)
BaltVehEmissions$City <- "Baltimore"

MotorVehicleLA <- subset(MotorVehicle,MotorVehicle$fips == "06037")
LAVehYearSum <- tapply(MotorVehicleLA$Emissions,MotorVehicleLA$year,sum)
LAVehEmissions <- data.frame(years = names(LAVehYearSum),emissions =  LAVehYearSum)
LAVehEmissions$City <- "Los Angeles"

BaltAndLA <- rbind(BaltVehEmissions,LAVehEmissions)

png(filename = "plot6.png")
ggplot(data=BaltAndLA,aes(x=years,y=emissions,color=City,group=City)) + 
        geom_point() + 
        geom_line() + 
        ggtitle("Motor Vehicle Emissions: LA vs Baltimore") + 
        theme(plot.title = element_text(hjust = 0.5))
dev.off()





