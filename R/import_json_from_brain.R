
# Exploring the data exported from Dedoose and then translated and grouped via TheBrain11

# Setup -------------------------------------------------------------------
# Create an empty list in which to store objects of interest
export <- list()
if(!exists("date"))warning("Please specify 'date' before running `import_json_from_brain.R`")
# create dir for data out if does not exist
suppressWarnings(dir.create(data.out))


nodes.fn <-  paste0(data.in, "brain_export_", date,"/thoughts.json")
links.fn <-  paste0(data.in, "brain_export_", date,"/links.json")


# Import JSON files --------------------------------------------------------------
# Load JSONs
nodes_orig <- jsonlite::stream_in(file(nodes.fn))
links_orig <- jsonlite::stream_in(file(links.fn))

# # Create a lookup table for TheBrain relationships
# ## These were grabbed from this forum: https://forums.thebrain.com/post/in-links-json-what-are-these-fields-10616870
# defs <- read.csv("thebrain_lookup.csv") %>% select(name, value, explanation)
# t <- read.csv("grid.csv")
# t <- t %>% filter(!(is.na(Meaning) & is.na(Kind) & is.na(Relation)))
# for(i in 1:nrow(t)){
#     m.ind = t$Meaning[i]
#     k.ind = t$Kind[i]
#     r.ind = t$Relation[i]
#     t$Meaning.def[i] = defs$explanation[defs$name=="Meaning" & defs$value==m.ind]
#     t$Kind.def[i] = defs$explanation[defs$name=="Kind" & defs$value==k.ind]
#     t$Relation.def[i] = defs$explanation[defs$name=="Relation" & defs$value==r.ind]
#
#  }
# write.csv(t, "data-raw/thebrain_lookup.csv)

# Import the created lookup table of code definitions
defs <-
    read.csv(paste0(data.in, "thebrain_lookup.csv")) %>% mutate(Explanation = if_else(
        !is.na(Relation.def),
        paste0("ThoughtIdA has ", Relation.def, " ThoughtIdAB"),
        "NA"
    ))


# Clear junk  -------------------------------------------------------------
rm(links.fn, nodes.fn, date)

