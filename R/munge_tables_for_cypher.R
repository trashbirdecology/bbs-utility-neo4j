
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
    rename(RespName.Parent = Name.Parent,
           RespName.Child = Name.Child,
           RespId.Parent = ThoughtIdA,
           RespId.Child  = ThoughtIdB
    )




# PERSON TO RESP -------------------------------------------------------------
person_to_resp <- person_to_resp %>%
    rename(PersonName = Name.Parent,
           RespName = Name.Child,
           PersonId = ThoughtIdA,
           RespId  = ThoughtIdB
    )

# AFFILIATION TO RESP -------------------------------------------------------------
aff_to_resp <- aff_to_resp %>%
    rename(AffliationName = Name.Parent,
           RespName = Name.Child,
           AffiliationId = ThoughtIdA,
           RespId  = ThoughtIdB
    )



# QUESTION TO RESP -------------------------------------------------------------
question_to_resp <- question_to_resp %>%
    rename(QuestionName = Name.Parent,
           RespName = Name.Child,
           QuestionId = ThoughtIdA,
           RespId  = ThoughtIdB
    )



# REMOVE PERIODS FROM ALL COLNAMES ----------------------------------------
names(aff_to_resp) <- gsub("\\.", "", names(aff_to_resp))
names(resp_to_jlb) <- gsub("\\.", "", names(resp_to_jlb))
names(resp_to_para) <- gsub("\\.", "", names(resp_to_para))
names(resp_to_resp) <- gsub("\\.", "", names(resp_to_resp))
names(para_to_resp) <- gsub("\\.", "", names(para_to_resp))
names(question_to_resp) <- gsub("\\.", "", names(question_to_resp))
names(questions) <- gsub("\\.", "", names(questions))
names(person_to_resp) <- gsub("\\.", "", names(person_to_resp))
names(jlb_to_para) <- gsub("\\.", "", names(jlb_to_para))
names(jlb_to_resp) <- gsub("\\.", "", names(jlb_to_resp))


