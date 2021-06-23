## Munge the itnerpreted responses. I want to add the "end user type" from euts$EndUserTypeName
# Handle the JLB responses ------------------------------------------------
jlb_table <- left_join(jlb_table, euts %>% select(EndUserTypeId, EndUserTypeName), by=c("TypeId"="EndUserTypeId")) %>%
    rename(EndUserTypeId = TypeId) %>%
    ## I AM NAMING THESE PARENT RESPONSES BECAUSE THEY MAY HAVE CHILDREN RESPONSES.
    rename(ParentResponseId = ChildId, ParentResponseName = ChildName) %>%
    distinct() %>%
    relocate(EndUserTypeName, JlbName, ParentResponseName)


# Handle the interpreted responses ------------------------------------------------
para_table <- left_join(para_table, euts %>% select(EndUserTypeId, EndUserTypeName), by=c("TypeId"="EndUserTypeId")) %>%
    rename(EndUserTypeId = TypeId) %>%
    rename(ParentResponseId = ChildId, ParentResponseName = ChildName) %>%
    distinct() %>%
    relocate(EndUserTypeName, ParaName, ParentResponseName)



# Merge JLB and Para tables -----------------------------------------------
jlbpara_table <- full_join(jlb_table, para_table)


# Merge with the response->response table ---------------------------------

big_table <- left_join(jlbpara_table, links)

# now, remove all from links any links where ParentResponseId appears in big_table
links <- links %>% filter(!ParentResponseId %in% big_table$ParentResponseId) %>%
    rename(SubChildResponseId = ChildResponseId, SubChildResponseName = ChildResponseName) %>%
    rename(ChildResponseId = ParentResponseId, ChildResponseName = ParentResponseName)

# add these few remaining links as sub-child responses to big_table
big_table <- full_join(big_table, links)  %>%
    relocate(EndUserTypeName, JlbName, ParaName, ParentResponseName, ChildResponseName, SubChildResponseName)



# # Next, append peoples names to the Parent, Child, and Subchild Responses --------
# if(!all(individual_responses$ChildNodeId %in% c(big_table$ParentResponseId, big_table$ChildResponseId, big_table$SubChildResponseId))) warning("something up, see line 40-45 in munge_euts.r")

## I stop here because its my hope I can just get the full_Table , responses_with_question_tags, affiliation_respmses, and individual_responses to meld together well in neo4j




# Save objs to export -----------------------------------------------------
export <- c(paste(export), "big_table")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


