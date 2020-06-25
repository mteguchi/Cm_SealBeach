#----------------Calculating Home Range using bivariate normal kernel---------------
library(sp)
library(adehabitatHR)

#Reading csv
turtles<-read.csv("152310-Filtered.csv",stringsAsFactors = FALSE)

#Creating a dataframe "xy" that contains name,x and y 
xy <- data.frame(Name = turtles$Name, X=turtles$Longitude, Y=turtles$Latitude)

#making R recognize x and y as coordinates
coordinates(xy) <- c("X", "Y")

#assigning the type and specifying the spatial reference system
proj4string(xy) <- CRS("+proj=longlat +datum=WGS84")

#taking xy from lat lon to UTM and assigning zone 11 for Seal Beach
#this also makes it a SpatialPointsDataFrame
xy.sp<- spTransform(xy, CRS("+proj=utm +zone=11 ellps=WGS84 +units=m"))
xy.sp

str(xy.sp)

#this is xy as just spatial points and not a dataframe in case needed
xy2<-SpatialPoints(xy.sp)
str(xy2)

#Looking at Polygon shape
clu<-clusthr(xy2)
class(clu)
plot(clu)

#FROM HERE IT IS JUST PRACTICE AND FOLLOWING THE GUIDE

#Looking at the smoothing parameter "h"
#"The smoothing factor is the distance over which a data point 
#influences the utlization distribution. A larger h results in 
#more smoothing and increases home range size estimates."
kud<-kernelUD(xy.sp[,1],h="href")
kud
image(kud)

#the value of h is sotred in the slot for "h," this is how to 
#access it. h= 1962.503.....pretty big 
kud[[1]]@h

#Can also find h using Least Square Cross Validation

kudl<-kernelUD(xy.sp[,1], h="LSCV")
image(kudl)
plotLSCV(kudl)
#no dip in the h parameter, this means there is no minimum
#which means there is no convergence
#When the algorithm does not converge toward a solution, 
#the estimate should not be used in further analysis. 
#so use href instead of LSCV?

#location dataframe
locs<-xy.sp
firs<-locs[as.data.frame(locs)[,1]=="152310",]
print(firs)

par(mar=c(0,0,2,0))
par(mfrow=c(2,2))

#setting grid and extent of kernel of UD
image(kernelUD(firs, grid=80, extent=0.2))
title(main="grid=80, extent=0.2")

kus<-kernelUD(xy.sp[,1],same4all = TRUE)
image(kus)

ii<-estUDm2spixdf(kus)
class(ii)

#Looking at polygon of home range
homerange<-getverticeshr(kud)
class(homerange)
plot(homerange, col=4)

#Switched back to "kud" instead of "kudl" because LSCV did not work, had to use href instead. 
#This is a plot of the volume under the Utilization Distribution
vud<-getvolumeUD(kud)
vud
print(vud)

#Volume and contour of the UD
par(mfrow=c(2,1))
par(mar=c(0,0,2,0))
image(kud[[1]])
title("Output of KernelUD")
xyz<-as.image.SpatialGridDataFrame(kud[[1]])
contour(xyz, add=TRUE)
par(mar=c(0,0,2,0))
image(vud[[1]])
title("Output of getvolumeUD")
xyzv<-as.image.SpatialGridDataFrame(vud[[1]])
contour(xyzv, add = TRUE)


fud<-vud[[1]]
hr95<-as.data.frame(fud)[,1]
hr95<-as.numeric(hr95<=95)
hr95<-data.frame(hr95)
coordinates(hr95)<-coordinates(vud[[1]])
gridded(hr95)<-TRUE
image(hr95)

#UD for 50%-95% 
as.data.frame(homerange)
ii<-kernel.area(kud, percent=seq(50,95,by=5))
ii

