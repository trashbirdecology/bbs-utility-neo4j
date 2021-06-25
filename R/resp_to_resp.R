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

if(!all(question_to_resp$ThoughtIdA %in% questions$Id)) warning("see line 4 make_response_tag_link_tables.R")

#remove these from links
links <- setdiff(links, question_to_resp)


# Save objs to export -----------------------------------------------------
export <- c(paste(export), "resp_to_resp")

# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------
