euts <- nodes %>% filter(!is.na(Label))
# remove from nodes
nodes <- setdiff(nodes,euts)
euts.links <- links %>% filter(ThoughtIdA %in% euts$Id)
# remove from links
links <- setdiff(links, euts.links)

# Add the Names to links
euts <- full_join(euts.links, euts%>% select(Name, Id), by=c("ThoughtIdA"="Id")) %>%
    rename(EndUserTypeName=Name,
           EndUserTypeId=ThoughtIdA,
           ChildNodeId=ThoughtIdB,
           LinkId=Id) %>%
    select(-Relation, -Meaning)



# Clear junk  -------------------------------------------------------------
export <- c(paste(export), "euts")
rm(list=setdiff(ls(), export))
