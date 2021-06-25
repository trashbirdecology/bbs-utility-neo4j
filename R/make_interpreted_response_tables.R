# Make tables for the noodes describing paraphrased responses and for JLB interp


# Paraphrased Responses ---------------------------------------------------
para_ids <- links.full %>% filter(ThoughtIdA %in% para.lookup.id$ParaId) %>%
    select(ThoughtIdB) %>% rename(ParaId = ThoughtIdB)

#these are all the links where a paraphrased category/phrase is the parent
para_links <- links.full %>% filter(ThoughtIdA %in% para_ids$ParaId)




# # grab all the nodes which have a "JLB interpretation" tag on it.
# jlb_ids <- links %>% filter(ThoughtIdA %in% jlb.lookup.id$JlbId) %>%
#     select(ThoughtIdB) %>% rename(JlbId = ThoughtIdB)
#
# # Make a table for jlb --> paraphrased responses
# jlb_to_para <- links %>% filter(ThoughtIdA %in% jlb_ids$JlbId & ThoughtIdB %in% para_ids$ParaId)
# ## remove these from links
# links <- setdiff(links, jlb_to_para)
#
# # links <- links %>%
# #     filter(!ThoughtIdB %in% jlb_ids$JlbId) %>%
# #     filter(!ThoughtIdB %in% para_ids$ParaId)
#
#
# # next, grab all the links where jlb_ids and para_ids are parent ----------------
# jlb_interpretations <- links %>% filter(ThoughtIdA %in% jlb_ids$JlbId)
# para_responses <- links %>% filter(ThoughtIdA %in% para_ids$ParaId)
#
# ## remove these links from links df
# links <- setdiff(links, bind_rows(jlb_interpretations, para_responses))
#
# # MUNGE JLB interp ---------------------------------------------------------------
# jlb_interpretations <- jlb_interpretations %>%
#     rename(JlbId = ThoughtIdA,
#             JlbChildId  = ThoughtIdB,
#            LinkId = Id) %>%
#     select(-Meaning,-Relation)
#
# ## Add the text from nodes to the JLB id (parent)
# jlb_interpretations <- left_join(jlb_interpretations, nodes, by=c("JlbId"= "Id")) %>%
#     rename(JlbName = Name) %>%
#     select(JlbName, JlbId, TypeId, JlbChildId)
#
# ## Add text from nodes to the child node
# jlb_table <- left_join(jlb_interpretations, nodes, by=c("JlbChildId"= "Id")) %>%
#     rename(JlbChildName = Name) %>%
#     select(JlbName, JlbChildName,  JlbId, JlbChildId)
#
# if(any(links$ThoughtIdA %in% jlb_table$JlbId))warning("see line 44 in make_interppreted_response_tables.r")
#





# MUNGE PARA interp ---------------------------------------------------------------
para_responses <- para_responses %>%
    rename(ParaId = ThoughtIdA,
           ParaChildId  = ThoughtIdB,
           LinkId = Id) %>%
    select(-Meaning,-Relation)

## Add the text from nodes to the JLB id (parent)
para_responses <- left_join(para_responses, nodes, by=c("ParaId"= "Id")) %>%
    rename(ParaName = Name) %>%
    select(ParaName, ParaId, TypeId, ParaChildId)

## Add text from nodes to the child node
para_table <- left_join(para_responses, nodes, by=c("ParaChildId"= "Id")) %>%
    rename(ParaChildName = Name) %>%
    select(ParaName, ParaChildName,  ParaId, ParaChildId)

if(any(links$ThoughtIdA %in% para_table$ParaId))warning("see line 44 in make_interppreted_response_tables.r")


# Identify the JLB->Paraphrase links------------------------------------------------------



# Save objs to export -----------------------------------------------------
export <- c(paste(export), "para_table", "jlb_table", "jlb_to_para_table")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
