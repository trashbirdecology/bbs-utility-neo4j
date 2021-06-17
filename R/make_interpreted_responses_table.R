
# Make tables for the noodes describing paraphrased responses and for JLB interp ----------------
para.lookup.id <- nodes %>%
    filter(Kind==4) %>%
    filter(str_detect(Name, "(?i)paraphrase"))

jlb.lookup.id <- nodes %>%
    filter(Kind==4) %>%
    filter(str_detect(Name, "(?i)jlb" ))
## Remove these from NODES
nodes <- setdiff(nodes, bind_rows(jlb.lookup.id, para.lookup.id))


# grab all the nodes that have the JLB tags
jlb.interpretations <- links %>% filter(ThoughtIdA %in% jlb.lookup.id)
# grab all the nodes that have the JLB tags
paraphrased.responses <- links %>% filter(ThoughtIdA %in% para.lookup.id)

## remove all these from LINKS
links <- setdiff(links, bind_rows(paraphrased.responses, jlb.interpretations))



# Save objs to export -----------------------------------------------------
export <- c(paste(export), "paraphrased.responses", "jlb.interpretations")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
