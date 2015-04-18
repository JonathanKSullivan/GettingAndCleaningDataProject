test<-read.table("X_test.txt")
train<-read.table("X_train.txt")
merged<-rbind(test,train)
names_of_columns<-read.table("features.txt")
names(meanmem)<-names_of_columns[,2]
names(sdmem)<-names_of_columns[,2]
names(test)<-names_of_columns[,2]
names(train)<-names_of_columns[,2]
names(merged)<-names_of_columns[,2]
test_rank<-read.table("y_test.txt")
test_sub<-read.table("subject_test.txt")
test_rank<- replace(test_rank, test_rank==1, "WALKING")
test_rank<- replace(test_rank, test_rank==2, "WALKING_UPSTAIRS")
test_rank<- replace(test_rank, test_rank==3, "WALKING_DOWNSTAIRS")
test_rank<-replace(test_rank, test_rank==4, "SITTING")
test_rank<-replace(test_rank, test_rank==5, "STANDING")
test_rank<- replace(test_rank, test_rank==6, "LAYING")
train_rank<-read.table("y_train.txt")
train_sub<-read.table("subject_train.txt")
train_rank<- replace(train_rank, train_rank==1, "WALKING")
train_rank<- replace(train_rank, train_rank==2, "WALKING_UPSTAIRS")
train_rank<- replace(train_rank, train_rank==3, "WALKING_DOWNSTAIRS")
train_rank<-replace(train_rank, train_rank==4, "SITTING")
train_rank<-replace(train_rank, train_rank==5, "STANDING")
train_rank<- replace(train_rank, train_rank==6, "LAYING")
test<-cbind(test_rank,test)
train<-cbind(train_rank,train)
TEMP<-c(test_rank$V1, train_rank$V1)
sub<-c(test_sub$V1, train_sub$V1)
merged<-merged[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)]
merged<-cbind(TEMP,merged)
merged<-cbind(sub,merged)
merged2<-aggregate(merged[, 3:67], list(merged$TEMP, merged$sub), mean)
names(merged2)[1]<- "Activity"
names(merged2)[2]<- "Subject"
names(merged)[1]<- "Activity"
names(merged)[2]<- "Subject"
write.table(merged2, file="getting_and_cleaning_data_project.txt",row.name=FALSE)
