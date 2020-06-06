library(ggplot2)
library(tidyverse)
library(lubridate)


alldates<-read.csv("data/All Transmissions in Construction Site.csv")

# Create a new variable Date2
alldates %>% mutate(Date2 = as.Date(Date, format = "%m/%d/%y")) -> alldates

# dates<-alldates$Date
# turtles<-alldates$Tag.ID
# dv<-alldates$Diel.Vagility
# 
# 
# dates = as.Date(dates, format = "%m/%d/%y")
# 
# 
# class(dates)
# print(dates)

p<-ggplot(data = alldates)+
  #aes(dates, dv, color = turtles)+
  geom_point(aes(x = dates, 
                 y = Diel.Vagility),
             size=0.75)+
  scale_x_date(date_labels="%m/%Y",
               date_breaks  ="3 months")+
  xlab("Transmission Dates")+
  ylab("Diel Vagility")+
  ggtitle("Diel Vagility by Date")+
  labs(colour="Tag-ID")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
p
