library(shiny)
library(ggplot2)
library(CodeClanData)
library(tidyverse)
library(dplyr)


ggplot(student_data()) +
  aes(x = reaction_time) +
  geom_histogram()




