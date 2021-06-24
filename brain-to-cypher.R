rm(list=ls())
# P. Setup -------------------------------------------------------------------
date = "20210624" # for grabbing files. choose most rrecent or preferred brain export dump
# initialize vector for storing export object names of interest.
export <- c("data.in", "data.out")

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
source("R/make_interpreted_response_tables.R")

# 7. Extract the top-level nodes EUTS (how i tried to type end users) --------------------------------------------
source("R/create_euts_tables.R")

# 8. Responses Tables ---------------------------------------------------------
source("R/make_response_tables.R")


# 9. Add the Question Names to Links that have "Response:..." tag -----------------------------------------------
source("R/make_response_tag_link_tables.R")

# 10. Handle remaining links --------------------------------------------------
source("R/make_resp_to_resp_table.R")


# 11. Para to response ----------------------------------------------------



# 12. Jlb to Response -----------------------------------------------------



# NOTES -------------------------------------------------------------------


# top level = $EndUserTypeId EUTS -> JLB or ETUS -> PARA
# second level = JLB interpretation code JLB -> PARA
# Third level  = paraphrased PARA -> RESPONSE
# Fourth = Response RESPONSE -> RESPONSE or RESPONSE -> ~nothing~
# Fifth = Response end

# people - had response -> response
# affiliation - had response -> response



# 99. Tests -------------------------------------------------------------------

##  Need to make sure we have accounted for all the people, types, etc and that
##  the only remaining links are Response -> Response
if(any(links$ThoughtIdA %in% people$PersonId))warning("oops")
if(any(links$ThoughtIdA %in% people$OrganizationId))warning("oops")
if(any(links$ThoughtIdA %in% people$AffiliationId))warning("oops")

if(any(links$ThoughtIdB %in% people$PersonId))warning("oops")
if(any(links$ThoughtIdB %in% people$OrganizationId))warning("oops")
if(any(links$ThoughtIdB %in% people$AffiliationId))warning("oops")


# Export ------------------------------------------------------------------

source("R/export_files_for_neo4j.r")

# 999.END RUN -----------------------------------------------------------------
