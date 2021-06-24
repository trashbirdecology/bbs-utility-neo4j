# The remaining links should all be response -> response..
if(unique(links$Meaning)!= 1) warning("see line 2 make_resp_to_resp_table.R. should only have `1` as a meaning remaining in links df")
if(any(links$ThoughtIdA %in% c(jlb_to_para_table$JlbId, jlb_to_para_table$ParaId, questions$Id, people$PersonId,
                            people$OrganizationId, people$AffiliationId))) warning("see line 2 make_resp_to_resp_table.R")


# Munge remaining links ----------------------------------------------------------------------
links <- links %>% select(ThoughtIdA, ThoughtIdB)

### remaining should be only response to response
resp_to_resp_table <- links %>% left_join(nodes %>% select(Name, Id), by=c("ThoughtIdA"="Id")) %>%
    rename(ParentResponseId = ThoughtIdA, ParentResponseName=Name)
resp_to_resp_table <- resp_to_resp_table %>% left_join(nodes %>% select(Name, Id), by=c("ThoughtIdB"="Id")) %>%
    rename(ChildResponseId = ThoughtIdB, ChildResponseName=Name)


# Remove these from links -------------------------------------------------



# Clear junk  -------------------------------------------------------------
export <- c(paste(export),"resp_to_resp_table")
rm(list=setdiff(ls(), export))
