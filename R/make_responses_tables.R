# # Actual responses by people ----------------------------------------------
# # Next, grab all the links describing org-ppl relations
# ## this grabs the links where the person has that response
individual_responses <- links %>% filter(ThoughtIdA %in% people$PersonId)

# Responses attributed to affiliations  -----------------------------------
affiliation_responses <- links %>% filter(ThoughtIdA %in% unique(people$AffiliationId))
## remove from links
links <- setdiff(links, bind_rows(affiliation_responses, individual_responses))


# Add names to tables -----------------------------------------------------
affiliation_responses <- affiliation_responses %>%
    select(ThoughtIdA, ThoughtIdB, Id) %>%
    rename(AffiliationId  = ThoughtIdA,
           LinkId = Id,
           ChildNodeId = ThoughtIdB) %>%
        left_join(people %>% select(AffiliationId, AffiliationName))


individual_responses <- individual_responses %>%
    select(ThoughtIdA, ThoughtIdB, Id) %>%
    rename(PersonId  = ThoughtIdA,
           LinkId = Id,
           ChildNodeId = ThoughtIdB) %>%
    left_join(people %>% select(PersonId, PersonName))



# Add the response text to each table now ---------------------------------
affiliation_responses <- left_join(affiliation_responses, nodes %>% select(Id, Name), by=c("ChildNodeId"="Id")) %>%
    distinct(ChildNodeId, AffiliationId, .keep_all=TRUE)
individual_responses <- left_join(individual_responses, nodes %>% select(Id, Name), by=c("ChildNodeId"="Id"))


# Save objs to export -----------------------------------------------------
export <- c(paste(export), "affiliation_responses", "individual_responses")
# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


