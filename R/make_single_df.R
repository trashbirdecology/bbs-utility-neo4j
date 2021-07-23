## I need to join these things together in order of most broad to least

# Join euts, jlb, para ------------------------------------
df <- full_join(euts_to_jlb, jlb_to_para)
df <- full_join(euts_to_para, df)


# APPEND QUESTIONS TO RESPONSES --------------------------------------
jlb_to_resp <- jlb_to_resp %>% left_join(question_to_resp)
para_to_resp <- para_to_resp %>% left_join(question_to_resp)
resp_to_para <- resp_to_para %>% left_join(question_to_resp)
people_aff_to_resp <- people_aff_to_resp %>% left_join(question_to_resp)
# add questions to responses parent
resp_to_resp <- resp_to_resp %>% left_join(question_to_resp,
                                           by=c("RespNameParent"="RespName", "RespIdParent"="RespId")) %>%
    rename(QuestionNameParent=QuestionName,
           QuestionIdParent=QuestionId)
# add questions to responses child
resp_to_resp <- resp_to_resp %>% left_join(question_to_resp,
                                           by=c("RespNameParent"="RespName", "RespIdParent"="RespId")) %>%
    rename(QuestionNameChild=QuestionName,
           QuestionIdChild=QuestionId)


# TESTS/WARNINGS ----------------------------------------------------------
# make a note to address the missing questions, if necessary
resp_missing_question_tag <-c(jlb_to_resp$RespName[is.na(jlb_to_resp$QuestionName)],
                              para_to_resp$RespName[is.na(para_to_resp$QuestionName)],
                              resp_to_resp$RespNameParent[is.na(resp_to_resp$QuestionNameParent)],
                              resp_to_resp$RespNameChild[is.na(resp_to_resp$QuestionNameChild)]
                      )
if(length(resp_missing_question_tag)>=1) write.table(resp_missing_question_tag, "warnings/resp_missing_question_tag.txt")

# figure out which response parents adn children arent represented in existing responses
ind <- c(resp_to_para$RespName,
         jlb_to_resp$RespName,
         para_to_resp$RespName)
missing_responses <- resp_to_resp %>%
    filter(!RespNameParent %in% ind & !RespNameChild %in% ind) %>%
    select(RespNameParent, RespNameChild)
if(nrow(missing_responses)>=1) write.csv(missing_responses, "warnings/orphan_responses.csv")



# APPEND RESPONSES to df --------------------------------------------------
temp <- full_join(resp_to_para, para_to_resp) %>%
    full_join(df)

temp <- temp %>% full_join(jlb_to_resp)

temp <- temp %>% full_join(people_aff_to_resp)

temp <- temp %>% full_join(resp_to_resp, by=c("RespName"="RespNameParent",
                                              "RespId"="RespIdParent"))



# Reorder vars ------------------------------------------------------------
df <- temp %>%
    relocate(EutsName, JlbName, ParaName, AffiliationName, PersonName, RespName, QuestionName)

THIS ISNT RIGHT.... THE JOINS ARE NOT WORKING PROPERLy

# Save objs to export -----------------------------------------------------
export <- c(paste(export), "df")

# remove all else from mem
rm(list=setdiff(ls(), export))
