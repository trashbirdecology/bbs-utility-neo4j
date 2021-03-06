## deal with people, affiliations, orgs

# Assign orgs and affiliations to people ----------------------------------------
bbs_affiliations.lookup <- nodes %>%
    filter(Kind==4) %>%
    filter(!str_detect(Name, "(?i)org")) %>%
    filter(str_detect(Name, "(?i)bbs"))

organizations.lookup <- nodes %>%
    filter(Kind==4) %>%
    filter(str_detect(Name, c("(?i)academ|cws|usgs|fws|agency|dept.|agenc|bbs")))

## Remove from NODES
nodes <- setdiff(nodes, bind_rows(organizations.lookup, bbs_affiliations.lookup))

# People nodes and links ---------------------------------
# any remaining nodes swith Kind =4 should be only people..
people <- nodes %>%
    filter(Kind==4)

## remove these from NODES
nodes <- setdiff(nodes, people)
# Only need NAme and ID
people <- people %>% select(Name, Id)

# Assign affiliations  to the people ------------------------------------------
# These are all the links assigned to BBS Stakeholders oor Employees
affiliation.links <-
    links %>% filter(ThoughtIdA %in% bbs_affiliations.lookup$Id &
                     ThoughtIdB %in% people$Id)

links <- setdiff(links, affiliation.links)
## munge
affiliation.links <- affiliation.links %>% select(ThoughtIdA, ThoughtIdB) %>%
    rename(AffiliationId=ThoughtIdA, PersonId=ThoughtIdB)
## Add affiliation names to affiliation links
affiliations <- full_join(affiliation.links, bbs_affiliations.lookup %>% select(Name,Id), by=c("AffiliationId"="Id")) %>%
    rename(AffiliationName=Name)

# Assign  organizations to the people ------------------------------------------
# These are all the links assigned to BBS Stakeholders oor Employees
organizations.links <-
    links %>% filter(ThoughtIdA %in% organizations.lookup$Id &
                         ThoughtIdB %in% people$Id)
# Remove from links
links <- setdiff(links, organizations.links)
# Munge for easy joining
organizations.links <- organizations.links %>% select(ThoughtIdA, ThoughtIdB) %>%
    rename(OrganizationId = ThoughtIdA,
           PersonId = ThoughtIdB)

## Add org names from org nodes table
organizations <- left_join(organizations.links, organizations.lookup %>% select(Name, Id),
          by=c("OrganizationId" = "Id")) %>%
    rename(OrganizationName=Name)

people <- full_join(people %>% rename(PersonName=Name, PersonId=Id), organizations)

## Finally, append affiliations to the people
people <- full_join(people, affiliations)

## Manually edit the academic folx
people <- people %>%
    mutate(AffiliationId = case_when(is.na(AffiliationId) ~ "999999999X", !is.na(AffiliationId)~AffiliationId),
              AffiliationName = case_when(is.na(AffiliationName) ~ "Academia", !is.na(AffiliationId)~AffiliationName)
    )


# Pull out the codes for paraphrases and JLB interp -----------------------
para.lookup.id <- people %>%
    filter(str_detect(PersonName, "(?i)paraphrase")) %>%
    rename(ParaId = PersonId) %>%
    rename(ParaName = PersonName) %>%
    select(ParaId, ParaName)

jlb.lookup.id <- people %>%
    filter(str_detect(PersonName, "(?i)jlb" )) %>%
    rename(JlbId = PersonId, JlbName = PersonName) %>%
    select(JlbId, JlbName)


# remove these from people tbl
people <- people %>% filter(!PersonId %in% c(para.lookup.id$ParaId, jlb.lookup.id$JlbId))


# A test --------------------------------------------------------------------

if(any(people$OrganizationId %in%links$ThoughtIdA)  |
   any(people$OrganizationId %in%links$ThoughtIdB)  |
   any(people$PersonId %in%links$ThoughtIdB)
   )warning("Check out make_tags_table around line 86")



# Save objs to export -----------------------------------------------------
export <- c(paste(export), "people")

# remove all else from mem
rm(list=setdiff(ls(), c(export, "para.lookup.id", "jlb.lookup.id")))

# End run ----------------------------------------------------------------

