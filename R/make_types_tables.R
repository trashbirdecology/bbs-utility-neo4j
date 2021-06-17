## types


# Pull all the nodes that are "typed" ----------------------------------
typed_nodes_all <- nodes %>%
    filter(!is.na(TypeId))

# Identify the types that are first-level, ways of describing end users (above JLB)
temp <- typed_nodes_all %>% distinct(TypeId, .keep_all=TRUE)

eut_cats <- nodes %>% filter(Id %in% temp$TypeId)
# Remove from nodes
nodes <- setdiff(nodes, eut_cats)



# Pull out... -------------------------------------------------------------
# which TypeIds appear in typed_nodes_all and aren not in nodes$typeId =- these should_sto[]



# source("brain-to-cypher.R")



## Remove from nodes
nodes <- setdiff(nodes, typed_nodes_all)



# Save objs to export -----------------------------------------------------
export <- c(paste(export), "typed_nodes_all")
# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------




