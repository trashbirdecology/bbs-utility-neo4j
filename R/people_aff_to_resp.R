# Grab the links associated with people and affilaitions ------------------------------------------------
person_to_resp <- links %>% filter(ThoughtIdA %in% people$PersonId)
aff_to_resp <- links %>% filter(ThoughtIdA %in% people$AffiliationId)

## remove from links
links <- setdiff(links, bind_rows(person_to_resp, aff_to_resp))




# Save objs to export -----------------------------------------------------
export <- c(paste(export), "person_to_resp", "aff_to_resp")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
