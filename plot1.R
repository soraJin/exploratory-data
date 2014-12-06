
library(data.table)
data <- fread("household power.txt", skip=66637, data.table=FALSE)
colnames(data)[1:9] <- c("date","time","active","reactive","voltage", "intensity", "sub1", "sub2","sub3")
plot1 <- c("data", "time","active")
plot1 <- data[,names(data)%in%plot1]
plot1sub <- plot1[-(2881:2008623),]

#combine date and time by creating new data frame "time", creat common column in 
#both data frame "time" and "active"
bind <-paste(plot1sub$date,plot1sub$time,sep="_")
bind <-as.data.frame(bind)
b=1:2880
b<-data.frame(b)
a <-plot1sub[,-(1:2)]
active <-date.frame(b,a)
time <-data.frame(b,bind)
mergedata <-merge(time,active)

#transform the class of time make sure the format of code is consistent with the format
#in the data frame
transform <-strptime(mergedata$time,format="%d/%m/%Y_%H:%M:%S")  

#plot the graph
xvalue<-as.as.character(mergedata$active)
xvalue<-as.numeric(xvalue)
hist(xvalue,col="red", breaks=12, main="Global Active Power", xlab="Global Active Power(kilowatts)")
