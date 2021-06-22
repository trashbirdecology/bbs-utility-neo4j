rm(list=ls())
# P. Setup -------------------------------------------------------------------
date = "20210622" # for grabbing files. choose most rrecent or preferred brain export dump
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

# 3. Add brain metadata ------------------------------------------------------
## I am not currently running this because its not really needed.
# source("R/add_brain_metadata.R")

# 4. Extract questions ------------------------------------------------------
source("R/make_questions_table.R")

# 5. Extract the interpreted and paraphrased responses -------------------------------------------------------------------------
source("R/make_interpreted_responses_table.R")

# 6. Create table of people,orgs, and affiliations -----------------------------------------------
source("R/make_people_table.R")


# 7. Extract the top-level nodes EUTS (how i tried to type end users) --------------------------------------------
source("R/create_euts_table.R")

# 8. skldfjdskl j ---------------------------------------------------------

source("R/make_responses_tables.R")



# 99. Tests -------------------------------------------------------------------

##  Need to make sure we have accounted for all the people, types, etc and that
##  the only remaining links are Response -> Response
if(any(links$ThoughtIdA %in% people$PersonId))warning("oops")
if(any(links$ThoughtIdA %in% people$OrganizationId))warning("oops")
if(any(links$ThoughtIdA %in% people$AffiliationId))warning("oops")

if(any(links$ThoughtIdB %in% people$PersonId))warning("oops")
if(any(links$ThoughtIdB %in% people$OrganizationId))warning("oops")
if(any(links$ThoughtIdB %in% people$AffiliationId))warning("oops")

if(any(links$ThoughtIdA %in% euts_to_jlb_interpreted$EndUserTypeId))warning("oops")
if(any(links$ThoughtIdB %in% euts_to_jlb_interpreted$EndUserTypeId))warning("oops")

if(any(links$ThoughtIdA %in% euts_to_paraphrased$EndUserTypeId))warning("oops")
if(any(links$ThoughtIdB %in% euts_to_paraphrased$EndUserTypeId))warning("oops")

if(any(links$ThoughtIdA %in% euts_to_paraphrased$EndUserTypeId))warning("oops")
if(any(links$ThoughtIdB %in% euts_to_paraphrased$EndUserTypeId))warning("oops")


# Export ------------------------------------------------------------------

source("R/export_files_for_neo4j.r")

# 999.END RUN -----------------------------------------------------------------
