
# # Actual responses by people ----------------------------------------------
# # Next, grab all the links describing org-ppl relations
# ## this grabs the links where the person has that response
individual_responses <- links %>% filter(ThoughtIdA %in% people$PersonId)
## remove from links
links <- setdiff(links, individual_responses)

# Responses attributed to affiliations  -----------------------------------
affliation_responses <- links %>% filter(ThoughtIdA %in% unique(people$AffiliationId))


## remove from links
links <- setdiff(links, bind_rows(affliation_responses, individual_responses))


# Save objs to export -----------------------------------------------------
export <- c(paste(export), "affliation_responses", "individual_responses")
# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


