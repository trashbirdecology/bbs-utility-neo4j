
# Pull out nodes describving the end user types ---------------------------
euts <- nodes %>% filter(!is.na(Label))
# remove thse from  nodes
nodes <- setdiff(nodes,euts)



# Pull out links containing end user types --------------------------------
euts.links <- links %>% filter(ThoughtIdA %in% euts$Id)
# remove those from links
links <- setdiff(links, euts.links)

# Add the Names to links
euts <- full_join(euts.links, euts%>% select(Name, Id), by=c("ThoughtIdA"="Id")) %>%
    rename(EndUserTypeName=Name,
           EndUserTypeId=ThoughtIdA,
           ChildNodeId=ThoughtIdB,
           LinkId=Id) %>%
    select(-Relation, -Meaning)
rm(euts.links)

euts_to_paraphrased <- euts %>% filter(ChildNodeId %in% para_table$ParaId)
euts_to_jlb <- euts %>% filter(ChildNodeId %in% jlb_table$JlbId)

rm(euts)


# Clear junk  -------------------------------------------------------------
export <- c(paste(export),"euts_to_paraphrased", "euts_to_jlb")
rm(list=setdiff(ls(), export))
