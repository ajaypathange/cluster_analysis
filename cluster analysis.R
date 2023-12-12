#getdata
data <- read.csv("Train.csv")

#simplify the data
data <- data[ , 2:9]
summary(data)
unique(data$Profession)

#Transform blanks into NA
data[data == ""] <- NA
unique(data$Profession)
data <- data[complete.cases(data),]
summary(data)

#Start Building datasets

library(dplyr)
dataset <- data %>% select_if(is.numeric)
character <- data %>% select_if(is.character)

#Transform Character into numerical
install.packages("fastDummies")
library(fastDummies)
character <- dummy_cols(character,remove_most_frequent_dummy = TRUE)

#Finalize data set
dataset <- cbind(dataset,character[,6:18])
?scale
#scale the dataset
dataset[,1:16] <- scale(dataset[,1:16])

#Determining amount of clusters
install.packages("factoextra")
library(factoextra)
fviz_nbclust(dataset,kmeans,method = "wss")+
             labs(subtitle = "Elbow Meathod")

#Clusters
clusters <- kmeans(dataset, centers = 6, iter.max = 10)
clusters$centers
write.csv(cluster$cluster, file = "cluster.csv")
dataset <- cbind(dataset,cluster$cluster)
