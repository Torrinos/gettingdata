#=======================================================
#Environment and libraries
require(data.table)

#Assign filenames
x_train <- "UCI HAR Dataset\\train\\X_train.txt"
y_train <- "UCI HAR Dataset\\train\\y_train.txt"
s_train <- "UCI HAR Dataset\\train\\subject_train.txt"
x_test <- "UCI HAR Dataset\\test\\X_test.txt"
y_test <- "UCI HAR Dataset\\test\\y_test.txt"
s_test <- "UCI HAR Dataset\\test\\subject_test.txt"
act_labels <- "UCI HAR Dataset\\activity_labels.txt"
column_names <- "UCI HAR Dataset\\features.txt"

#Read features list and activity vectors
features <- read.table(column_names,stringsAsFactors=FALSE)
act.train <- read.table(y_train)
act.test <- read.table(y_test)
act.labels <-read.table(act_labels)
subj.train <- read.table(s_train)
subj.test <- read.table(s_test)

#Create datasets
DT_train = data.table(read.table(x_train))
setnames(DT_train,features$V2)

DT_test = data.table(read.table(x_test))
setnames(DT_test,features$V2)

#inject exercises and subjects
DT_train[,subject:=subj.train]
DT_train[,actID:=act.train]

DT_test[,subject:=subj.test]
DT_test[,actID:=act.test]

#simply bind, since columns are the same
DT <- rbind(DT_train,DT_test)

#adding activity labels by looking up activity vector
DT[,activity:={act.labels$V2[match(DT$actID,act.labels$V1)]}]
#=======================================================

#=======================================================
#Defining indices for mean, std and grouping categories
selection <- grep("(mean\\()|(meanFreq\\())|(std\\()", features$V2, ignore.case = TRUE)
group <- grep("(activity)|(subject)",names(DT), ignore.case = TRUE)
#=======================================================

#=======================================================
#Final part - getting means and grouping, using dt features
res <- DT[,lapply(.SD,mean),by=list(activity,subject), .SDcols=selection]
setcolorder(res,c("subject","activity",names(DT[,selection,with=FALSE])))
res <- res[order(subject,activity)]
write.table(res,file="result.txt",row.names=FALSE,col.names=TRUE,sep="\t")
print(res)
#=======================================================
