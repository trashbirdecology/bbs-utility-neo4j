
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
jlb_interpretations <- links %>% filter(ThoughtIdA %in% jlb.lookup.id)
# grab all the nodes that have the JLB tags
paraphrased_responses <- links %>% filter(ThoughtIdA %in% para.lookup.id)

## remove all these from LINKS
links <- setdiff(links, bind_rows(paraphrased_responses, jlb_interpretations))

# Munge the names  --------------------------------------------------------
paraphrased_responses <- paraphrased_responses %>%
    rename(Id=ThoughtIdA,
           ChildNodeId=ThoughtIdB,
           LinkId=Id) %>% select(-Meaning, -Relation)



# Munge the names  --------------------------------------------------------
jlb_interpretations <- jlb_interpretations %>%
    rename(Id=ThoughtIdA,
           ChildNodeId=ThoughtIdB,
        LinkId=Id) %>% select(-Meaning, -Relation)




# Save objs to export -----------------------------------------------------
export <- c(paste(export), "paraphrased_responses", "jlb_interpretations")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
