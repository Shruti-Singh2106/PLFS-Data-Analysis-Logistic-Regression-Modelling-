# change the path of csv file before stating
data <- read.csv("C:\\Users\\Shruti Singh\\Desktop\\nsso csv file.csv")
head(data, 10)
names(data)
unique(data$sector)

# Install package dpylr from the packages window
# Load necessary library
library(dplyr)

# Install package
install.packages("ggplot2")

# Load the package
library(ggplot2)

# Create a new variable 'employed1' initialized as NA
data$employed1 <- NA

# Assign 1 = Employed for these status codes
data$employed1[data$statuscode %in% c(11, 12, 21, 31, 41, 51)] <- 1

# Assign 0 = Not Employed for these status codes
data$employed1[data$statuscode %in% c(81, 91, 92, 93, 94, 95, 97, 98, 99)] <- 0

# Convert to factor and label it
data$employed1 <- factor(data$employed1,
                        levels = c(0, 1),
                        labels = c("Not Employed", "Employed"))
# Frequeny table of employed 1 
table(data$employed1, useNA = "ifany")


# Create a new variable 'vocational_training' based on the original column
data$vocational_training <- NA  # Initialize as NA

# Assign 1 to those who received training (codes 1 to 5)
data$vocational_training[data$whetherreceivedanyvocationaltech %in% c(1, 2, 3, 4, 5)] <- 1

# Assign 0 to those who did NOT receive training (code 6)
data$vocational_training[data$whetherreceivedanyvocationaltech == 6] <- 0

# Convert to factor and label
#data$vocational_training <- factor(data$vocational_training,
 #                                  levels = c(0, 1),
  #                                 labels = c("Not Received", "Received"))
#Frequency table of vocational training 
table(data$vocational_training)

# With percentages
prop.table(table(data$vocational_training)) * 100


