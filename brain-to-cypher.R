rm(list=ls())

# Setup -------------------------------------------------------------------
date = "20210615" # for grabbing files. choose most rrecent or preferred brain export dump
# initialize vector for storing export object names of interest.
export <- c("data.in", "data.out")

# set path to data in and data out.
## in my case, this data is private so need to specify a path.
## data.dir should be the parent directory for subdirectories c(data, data-raw).
## if dirs do not exist, will create.
data.in <- "/Users/jburnett/OneDrive - DOI/research/bbs_utility/neo4j-brain-data/data-raw/"
data.out <- "/Users/jburnett/OneDrive - DOI/research/bbs_utility/neo4j-brain-data/data/"


# Packages ----------------------------------------------------------------
library(rjson); library(jsonlite)
library(tidyverse)

# Data In -----------------------------------------------------------------
## Import the raw json files as exported from TheBrain
source("R/import_json_from_brain.R")

# Munge and QA/QC ------------------------------------------------------------
## Lightly munges the links and nodes data frames.
source("R/munge_brain.R")

# Define tags, types ------------------------------------------------------
source("R/get_tags_types.R")



# Tests -------------------------------------------------------------------
## need to run custom tests here for going back and editing the data in thebrain
source("R/run_tests.R")



# END RUN -----------------------------------------------------------------
