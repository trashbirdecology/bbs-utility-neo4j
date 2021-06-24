# Pull out nodes describving the end user types ---------------------------

euts <- nodes %>% filter(Name==Label | !is.na(Label))
# remove thse from  nodes
# nodes <- setdiff(nodes,euts)


# Pull out links containing end user types --------------------------------
euts.links <- links %>% filter(ThoughtIdA %in% euts$Id)
# remove those from links
links <- setdiff(links, euts.links)


# Add names to euts  ------------------------------------------------------
euts.links <- euts.links %>%
    full_join(euts,
          by=c("ThoughtIdA"="Id"))  %>%
    select(-Meaning, -Relation, -TypeId, -Label, -Kind)


euts.links <- euts.links %>%
    rename(EndUserTypeName=Name,
                      EndUserTypeId = ThoughtIdA,
                      ChildNodeId=ThoughtIdB,
                      LinkId=Id)

rm(euts)



# euts-to-jlb -------------------------------------------------------------
euts_to_jlb <- euts.links %>%
    filter(ChildNodeId %in% jlb_table$JlbId)


# euts-to-para ----------------------------------------
euts_to_paraphrased <-
    euts.links %>% filter(ChildNodeId %in% para_table$ParaId)


if(!all(euts.links$EndUserTypeId %in%  c(euts_to_jlb$EndUserTypeId, euts_to_paraphrased$EndUserTypeId))) warning("see line 41 create_euts._tables.R for issue")

# Clear junk  -------------------------------------------------------------
export <- c(paste(export),"euts_to_paraphrased", "euts_to_jlb")
rm(list=setdiff(ls(), export))
