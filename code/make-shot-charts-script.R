setwd("C:/Users/Dev Navani/Desktop/stat133/workouts/workout01/code")
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
iggy <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
klay <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
library(ggplot2)
klay_scatterplot <- ggplot(data = klay) + geom_point(aes(x = x, y = y, color = shot_made_flag))