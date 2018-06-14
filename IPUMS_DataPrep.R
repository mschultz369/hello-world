library(ipumsr)
library(dplyr)

#newIPUMS <- read.csv2("/Users/Mschultz/Desktop/newdataset.csv", header = TRUE, sep=",")
# I used the ipumsr package with the .xml file and it worked
newIPUMS <- read_ipums_micro("nhis_00001.xml")

newIPUMS_12_20 <- filter(newIPUMS, AGE>11, AGE<21)
table(newIPUMS_12_20$AGE)
hist(newIPUMS_12_20$WEIGHTKID)
plot(newIPUMS_12_20$AGE,newIPUMS_12_20$WEIGHTKID)

sum(newIPUMS$AGE<21)
mean(newIPUMS$AGE<21)

# This code is reused so I've commented it out
#newIPUMS_12_20 <- filter(newIPUMS, AGE>11, AGE<21)

#creating new weight variable#
newIPUMS_12_20 <- mutate(newIPUMS_12_20, new_weight = case_when(
  AGE < 18 ~ WEIGHTKID, 
  AGE >= 18 ~ WEIGHT))
par(mar=c(3,3,3,3))                                                                    
plot(newIPUMS_12_20$AGE, newIPUMS_12_20$new_weight)

#creating new height variable#
newIPUMS_12_20 <- mutate(newIPUMS_12_20, new_height = case_when(
  AGE < 18 ~ HEIGHTKID, 
  AGE >= 18 ~ HEIGHT))
plot(newIPUMS_12_20$AGE, newIPUMS_12_20$new_height)

#creating new BMI variable#
newIPUMS_12_20 <- mutate(newIPUMS_12_20, new_BMI = case_when(
  AGE < 18 ~ BMIKID/100, 
  AGE >= 18 ~ BMI))

plot(newIPUMS_12_20$AGE, newIPUMS_12_20$new_BMI)
