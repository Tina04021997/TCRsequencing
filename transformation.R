# Author: Tina Yang
# Date: Jun 24, 2021
# Data transformation for VDJviz web-based analyzation
library("tidyverse")
setwd("Raw_data_path")

df <- read.csv("sample_name")
df <- df[-c(1,4:5,7,9,11:22,24:36,38:39)] #remove the unwanted columns
df <- df %>% slice(1:10000) #keep only top 10,000 clonotypes (due to VDJviz browser limitation)
df <- df[,c(1,2,6,7,3,4,5)]
colnames(df) <- c("#count","freq","cdf3nt","cdr3aa","v","d","j")
df$d <- as.character("")
df$d <- sub("",".",as.character(df$d))

df$v<- gsub("*00","",as.character(df$v))
df$j<- gsub("*00","",as.character(df$j))
df$v <- gsub(".{1}$", "", as.character(df$v))
df$j <- gsub(".{1}$", "", as.character(df$j))

write.csv(df, file = "sample_name.csv", row.names=FALSE)
