# Links with question/response tags ------------------------------------------------
## Grab the links that have response tags.
resp_with_question_tag <- links %>% filter(Meaning==5)
#remove from links
links <- setdiff(links, resp_with_question_tag)
## Add name to ThoguhtIdA (the question)
resp_with_question_tag <- resp_with_question_tag %>%
    select(ThoughtIdA, ThoughtIdB) %>%
    left_join(questions, by=c("ThoughtIdA"="Id")) %>%
    rename(QuestionName = Name, QuestionId = ThoughtIdA, ChildNodeId = ThoughtIdB)

## Append the text to the ChildNodeId
resp_with_question_tag <- resp_with_question_tag %>%
    left_join(nodes %>% select(Name, Id), by=c("ChildNodeId"="Id")) %>%
    rename(ChildNodeName = Name)


# Munge remaining links ----------------------------------------------------------------------
# The remaining links should all be response -> response..
links <- links %>% select(ThoughtIdA, ThoughtIdB)
nodes <- nodes %>% select(Name, Id)

links <- links %>% left_join(nodes, by=c("ThoughtIdA"="Id")) %>%
        rename(ParentResponseId = ThoughtIdA, ParentResponseName=Name)
links <- links %>% left_join(nodes, by=c("ThoughtIdB"="Id")) %>%
    rename(ChildResponseId = ThoughtIdB, ChildResponseName=Name)

# Save objs to export -----------------------------------------------------
export <- c(paste(export), "resp_with_question_tag")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
