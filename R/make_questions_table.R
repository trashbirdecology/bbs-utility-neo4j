# Create a table for response lookup, or the questions that responses might be tagged with
questions <- nodes %>%
    filter(Kind==4) %>%
    filter(str_detect(Name, "Response"))


# Munge questionsm df -----------------------------------------------------
questions <- questions %>% select(Name, Id)

# Remove these from nodes for easy people table making --------------------
nodes <- nodes %>% filter(!Id %in% questions$Id)

# Save objs to export -----------------------------------------------------
export <- c(paste(export), "questions")
# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


