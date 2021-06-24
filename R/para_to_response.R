
# Create df for paraphrases linked to indivudal and affiliation re --------
links %>% filter(ThoughtIdA %in% jlb_table$JlbId)
links %>% filter(ThoughtIdB %in% jlb_table$JlbId)



para_to_response <- setdiff(para_table, para_to_jlb)
if(nrow(jlb_table %>% filter(JlbChildId %in% para_to_response$JlbId))!=0)warning("see line 19 munge_euts.R")




# Save objs to export -----------------------------------------------------
export <- c(paste(export),"para_to_response")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


