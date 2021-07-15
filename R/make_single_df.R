## I need to join these things together in order of most broad to least

# A bunch of joins--------------------------------------------------------df <-
df <- euts_to_jlb %>% select(JlbName, JlbId, EutsName, EutsId) %>%
    full_join(euts_to_para %>% select(ParaName, ParaId, EutsName, EutsId)) %>%
    full_join(para_to_resp %>% select(ParaName, RespName, RespId, ParaId)) %>%
    full_join(jlb_to_resp %>% select(JlbName, RespName, JlbId, RespId))



    full_join(aff_to_resp) %>% select(AffliationName, RespName, AffiliationId, RespId) %>%
    full_join(person_to_resp %>% select(PersonName, RespName, PersonId, RespId)) %>%
    full_join(question_to_resp %>% select(QuestionName, QuestionId, RespName, RespId)) %>%
    full_join(resp_to_para %>% select(RespName, ParaName, ParaId, RespId)) %>%
    full_join(resp_to_resp %>% select(RespNameParent, RespNameChild, RespIdChild, RespIdParent),
              by=c("RespName"="RespNameParent", "RespId"="RespIdParent")) %>%
    full_join(resp_to_jlb %>% select(RespId, JlbId, RespName, JlbName)) %>%


# Reorder names for my sanity ---------------------------------------------
df <- df %>% relocate(QuestionName, EutsName, JlbName, ParaName, RespName, RespNameChild, AffliationName, PersonName)


# Toying around with conditional relationships ---------------------------------------------

temp <- df %>% filter(!is.na(EutsName) & !is.na(JlbName))
temp <- setdiff(df, temp)




# Create indices for rules ---------------------------------------------------------
emp <- c("Smith","Sauer", "Hudson", "Pardieck", "Ziolkowski",
         "Aponte", "Francis")
acad <- c("Rosenberg", "Marra")
stake <- setdiff(unique(people$PersonName), c(emp, acad))


# Munge the cells ---------------------------------------------------------
unique(resp_to_jlb$JlbId)
unique(resp_to_para$ParaId)
e <- c(unique(euts_to_jlb$EutsId), unique(euts_to_para$EutsId))


# HIDDEN RELATIONSHIPS ------------------------
aff_to_resp %>% distinct(RespId)
aff_to_resp %>% distinct(RespId)



# Save objs to export -----------------------------------------------------
export <- c(paste(export), "df")

# remove all else from mem
rm(list=setdiff(ls(), export))
