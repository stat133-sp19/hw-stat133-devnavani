## ------
##
## Make Shots
##
## Script to combine five warriors player shots into one data file 
##
## Input: CSV for each player, one row for each shot
##        (five CSVs total)
##
## Output: summaries of each individual player csv (text files), final combined csv, summary of the combined csv (text file)
## ------


## 3) Data Preparation
setwd("C:/Users/Dev Navani/Desktop/stat133/workouts/workout01/code")
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
iggy <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
klay <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)

curry$shot_made_flag[curry$shot_made_flag == "n"] = "shot_no" 
iggy$shot_made_flag[iggy$shot_made_flag == "n"] = "shot_no"
green$shot_made_flag[green$shot_made_flag == "n"] = "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "n"] = "shot_no"
klay$shot_made_flag[klay$shot_made_flag == "n"] = "shot_no" 

curry$shot_made_flag[curry$shot_made_flag == "y"] = "shot_yes" 
iggy$shot_made_flag[iggy$shot_made_flag == "y"] = "shot_yes"
green$shot_made_flag[green$shot_made_flag == "y"] = "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "y"] = "shot_yes"
klay$shot_made_flag[klay$shot_made_flag == "y"] = "shot_yes" 

curry$minute = 12*curry$period - curry$minutes_remaining
iggy$minute = 12*iggy$period - iggy$minutes_remaining
green$minute = 12*green$period - green$minutes_remaining
durant$minute = 12*durant$period - durant$minutes_remaining
klay$minute = 12*klay$period - klay$minutes_remaining

sink("../output/stephen-curry-summary.txt")
summary(curry)
sink()

sink("../output/andre-iguodala-summary.txt")
summary(iggy)
sink()

sink("../output/draymond-green-summary.txt")
summary(green)
sink()

sink("../output/klay-thompson-summary.txt")
summary(klay)
sink()

sink("../output/kevin-durant-summary.txt")
summary(durant)
sink()

shots_data <- rbind(curry, iggy, green, klay, durant)
shots_data_df <- as.data.frame(shots_data)
write.csv(shots_data_df, "../data/shots-data.csv")

sink("../output/shots-data-summary.txt")
summary(shots_data_df)
sink()

