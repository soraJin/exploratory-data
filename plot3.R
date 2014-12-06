library(data.table)
data <- fread("household power.txt", skip=66637, data.table=FALSE)
colnames(data)[1:9] <- c("date","time","active","reactive","voltage", "intensity", "sub1", "sub2","sub3")
plot3 <- c("date", "time","sub1","sub2","sub3")
plot3 <- data[,names(data)%in%plot3]
plot3sub <- plot3[-(2881:2008623),]


bind <-paste(plot3sub$date,plot3sub$time,sep="_")
bind <-as.data.frame(bind)
b=1:2880
b<-as.data.frame(b)
a <-plot3sub[,-(1:2)]
a <-data.frame(b,plot3sub)
sub <-merge(b,a)
time <-data.frame(b,bind)
mergedata <-merge(time,sub)


#plot the graph
mergedata$sub1<-as.numeric(mergedata$sub1)
mergedata$sub2<-as.numeric(mergedata$sub2)
mergedata$sub3<-as.numeric(mergedata$sub3)
library(lubridate)
mergedata$bind <- dmy_hms(mergedata$bind)

png("plot3.png")
plot(mergedata$bind,mergedata$sub1,type="l",ylab="Energy sub metering",xlab="")
sub2<-lines(mergedata$bind,mergedata$sub2,col="red")
sub3<-lines(mergedata$bind,mergedata$sub3,col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c('black', 'red', 'blue'),lty=1,cex=0.75)
dev.off()
