
# Munge remaining links ----------------------------------------------------------------------
# The remaining links should all be response -> response..
links <- links %>% select(ThoughtIdA, ThoughtIdB)
nodes <- nodes %>% select(Name, Id)

links <- links %>% left_join(nodes, by=c("ThoughtIdA"="Id")) %>%
    rename(ParentResponseId = ThoughtIdA, ParentResponseName=Name)
links <- links %>% left_join(nodes, by=c("ThoughtIdB"="Id")) %>%
    rename(ChildResponseId = ThoughtIdB, ChildResponseName=Name)
