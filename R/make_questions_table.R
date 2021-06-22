# Create a table for response lookup, or the questions that responses might be tagged with

questions <- nodes %>%
    filter(Kind==4) %>%
    filter(str_detect(Name, "Response"))

# Remove these from the nodes table ---------------------------------------
nodes <- setdiff(nodes, questions)


# Munge questionsm df -----------------------------------------------------

questions <- questions %>% select(Name, Id)

# Save objs to export -----------------------------------------------------
export <- c(paste(export), "questions")
# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


