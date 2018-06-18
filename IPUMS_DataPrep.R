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

#trying to upload our dataset and apply it to the BMI-for-Age curves#

library(dplyr)
library(ipumsr)
library(extrafont)
newIPUMS <- read.csv2("/Users/Mschultz/Desktop/newdataset.csv", header = TRUE, sep=",")
newIPUMS_12_20 <- filter(newIPUMS, AGE>11, AGE<21)

bdata = newIPUMS_12_20[!is.na(newIPUMS_12_20$ID ==""),]

ht = as.numeric(newIPUMS_12_20$new_height)
wt = as.numeric(newIPUMS_12_20$new_weight)
bdata$BMI_kgm2 = ifelse(!is.na(newIPUMS_12_20$new_height)& !is.na(newIPUMS_12_20$new_weight), wt/((ht/ 100)*(ht / 100)) , newIPUMS_12_20$new_BMI)
table(newIPUMS_12_20$AGE)
cdc_mdata <- read_excel("/Users/Mschultz/Desktop/Ref_percentile_curves.xlsx", 
                        sheet = "Males, 2-20 years")
cdc_mdata$age_m = cdc_mdata$AgeInMonths / 12
cdc_fdata <- read_excel("/Users/Mschultz/Desktop/Ref_percentile_curves.xlsx", 
                        sheet = "Females, 2-20 years")
cdc_fdata$age_m = cdc_fdata$AgeInMonths / 12

m_input1 = subset(newIPUMS_12_20, SEX=="male", select=c(AGE, BMI))
m_input2 = subset(newIPUMS_12_20, SEX=="Male", select=c(AGE, BMI))
m_input3 = subset(newIPUMS_12_20, SEX=="m", select=c(AGE, BMI))
m_input1 = subset(newIPUMS_12_20, SEX=="M", select=c(AGE, BMI))
m_input = rbind(m_input1, m_input2, m_input3,m_input4)
head(m_input)
dim(m_input)