# create new var for education  
  data$educated <- NA
  
  # Step 2: Assign 1 = Educated for these levels
  data$educated[data$generaleducaionlevel %in% c(2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 13)] <- 1
  
  # Step 3: Assign 0 = Not Educated for level 1
  data$educated[data$generaleducaionlevel == 1] <- 0
  
  # Step 4: Convert to factor with labels
  data$educated <- factor(data$educated,
                          levels = c(0, 1),
                          labels = c("Not Educated", "Educated"))
  
  # Step 5: Check the result
  table( data$educated)
  
  # Convert gender2 to numeric (assuming levels are "Male", "Female")
  #data$gender2 <- ifelse(data$gender2 == "Male", 1, 0)
  #data$gender2 <- ifelse(data$gender2 == "Female", 1, 0)
  
  # Step 1: Initialize gender2 as NA
  data$gender2 <- NA
  
  # Step 2: Assign values based on 'sex'
  data$gender2[data$sex == "Male"] <- 0
  data$gender2[data$sex == "Female"] <- 1
  data$gender2[data$sex == "Other"] <- 0
  
  
  # Step 1: Initialize gender2 as NA
  data$gender3 <- NA
  
  # Step 2: Assign values based on 'sex'
  data$gender3[data$sex == "Male"] <- 0
  data$gender3[data$sex == "Female"] <- 1
  data$gender3[data$sex == "Other"] <- 2
  table(data$gender3)
  # Step 3: Convert to numeric
 # data$gender2 <- as.numeric(data$gender2)
  
  # Step 4: Optional - Convert to factor with labels
 # data$gender2 <- factor(data$gender2,
  #                       levels = c(1, 2, 3),
   #                      labels = c("Male", "Female", "Other"))
  
  # Step 5: Check the result
  table(data$gender2)
  table(data$gender2, useNA = "ifany")
  
  # Step 0: Check result
  table(data$religion, useNA = "ifany")
  # Step 1: Create new variable based on religion
  data$religion_grouped <- NA
  
  # Step 2: Assign new grouped values
  data$religion_grouped[data$religion == "Hinduism"] <- 1
  data$religion_grouped[data$religion == "Islam"] <- 2
  data$religion_grouped[data$religion == "Christianity"] <- 3
  data$religion_grouped[!(data$religion %in% c("Hinduism", "Islam", "Christianity"))] <- 4  # All others
  
  # Step 3: Convert to factor with readable labels
  data$religion_grouped <- factor(data$religion_grouped,
                                  levels = c(1, 2, 3, 4),
                                  labels = c("Hinduism", "Islam", "Christianity", "Other"))
  
  # Step 4: Check the result
  table(data$religion_grouped, useNA = "ifany")
  
  # Step 1: Recode religion into numeric codes (1 to 4)
  data$religion_numeric <- NA
  
  data$religion_numeric[data$religion == "Hinduism"] <- 1
  data$religion_numeric[data$religion == "Islam"] <- 2
  data$religion_numeric[data$religion == "Christianity"] <- 3
  data$religion_numeric[!(data$religion %in% c("Hinduism", "Islam", "Christianity"))] <- 4  # All others
  
  # Step 2: Convert to numeric explicitly (just in case)
  data$religion_numeric <- as.numeric(data$religion_numeric)
  
  # Step 3: Check the recoded variable
  table(data$religion_numeric, useNA = "ifany")
  
  
  # Create a new 'region' variable in the dataset
  data$region2 <- NA
  
  # Assign regions based on state codes
  data$region2[data$state %in% c(01, 02, 03, 04, 05, 06, 07, 08, 37)] <- "North"
  data$region2[data$state %in% c(9, 22, 23)] <- "Central"
  data$region2[data$state %in% c(10, 19, 20, 21)] <- "East"
  data$region2[data$state %in% c(11, 12, 13, 14, 15, 16, 17, 18)] <- "Northeast"
  data$region2[data$state %in% c(24, 25, 27, 30)] <- "West"
  data$region2[data$state %in% c(28, 29, 31, 32, 33, 34, 35, 36)] <- "South"
  
  # Convert region to factor
  data$region2 <- factor(data$region2, 
                        levels = c("North", "Central", "East", "Northeast", "West", "South"))

  # Create dummy variables for each region (except the reference category "North")
  data$central_dum   <- ifelse(data$region2 == "Central", 1, 0)
  data$east_dum      <- ifelse(data$region2 == "East", 1, 0)
  data$northeast_dum <- ifelse(data$region2 == "Northeast", 1, 0)
  data$west_dum      <- ifelse(data$region2 == "West", 1, 0)
  data$south_dum     <- ifelse(data$region2 == "South", 1, 0)
  
  
  # Check distribution
  table(data$region2, useNA = "ifany")
  
  
  
 
  
 #ggplots
  #ggplot for employement and gender
   ggplot(data %>% filter(!is.na(employed1)), aes(x = employed1, fill = gender2)) +
    geom_bar(position = "dodge") +
    labs(title = "Employment Status by Gender",
         x = "Employment Status",
         y = "Count",
         fill = "Gender") +
    theme_minimal()
   
  #ggplot for age
    ggplot(data %>% filter(!is.na(age)), aes(x = age)) +
     geom_histogram(binwidth = 5, fill = "#2ECC71", color = "white") +
     labs(title = "Age Distribution",
          x = "Age",
          y = "Count") +
     theme_minimal()
    
  # Vocational Training – Bar Plot 
   ggplot(data %>% filter(!is.na(vocational_training)), aes(x = vocational_training)) +
     geom_bar(fill = "#4C72B0") +
     geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
     labs(title = "Vocational Training Status",
          x = "Vocational Training",
          y = "Count") +
     scale_y_continuous(labels = comma) +
     theme_minimal()
   
  # sector bar plot
   data$sector <- factor(data$sector,
                         levels = c(1, 2),
                         labels = c("Rural", "Urban"))
   
   install.packages("scales")   # Only once
   library(scales)  
   
   ggplot(data %>% filter(!is.na(sector)), aes(x = sector)) +
     geom_bar(fill = "#C44E52") +
     geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
     labs(title = "Urban vs Rural Distribution",
          x = "Sector (Residential Area)",
          y = "Count") +
     scale_y_continuous(labels = comma) +   # 👈 This line adds full numbers like 600,000
     theme_minimal()
  
   # Education Level – Bar Plot Faceted by Gender 
   ggplot(data %>% filter(!is.na(educated)), aes(x = educated, fill = gender2)) +
     geom_bar(position = "dodge") +
     labs(title = "Education Level by Gender",
          x = "Education Level",
          y = "Count",
          fill = "Gender") +
     theme_minimal() +
     scale_y_continuous(labels = comma) +
     theme(axis.text.x = element_text(angle = 45, hjust = 1))
   
   # bar plot for gender 
   ggplot(data %>% filter(!is.na(gender2)), aes(x = gender2)) +
     geom_bar(fill = "#DD8452") +
     geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
     labs(title = "Gender Distribution",
          x = "Gender",
          y = "Count") +
     scale_y_continuous(labels = comma) +
     theme_minimal()
   
