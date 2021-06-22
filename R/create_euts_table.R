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
rm(euts.links)

euts_to_paraphrased <- euts %>% filter(ChildNodeId %in% paraphrased_responses$ParaId)
euts_to_jlb_interpreted <-euts %>% filter(!ChildNodeId %in% paraphrased_responses$ParaId)

if(nrow(euts_to_jlb_interpreted)+nrow(euts_to_paraphrased) != nrow(euts))(warning("see line 20 create_euts_table"))



# Clear junk  -------------------------------------------------------------
export <- c(paste(export), "euts_to_paraphrased", "euts_to_jlb_interpreted")
rm(list=setdiff(ls(), export))
