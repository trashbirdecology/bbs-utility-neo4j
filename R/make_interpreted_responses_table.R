# Make tables for the noodes describing paraphrased responses and for JLB interp ----------------
para.lookup.id <- nodes %>%
    filter(Kind==4) %>%
    filter(str_detect(Name, "(?i)paraphrase"))

jlb.lookup.id <- nodes %>%
    filter(Kind==4) %>%
    filter(str_detect(Name, "(?i)jlb" ))

## Remove these from NODES
nodes <- setdiff(nodes, bind_rows(jlb.lookup.id, para.lookup.id))

# grab all the nodes that have the paraphrased tags
para_responses <- links %>% filter(ThoughtIdA %in% para.lookup.id)
# grab all the nodes that have the JLB tags
jlb_interpretations <- links %>% filter(ThoughtIdA %in% jlb.lookup.id)
## remove all these from LINKS
links <- setdiff(links, bind_rows(para_responses, jlb_interpretations))


# MUNGE JLB interp ---------------------------------------------------------------
jlb_interpretations <- jlb_interpretations %>%
    rename(Id=ThoughtIdA,
           JlbId=ThoughtIdB,
           LinkId=Id) %>% select(-Meaning, -Relation)

## Add the text from nodes to these links
jlb_interpretations <- left_join(jlb_interpretations, nodes, by=c("JlbId"= "Id")) %>%
    rename(JlbName = Name) %>%
    select(JlbName, JlbId, TypeId)



# jlb_interp_lookup <- full_join(jlb_interpretations,
#                                euts_to_jlb_interpreted,
#                                by=c("JlbId"="ChildNodeId")) %>%
#     select(-LinkId, -TypeId)

# find the children of jlb responses
jlb_children <-
    links %>% filter(ThoughtIdA %in% jlb_interpretations$JlbId)

links <- setdiff(links, jlb_children) # remove those from links

## Join these children to jlb and para tables
jlb_children <- left_join(jlb_interpretations, jlb_children, by=c("JlbId"="ThoughtIdA")) %>%
    select(-Id, -Meaning, -Relation)


## Add ChildName to table
jlb_table <- left_join(jlb_children, nodes %>% select(Name, Id), by=c("ThoughtIdB"="Id")) %>%
    rename(ChildId = ThoughtIdB,
           ChildName = Name)


# MUNGE PARA interp ---------------------------------------------------------------
para_responses <- para_responses %>%
    rename(Id=ThoughtIdA,
           ParaId=ThoughtIdB,
           LinkId=Id) %>% select(-Meaning, -Relation)
## Add the text from nodes to these links
para_responses <- left_join(para_responses, nodes, by=c("ParaId"= "Id")) %>%
    rename(ParaName = Name) %>%
    select(ParaName, ParaId, TypeId)


para_children <-
    links %>% filter(ThoughtIdA %in% para_responses$ParaId)
links <- setdiff(links, para_children) # remove those from links

## Join these children to jlb and para tables
para_children <- left_join(para_responses, para_children, by=c("ParaId"="ThoughtIdA")) %>%
    select(-Id, -Meaning, -Relation)

## Add ChildName to table
para_table <- left_join(para_children, nodes %>% select(Name, Id), by=c("ThoughtIdB"="Id")) %>%
    rename(ChildId = ThoughtIdB,
           ChildName = Name)



# Save objs to export -----------------------------------------------------
export <- c(paste(export), "para_table", "jlb_table")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
