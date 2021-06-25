# Grab the links that have response tags. ------------------------------------------------
question_to_resp <- links %>% filter(str_detect(Name.Parent,  "Response:"))
if(!all(question_to_resp$ThoughtIdA %in% questions$Id)) warning("see line 4 make_response_tag_link_tables.R")

#remove these from links
links <- setdiff(links, question_to_resp)


# Save objs to export -----------------------------------------------------
export <- c(paste(export), "question_to_resp")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
