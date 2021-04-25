library(tidyverse)
data <- data.table::fread("https://countlove.org/data/data.csv")

#find a high-level overview of all event types 
data$event_type <- stringr::str_replace(data$`Event (legacy; see tags)`, 
                                        " *\\(.*?\\) *", "")
unique_event_type <- unique(data$event_type)

data$Attendees <- data$Attendees / 100

df <- subset(data, data$Date >= "2019-1-1" 
             & data$Date <= "2020-12-31" 
             & is.na(data$Attendees) == F)

civil_rights <- aggregate(df$Attendees[df$event_type == "Civil Rights"], 
                          list(df$Date[df$event_type == "Civil Rights"]), sum)
colnames(civil_rights) <- c("Date", "Civil")
racial_injustice <- aggregate(df$Attendees[df$event_type == "Racial Injustice"], 
                              list(df$Date[df$event_type == "Racial Injustice"]), sum)
colnames(racial_injustice) <- c("Date", "Racial")
immigration <- aggregate(df$Attendees[df$event_type == "Immigration"], 
                         list(df$Date[df$event_type == "Immigration"]), sum)
colnames(immigration) <- c("Date", "Immigration")
executive <- aggregate(df$Attendees[df$event_type == "Executive"], 
                       list(df$Date[df$event_type == "Executive"]), sum)
colnames(executive) <- c("Date", "Executive")

healthcare <- aggregate(df$Attendees[df$event_type == "Healthcare"], 
                        list(df$Date[df$event_type == "Healthcare"]), sum)
colnames(healthcare) <- c("Date", "Healthcare")
environment <- aggregate(df$Attendees[df$event_type == "Environment"], 
                         list(df$Date[df$event_type == "Environment"]), sum)
colnames(environment) <- c("Date", "Environment")
guns <- aggregate(df$Attendees[df$event_type == "Guns"], 
                  list(df$Date[df$event_type == "Guns"]), sum)
colnames(guns) <- c("Date", "Guns")
education <- aggregate(df$Attendees[df$event_type == "Education"], 
                       list(df$Date[df$event_type == "Education"]), sum)
colnames(education) <- c("Date", "Education")




#filling in the missing date for the above 4 dfs created
df1 <- civil_rights %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Civil` = 0))
df2 <- racial_injustice %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Racial` = 0))
df3 <- immigration %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Immigration` = 0))
df4 <- executive %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Executive` = 0))
df5 <- healthcare %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Healthcare` = 0))
df6 <- environment %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Environment` = 0))
df7 <- guns %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Guns` = 0))
df8 <- education %>%
  complete(Date = seq(Date[1], as.Date(c("2020-12-31")), by = "1 day"),
           fill = list(`Education` = 0))


output_df <- Reduce(merge, list(df1, df2, df3, df4, df5, df6, df7, df8))


write.csv(output_df, "filtered_attendees.csv", row.names = F)














