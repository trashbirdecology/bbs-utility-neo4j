
# Exploring the data exported from Dedoose and then translated and grouped via TheBrain11

# Setup -------------------------------------------------------------------
# Create an empty list in which to store objects of interest
if(!exists("export"))export <- NA
if(!exists("date"))warning("Please specify 'date' before running `import_json_from_brain.R`")
# create dir for data out if does not exist
suppressWarnings(dir.create(data.out))


nodes.fn <-  paste0(data.in, "brain_export_", date,"/thoughts.json")
links.fn <-  paste0(data.in, "brain_export_", date,"/links.json")


# Import JSON files --------------------------------------------------------------
# Load JSONs
nodes_orig <- jsonlite::stream_in(file(nodes.fn))
links_orig <- jsonlite::stream_in(file(links.fn))


# Clear junk  -------------------------------------------------------------
export <- c(paste(export),  "nodes_orig", "links_orig" ,"export")
rm(list=setdiff(ls(), export))

