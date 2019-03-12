# set directory to the folder in which csv files are put
setwd('Your Direcotry')

# get file names
fileName = list.files(pattern = "csv")

# modify read.csv() function
readCSV_and_addFileNameToColumn = function(fileName_){
  d = read.csv(fileName_)
  d$serialnumber =  fileName_
  return(d)
}

# read all data
data = lapply(fileName, readCSV_and_addFileNameToColumn)

# convert to data.frame from list 
data = do.call(rbind,data)

# set serialnumber corresponding to each file
data$serialnumber = as.factor(data$serialnumber)
data$serialnumber = as.integer(data$serialnumber)

#------------------------------------------#
# for 'tidyverse' users, just do this
library(tidyverse)
data = list.files(pattern=".csv") %>% # get file names
  lapply(., readCSV_and_addFileNameToColumn) %>% # get all data at once
  do.call(rbind,.) %>% # conver to data.frame
  mutate(., serialnumber = serialnumber %>% as.factor %>% as.integer) # set serialnubmers of files
