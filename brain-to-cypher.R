rm(list=ls())
# P. Setup -------------------------------------------------------------------
date = "20210625" # for grabbing files. choose most rrecent or preferred brain export dump
# initialize vector for storing export object names of interest.
export <- c("data.in", "data.out")
## create a directory to throw warnings and notes into
dir.create("warnings")

# set path to data in and data out.
## in my case, this data is private so need to specify a path.
## data.dir should be the parent directory for subdirectories c(data, data-raw).
## if dirs do not exist, will create.
data.in <- "/Users/jburnett/OneDrive - DOI/research/bbs_utility/neo4j-brain-data/data-raw/"
data.out <- "/Users/jburnett/OneDrive - DOI/research/bbs_utility/neo4j-brain-data/data/"

# 0. Packages ----------------------------------------------------------------
library(rjson); library(jsonlite)
library(tidyverse); library(janitor)

# 1. Data In -----------------------------------------------------------------
## Import the raw json files as exported from TheBrain
source("R/import_json_from_brain.R")

# 2. Munge and QA/QC ------------------------------------------------------------
## Lightly munges the links and nodes data frames.
source("R/munge_brain.R")

# 4. Extract questions ------------------------------------------------------
source("R/make_questions_table.R")

# 5. Create table of people,orgs, and affiliations -----------------------------------------------
source("R/make_people_table.R")

# 6. Extract the interpreted and paraphrased responses -------------------------------------------------------------------------
source("R/jlb_para_euts_tables.R")

# 7. Add the Question Names to Links that have "Response:..." tag -----------------------------------------------
source("R/question_to_resp.R")

# 8. People, affiliations to responses ------------------------------------
source("R/people_aff_to_resp.R")

# 9. Resp to Resp ---------------------------------------------------------
source("R/resp_to_resp.R")

# 10. Final munge of data frames for cypher -------------------------------
source("R/munge_tables_for_cypher.R")

# 11. Make a single, big ass DF  --------------------------------------------------
source("R/make_single_df.R")
## This isnt going to do what I want i think. I should figure out how to export the relationships from neo4j



# 12. Export useful dfs  --------------------------------------------------
source("R/export_files_for_neo4j.R")



# NOTES -------------------------------------------------------------------



# 99. Tests -------------------------------------------------------------------

##  Need to make sure we have accounted for all the people, types, etc and that
##  the only remaining links are Response -> Response
if(any(links$ThoughtIdA %in% people$PersonId))warning("oops")
if(any(links$ThoughtIdA %in% people$OrganizationId))warning("oops")
if(any(links$ThoughtIdA %in% people$AffiliationId))warning("oops")

if(any(links$ThoughtIdB %in% people$PersonId))warning("oops")
if(any(links$ThoughtIdB %in% people$OrganizationId))warning("oops")
if(any(links$ThoughtIdB %in% people$AffiliationId))warning("oops")



# 999.END RUN -----------------------------------------------------------------
print(export)
