library(data.table)
data <- fread("household power.txt", skip=66637, data.table=FALSE)
colnames(data)[1:9] <- c("date","time","active","reactive","voltage", "intensity", "sub1", "sub2","sub3")
plot2 <- c("date", "time","active")
plot2 <- data[,names(data)%in%plot2]
plot2sub <- plot2[-(2881:2008623),]

b=1:2880
b<-data.frame(b)
a <-plot2sub[,-(1:2)]
a<-data.frame(b,plot2sub)
active <-date.frame(b,a)
bind <-paste(plot2sub$date,plot2sub$time,sep="_")
bind <-as.data.frame(bind)
time <-data.frame(b,bind)
mergedata <-merge(time,active)

transform <-strptime(mergedata$time,format="%d/%m/%Y_%H:%M:%S")  

#plot the graph
xvalue<-as.character(mergedata$active)
xvalue<-as.numeric(xvalue)

mergedata$active=as.numeric(mergedata$active)
plot(mergedata$time,mergedata$active,type="l",ylab="Global Active Power(kilowatts)",xlab="")
