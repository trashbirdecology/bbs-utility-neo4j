## I need to join these things together in order of most broad to least


# Join euts, jlb, para ------------------------------------
df <- full_join(euts_to_jlb, jlb_to_para)
df <- full_join(euts_to_para, df)


# Add questions to all the responses --------------------------------------
jlb_to_resp <- jlb_to_resp %>% left_join(question_to_resp)
para_to_resp <- jlb_to_resp %>% left_join(question_to_resp)
people_aff_to_resp <- jlb_to_resp %>% left_join(question_to_resp)

missing_questions <-c(jlb_to_resp$RespName[is.na(jlb_to_resp$QuestionName)],
                      para_to_resp$RespName[is.na(para_to_resp$QuestionName)])
write.table(missing_questions, "warnings/BRAIN_ALERT_TO_DO.txt")


# Incorporate more responses --------------------------------------------------------------------
df <- full_join(df, jlb_to_resp)
df <- full_join(df, para_to_resp)
df <- full_join(df, resp_to_para)

df <- full_join(df, people_aff_to_resp)



df <- df %>%
    relocate(EutsName, JlbName, ParaName, AffiliationName, PersonName, RespName)



# Save objs to export -----------------------------------------------------
export <- c(paste(export), "df")

# remove all else from mem
rm(list=setdiff(ls(), export))
