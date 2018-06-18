# You will need to have the m_input (and f_input) data frames created
# from the BMI_R_GraphingProgram code


# First we need to create an AgeInMonths variable and make it end in 0.5
# You will do this differently if you have ages as only whole years
m_input <- mutate(m_input, AgeInMonths = 12*Age_y + .5)

# This creates a variable in m_input that has missing values for everybody
# The loop will fill these in
m_input$BMI_5 <- rep(NA, nrow(m_input))
m_input$BMI_50 <- rep(NA, nrow(m_input))

# For each person in m_input this loop will find their age and find a BMI
# cutoff for that age (or several cutoffs). The number after the comma is
# the column for that specific cutoff
for(i in 1:nrow(m_input)) {
  age <- m_input$AgeInMonths[i]
  m_input$BMI_5[i] <- cdc_mdata[cdc_mdata$AgeInMonths == age, 3]
  m_input$BMI_50[i] <- cdc_mdata[cdc_mdata$AgeInMonths == age, 6]
}

# The cutoff variables are converted to numeric
m_input$BMI_5 <- as.numeric(m_input$BMI_5)
m_input$BMI_50 <- as.numeric(m_input$BMI_50)
head(m_input$BMI_5)

# We can check how many (and what proportion) of people are below the 5th percentile
sum(m_input$BMI_kgm2 < m_input$BMI_5)
mean(m_input$BMI_kgm2 < m_input$BMI_5)

# Or how many (and what proportion) of people are below the 50th percentile
sum(m_input$BMI_kgm2 < m_input$BMI_50)
mean(m_input$BMI_kgm2 < m_input$BMI_50)

# Or how many (and what proportion) of people are between the 5th & 50th percentiles
sum(m_input$BMI_kgm2 < m_input$BMI_50 & m_input$BMI_kgm2 >= m_input$BMI_5)
