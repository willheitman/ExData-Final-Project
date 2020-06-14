NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

Merged <- merge(NEI,SCC,by.x = "SCC",by.y = "SCC")

MotorVehicleNames <-unique(SCC$EI.Sector)[21:24]
MotorVehicle <- Merged[Merged$EI.Sector %in% MotorVehicleNames,]

MotorVehicleBalt <- subset(MotorVehicle,MotorVehicle$fips == "24510")
vehicleyearsum <- tapply(MotorVehicleBalt$Emissions,MotorVehicleBalt$year,sum)
baltvehicleemissionsbytime <- data.frame(years = names(vehicleyearsum),emissions =  vehicleyearsum)

png(filename = "plot5.png")
with(baltvehicleemissionsbytime,plot(years,emissions,type="n",main = "Baltimore Motor Vehicle Emissions"))
lines(baltvehicleemissionsbytime$years,baltvehicleemissionsbytime$emissions)
dev.off()
