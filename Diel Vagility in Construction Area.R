library(ggplot2)
library(tidyverse)
library(lubridate)


alldates<-read.csv("All Transmissions in Construction Site.csv")



dates<-alldates$Date
turtles<-alldates$Tag.ID
dv<-alldates$Diel.Vagility


dates = as.Date(dates, format = "%m/%d/%y")


class(dates)
print(dates)



p<-ggplot()+
  aes(dates, dv, color = turtles)+
  geom_point(size=0.75)+
  scale_x_date(date_labels="%m/%d",date_breaks  ="1 day")+
  xlab("Transmission Dates")+
  ylab("Diel Vagility")+
  ggtitle("Diel Vagility by Date")+
  labs(colour="Tag-ID")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
p
