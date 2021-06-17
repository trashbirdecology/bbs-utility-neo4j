
# # Actual responses by people ----------------------------------------------
# # Next, grab all the links describing org-ppl relations
# ## this grabs the links where the person has that response
# actual_responses <- links %>% filter(ThoughtIdA %in% people$Id)
# ## remove from links
# links <- setdiff(links, actual_responses)
#
