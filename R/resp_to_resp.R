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



# Some remaining links are resp->para  ------------------------------------
resp_to_para <- links %>%
    filter(ThoughtIdB %in% c(para_to_resp$ThoughtIdA) &
               !ThoughtIdA %in% c(euts_to_jlb$TypeId.Parent, euts_to_para$TypeId.Parent))


### see what's remaining
t=links.test %>% select(ThoughtIdA, ThoughtIdB)
t2=resp_to_para %>% select(ThoughtIdA, ThoughtIdB)
links.test <- setdiff(t, t2)



# This last one, for now, is resp to jlb ----------------------------------
resp_to_jlb <- links.test %>% left_join(links)

 # Save objs to export -----------------------------------------------------
export <- c(paste(export), "resp_to_resp", "resp_to_para", "resp_to_jlb")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
