# Grab the links that have response tags. ------------------------------------------------
resp_with_question_tag <- links %>% filter(Meaning==5)
if(!all(resp_with_question_tag$ThoughtIdA %in% questions$Id)) warning("see line 4 make_response_tag_link_tables.R")

#remove these from links
links <- setdiff(links, resp_with_question_tag)



# Munge table -------------------------------------------------------------

## Add the text (name) to ThoguhtIdA (the question)
resp_with_question_tag <- resp_with_question_tag %>%
    select(ThoughtIdA, ThoughtIdB) %>%
    left_join(questions, by=c("ThoughtIdA"="Id")) %>%
    rename(QuestionName = Name, QuestionId = ThoughtIdA, ChildNodeId = ThoughtIdB)

## Append the text to the ChildNodeId
resp_with_question_tag <- resp_with_question_tag %>%
    left_join(nodes %>% select(Name, Id), by=c("ChildNodeId"="Id")) %>%
    rename(ChildNodeName = Name)


# Save objs to export -----------------------------------------------------
export <- c(paste(export), "resp_with_question_tag")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
