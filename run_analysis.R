#1
test.labels <- read.table("./UCI/test/y_test.txt",col.names="label")
test.subjects <- read.table("./UCI/test/subject_test.txt",col.names="subject")
test.data <- read.table("./UCI/test/X_test.txt")
train.labels <- read.table("./UCI/train/y_train.txt",col.names="label")
train.subjects <- read.table("./UCI/train/subject_train.txt",col.names="subject")
train.data <- read.table("./UCI/train/X_train.txt")

data <- rbind(cbind(test.subjects, test.labels, test.data), cbind(train.subjects, train.labels, train.data))

#2
features <- read.table("./UCI/features.txt",strip.white=T,stringsAsFactors=F)
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)",features$V2),]

data.mean.std<- data[,c(1,2,features.mean.std$V1+2)]

#3
labels <- read.table("./UCI/activity_labels.txt",stringsAsFactors=F)
data.mean.std$label <- labels[data.mean.std$label,2]

#4
good.colnames <- c("subject","label",features.mean.std$V2)
good.colnames <- tolower(gsub("[^[:alpha:]]","",good.colnames))
colnames(data.mean.std) <- good.colnames

#5
aggr.data <- aggregate(data.mean.std[,3:ncol(data.mean.std)],by=list(subject=data.mean.std$subject,label=data.mean.std$label),mean)

#write
write.table(format(aggr.data,scientific=T),"tidy.txt",row.names=F,col.names=F,quote=2)