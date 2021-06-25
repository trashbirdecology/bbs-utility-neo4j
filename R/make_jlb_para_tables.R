# Make tables for the noodes describing paraphrased responses and for JLB interp
# Paraphrased Responses ---------------------------------------------------
para_ids <- links %>% filter(ThoughtIdA %in% para.lookup.id$ParaId) %>%
    select(ThoughtIdB) %>% rename(ParaId = ThoughtIdB)

#these are all the links where a paraphrased category/phrase is the parent
para_links <- links %>% filter(ThoughtIdA %in% para_ids$ParaId)

## remove from links df
links <- setdiff(links, para_links)


# JLB responses -----------------------------------------------------------
jlb_ids <- links %>% filter(ThoughtIdA %in% jlb.lookup.id$JlbId) %>%
    select(ThoughtIdB) %>% rename(JlbId = ThoughtIdB)

#these are all the links where a paraphrased category/phrase is the parent
jlb_links <- links %>% filter(ThoughtIdA %in% jlb_ids$JlbId)

## remove from links df
links <- setdiff(links, jlb_links)






# EUTS TO JLB -------------------------------------------------------------
euts_to_jlb <- jlb_links %>%
    filter(!is.na(TypeName.Parent)) %>%
    distinct(Name.Parent, TypeName.Parent, ThoughtIdA, TypeId.Parent)

# EUTS TO PARA ------------------------------------------------------------
euts_to_para <- para_links %>%
    filter(!is.na(TypeName.Parent)) %>%
    distinct(Name.Parent, TypeName.Parent, ThoughtIdA, TypeId.Parent)

# JLB TO PARA -------------------------------------------------------------
## Find the paraaphrased responses that appear in jlb_links
jlb_to_para <- jlb_links %>% filter(ThoughtIdB %in% para_ids$ParaId)

# JLB TO RESP -------------------------------------------------------------
### all the remaining should be JLB to RESPONSE
jlb_to_resp <- setdiff(jlb_links, jlb_to_para)



# PARA TO RESP ------------------------------------------------------------
para_to_resp <- para_links




# Save objs to export -----------------------------------------------------
export <- c(paste(export), "euts_to_para", "euts_to_jlb",
            "jlb_to_para",
            "jlb_to_resp", "para_to_resp"
            )

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
