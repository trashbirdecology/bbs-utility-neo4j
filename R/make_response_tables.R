# Individual responses----------------------------------------------
individual_responses <- links %>%
    filter(ThoughtIdA %in% people$PersonId)
# remove from links
links <- setdiff(links, individual_responses)

# Munge indiv. responses
individual_responses <- individual_responses %>%
    select(ThoughtIdA, ThoughtIdB) %>%
    rename(PersonId=ThoughtIdA,
           PersonResponseId=ThoughtIdB)



# Individual responses----------------------------------------------
affiliation_responses <- links %>%
    filter(ThoughtIdA %in% people$AffiliationId)
# remove from links
links <- setdiff(links, affiliation_responses)

# Munge indiv. responses
affiliation_responses <- affiliation_responses %>%
    select(ThoughtIdA, ThoughtIdB) %>%
    rename(AffiliationId=ThoughtIdA,
           AffiliationResponseId=ThoughtIdB)


# Munge individual responses -----------------------------------------------------
# add names
individual_responses <- individual_responses %>%
            left_join(people %>% select(PersonId, PersonName))

# add names to responses
individual_responses <- individual_responses %>%
    left_join(nodes %>% select(Id,Name), by=c("PersonResponseId"="Id")) %>%
    rename(PersonResponseName=Name)

if(any(is.na(individual_responses$PersonResponseName))) warning("see line 34 of make_response_tables.r")





# Munge affiliation responses -----------------------------------------------------
# add names
affiliation_responses <- affiliation_responses %>%
    left_join(people %>% select(AffiliationId, AffiliationName))

# add names to responses
affiliation_responses <- affiliation_responses %>%
    left_join(nodes %>% select(Id,Name), by=c("AffiliationResponseId"="Id")) %>%
    rename(AffiliationResponseName=Name)

if(any(is.na(affiliation_responses$AffiliationResponseName))) warning("see line 34 of make_response_tables.r")




# Save objs to export -----------------------------------------------------
export <- c(paste(export), "affiliation_responses", "individual_responses")
# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


