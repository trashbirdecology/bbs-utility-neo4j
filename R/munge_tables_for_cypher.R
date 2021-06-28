
# EUTS TO JLB -------------------------------------------------------------
euts_to_jlb <- euts_to_jlb %>% rename(JlbName = Name.Parent,
                       EutsName = TypeName.Parent,
                       JlbId = ThoughtIdA,
                       EutsId  = TypeId.Parent
                       )

# EUTS TO PARA ------------------------------------------------------------
euts_to_para <- euts_to_para %>% rename(ParaName = Name.Parent,
                                      EutsName = TypeName.Parent,
                                      ParaId = ThoughtIdA,
                                      EutsId  = TypeId.Parent
)

# JLB TO PARA -------------------------------------------------------------
jlb_to_para <- jlb_to_para %>%
    rename(JlbName = Name.Parent,
           ParaName = Name.Child,
           JlbId = ThoughtIdA,
           ParaId  = ThoughtIdB
    )





# JLB TO RESP -------------------------------------------------------------
jlb_to_resp <- jlb_to_resp %>%
    rename(JlbName = Name.Parent,
           RespName = Name.Child,
           JlbId = ThoughtIdA,
           RespId  = ThoughtIdB
    )

# PARA TO RESP -------------------------------------------------------------
para_to_resp <- para_to_resp %>%
    rename(ParaName = Name.Parent,
           RespName = Name.Child,
           ParaId = ThoughtIdA,
           RespId  = ThoughtIdB
    )

# RESP TO PARA -------------------------------------------------------------
resp_to_para <- resp_to_para %>%
    rename(RespName = Name.Parent,
           ParaName = Name.Child,
           RespId = ThoughtIdA,
           ParaId  = ThoughtIdB
    )
# RESP TO JLB -------------------------------------------------------------
resp_to_jlb <- resp_to_jlb %>%
    rename(RespName = Name.Parent,
           JlbName = Name.Child,
           RespId = ThoughtIdA,
           JlbId  = ThoughtIdB
    )

# RESP TO RESP -------------------------------------------------------------
resp_to_resp <- resp_to_resp %>%
    rename(RespName = Name.Parent,
           RespChildName = Name.Child,
           RespId = ThoughtIdA,
           RespChildId  = ThoughtIdB
    )



# PERSON TO RESP -------------------------------------------------------------
person_to_resp <- person_to_resp %>%
    rename(PersonName = Name.Parent,
           RespName = Name.Child,
           PersonId = ThoughtIdA,
           RespId  = ThoughtIdB
    )%>%
    select(PersonId, PersonName, RespName, RespId,
    )

## add affiliations to the person to response table
person_to_resp <- left_join(person_to_resp, people)

# AFFILIATION TO RESP -------------------------------------------------------------
aff_to_resp <- aff_to_resp %>%
    rename(AffliationName = Name.Parent,
           RespName = Name.Child,
           AffiliationId = ThoughtIdA,
           RespId  = ThoughtIdB
    ) %>%
    select(AffiliationId, AffliationName, RespName, RespId)



# QUESTION TO RESP -------------------------------------------------------------
question_to_resp <- question_to_resp %>%
    rename(QuestionName = Name.Parent,
           RespName = Name.Child,
           QuestionId = ThoughtIdA,
           RespId  = ThoughtIdB
    )


# REMOVE PERIODS FROM ALL COLNAMES ----------------------------------------

## cant figure out how to make work in aloop so will do by hand..

# for(i in seq_along(export)){
#     if( export[i] %in% c("data.in","data.out", "nodes_orig", "links_orig",
#                         "export", "nodes", "links"
#                         ))next()
#
# #remove periods in colnams
# colnames <- eval(parse(text=export[i])) %>% names()
#
# eval(parse(text=
# paste("names(export[i]) <- gsub("\\.","", colnames)")
#            ))
#
# names(eval(parse(text=export[i]))) <-
# rm(colnames)
#
# }

names(questions)  <-  gsub("\\.","", names(questions))
names(people)  <-  gsub("\\.","", names(people))
names(euts_to_para)  <-  gsub("\\.","", names(euts_to_para))
names(euts_to_jlb)  <-  gsub("\\.","", names(euts_to_jlb))
names(jlb_to_para)  <-  gsub("\\.","", names(jlb_to_para))
names(jlb_to_resp)  <-  gsub("\\.","", names(jlb_to_resp))
names(para_to_resp)  <-  gsub("\\.","", names(para_to_resp))
names(question_to_resp)  <-  gsub("\\.","", names(question_to_resp))
names(person_to_resp)  <-  gsub("\\.","", names(person_to_resp))
names(aff_to_resp)  <-  gsub("\\.","", names(aff_to_resp))
names(resp_to_resp)  <-  gsub("\\.","", names(resp_to_resp))
names(resp_to_para)  <-  gsub("\\.","", names(resp_to_para))
names(resp_to_jlb)  <-  gsub("\\.","", names(resp_to_jlb))



# END  --------------------------------------------------------------------