# ggplot for religion 
   data$religion_plot <- factor(data$religion_numeric,
                                levels = c(1, 2, 3, 4),
                                labels = c("Hinduism", "Islam", "Christianity", "Other"))
   
   ggplot(data %>% filter(!is.na(religion_plot)), aes(x = religion_plot)) +
     geom_bar(fill = "#66C2A5") +
     geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
     labs(title = "Distribution of Religion (Grouped)",
          x = "Religion",
          y = "Count") +
     scale_y_continuous(labels = scales::comma) +
     theme_minimal()
   
   
   # Vocational Training by Gender
   ggplot(data %>% filter(!is.na(vocational_training) & !is.na(gender2)),
          aes(x = vocational_training)) +
     geom_bar(fill = "#8DA0CB") +
     geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
     facet_wrap(~ gender2) +
     labs(title = "Vocational Training by Gender",
          x = "Vocational Training Status",
          y = "Count") +
     scale_y_continuous(labels = scales::comma) +
     theme_minimal()
   
   ggplot(data %>%
            filter(!is.na(vocational_training),
                   gender2 %in% c("Male", "Female")),  # 👈 Exclude "Other"
          aes(x = gender2)) +
     geom_bar(fill = "#FC8D62") +
     geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
     facet_wrap(~ vocational_training) +
     labs(title = "Gender Distribution by Vocational Training Status",
          x = "Gender",
          y = "Count") +
     scale_y_continuous(labels = scales::comma) +
     theme_minimal()
  
   
   #ggplot for employment status 
   ggplot(data, aes(x = employed, fill = employed)) +
     geom_bar(width = 0.6) +
     geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
     scale_fill_manual(values = c("Not Employed" = '#E74C3C', "Employed" = '#2ECC71')) +
     labs(title = "Distribution of Employment Status",
          x = "Employment Status",
          y = "Count",
          fill = "Employment") +
     scale_x_discrete(labels = c("Not Employed", "Employed")) +  # Customize x-axis labels
     scale_y_continuous(labels = comma) +
      theme_minimal() 
     
   theme(
     plot.title = element_text(hjust = 0.5, face = "bold"),
     legend.position = "none")
  

   
   
   
   data$gender_voc_cat <- NA  
   data$gender_voc_cat <- ifelse(data$gender2 == 2 & data$vocational_training == 1, 1,  # Female, received
                                      ifelse(data$gender2 == 2 & data$vocational_training == 0, 2,  # Female, not received
                                             ifelse(data$gender2 == 1 & data$vocational_training == 1, 3,  # Male, received
                                                    ifelse(data$gender2 == 1 & data$vocational_training == 0, 4, NA))))  # Male, not received
   
   
 
  
   data$gender_voc_cat <- factor(data$gender_voc_cat,
                                 levels = c(1, 2, 3, 4),
                                 labels = c("Female: Received Training",
                                            "Female: No Training",
                                            "Male: Received Training",
                                            "Male: No Training"))
   
   library(ggplot2)
   library(dplyr)
   
   
   
   ggplot(data %>% filter(!is.na(gender_voc_cat), !is.na(employed1)),
          aes(x = gender_voc_cat, fill = employed1)) +
     geom_bar(position = "dodge") +
     geom_text(stat = "count", aes(label = ..count..), 
               position = position_dodge(width = 0.9), vjust = -0.5, size = 3) +
     scale_fill_manual(values = c("#FC8D62", "#66C2A5")) +
     labs(title = "Employment Status by Gender & Vocational Training",
          x = "Gender & Training Category",
          y = "Number of Individuals",
          fill = "Employment Status") +
     theme_minimal() +
     theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
     scale_y_continuous(labels = scales::comma)
   
   
   
   
   
   
   
   model0 <- glm(employed1 ~ vocational_training + gender2 + 
                  + age + educated + sector + religion_numeric,
                data = data, family = binomial(link = "logit"))
   
   # View summary of model
   summary(model0)
   
   
   
   model <- glm(employed1 ~ vocational_training + gender2 + gender_voc_cat  +
                  + age + educated + sector + religion_numeric,
                data = data, family = binomial(link = "logit"))
   
   # View summary of model
   summary(model)
   
 data$gender_voc <- NA
   
 data$gender_voc <- data$gender2 * data$vocational_training
 
  #run logit model
  logit_model <- glm(employed1 ~  + gender_voc + age + educated + sector,
                     data = data,
                     family = binomial(link = "logit"))
  
  # View summary of model
  summary(logit_model)
  
  
  model_interaction1 <- glm(employed1 ~ gender_voc_cat +
                             age + educated + sector + religion_numeric,
                           data = data, family = binomial(link = "logit"))
  
  summary(model_interaction1)
  
# logit model with regions dummies 
  logit_manual_region <- glm(employed1 ~ vocational_training * gender2 + age + educated + sector +
                               central_dum + east_dum + northeast_dum + west_dum + south_dum,
                             data = data,
                             family = binomial(link = "logit"))
  
  # View model summary
  summary(logit_manual_region)
  

  
 
  logit_model_region <- glm(employed1 ~ vocational_training * gender3 + age + educated + sector + region2,
                            data = data,
                            family = binomial(link = "logit"))
  
  # View the summary
  summary(logit_model_region)
  
  
  # final logit model
  logit_m5 <- glm(employed1 ~ vocational_training * gender3 + age + educated + sector + region2,
                            data = data,
                            family = binomial(link = "logit"))
  
  # View the summary
  summary(logit_m5)
  
  
  library(ggplot2)
  library(dplyr)
 
  
 
  library(ggplot2)
  
  ggplot(data, aes(x = region2, fill = gender3)) +
    geom_bar(position = "dodge") +
    labs(title = "Regional Distribution by Gender",
         x = "Region",
         y = "Count",
         fill = "Gender") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  