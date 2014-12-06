library(data.table)
data <- fread("household power.txt", skip=66637, data.table=FALSE)
colnames(data)[1:9] <- c("date","time","active","reactive","voltage", "intensity", "sub1", "sub2","sub3")
plot4 <- c("intensity")
plot4 <- data[,!names(data)%in%plot4]
plot4sub <- plot4[-(2881:2008623),]


bind <-paste(plot4sub$date,plot4sub$time,sep="_")
bind <-as.data.frame(bind)
b=1:2880
b<-as.data.frame(b)
a <-plot4sub[,-(1:2)]
a <-data.frame(b,plot4sub)
sub <-merge(b,a)
time <-data.frame(b,bind)
mergedata <-merge(time,sub)
mergedata <- mergedata[,-(3:4)]
library(lubridate)
mergedata$bind <- dmy_hms(mergedata$bind)  

png("plot4.png")
par(mfrow=c(2,2))
#plot graph (1,1)
mergedata$active <-as.numeric(mergedata$active)
plot(mergedata$bind,mergedata$active,type="l",ylab="Global Active Power",xlab="")
 #plot grapg(1,2)
mergedata$active <-as.numeric(mergedata$voltage)
plot(mergedata$bind,mergedata$voltage,type="l",ylab="Voltage",xlab="datetime")
#plot graph(2,1)
mergedata$sub1<-as.numeric(mergedata$sub1)
mergedata$sub2<-as.numeric(mergedata$sub2)
mergedata$sub3<-as.numeric(mergedata$sub3)
plot(mergedata$bind,mergedata$sub1,type="l",ylab="Energy sub metering",xlab="")
sub2<-lines(mergedata$bind,mergedata$sub2,col="red")
sub3<-lines(mergedata$bind,mergedata$sub3,col="blue")
mergedata$sub1<-as.numeric(mergedata$sub1)
mergedata$sub2<-as.numeric(mergedata$sub2)
mergedata$sub3<-as.numeric(mergedata$sub3)
plot(mergedata$bind,mergedata$sub1,type="l",ylab="Energy sub metering",xlab="")
sub2<-lines(mergedata$bind,mergedata$sub2,col="red")
sub3<-lines(mergedata$bind,mergedata$sub3,col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c('black', 'red', 'blue'),lty=1,cex=0.75)

#plotgraph (2,2)
mergedata$reactive <-as.numeric(mergedata$reacitve)
plot(mergedata$bind,mergedata$reactive,type="l",ylab="Global_reactive_power",xlab="datetime")

dev.off()
