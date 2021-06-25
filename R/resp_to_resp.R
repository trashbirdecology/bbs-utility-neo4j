# Grab remaining links that are respo to response
resp_to_resp <-
    links %>%
    filter(!ThoughtIdA %in% c(jlb_to_para$ThoughtIdA,
                              jlb_to_resp$ThoughtIdA,
                              para_to_resp$ThoughtIdA,
                              euts_to_jlb$TypeId.Parent,
                              euts_to_para$TypeId.Parent,
                              person_to_resp$ThoughtIdA,
                              question_to_resp$ThoughtIdA,
                              aff_to_resp$ThoughtIdA
                              )) %>%
    filter(!ThoughtIdB %in% c(jlb_to_para$ThoughtIdA,
                              jlb_to_resp$ThoughtIdA,
                              para_to_resp$ThoughtIdA,
                              euts_to_jlb$TypeId.Parent,
                              euts_to_para$TypeId.Parent,
                              person_to_resp$ThoughtIdA,
                              question_to_resp$ThoughtIdA,
                              aff_to_resp$ThoughtIdA
    ))

#remove these from links
links <- setdiff(links, resp_to_resp)



# Check to maek sure we have all links covered. ---------------------------
links.test <- links %>%
    filter(!ThoughtIdA %in% unique(nodes_orig$TypeId)) %>%
    distinct(ThoughtIdA, ThoughtIdB, Name.Parent, Name.Child)

links.test <- links.test %>%
    filter(!ThoughtIdA %in% c(jlb_to_para$ThoughtIdA,
                                                         jlb_to_resp$ThoughtIdA,
                                                         para_to_resp$ThoughtIdA,
                                                         euts_to_jlb$TypeId.Parent,
                                                         euts_to_para$TypeId.Parent,
                                                         person_to_resp$ThoughtIdA,
                                                         question_to_resp$ThoughtIdA,
                                                         aff_to_resp$ThoughtIdA
    ))


## the remaining links are also resp resp to resp..

links.test


# Save objs to export -----------------------------------------------------
export <- c(paste(export), "resp_to_resp")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
