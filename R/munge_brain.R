# Remove useless nodes and vars ----------------------------------------------------
nodes <- nodes_orig %>%
    filter(is.na(ForgottenDateTime)) %>%  ## forgotten nodes
    filter(Kind !=5) %>%  ##pinned nodes
    filter(!str_detect(tolower(Name), "top level")) %>%  ## remove the top most node, its not useful for me in analysis
    select(Name, Id, TypeId, Kind, Label)  ## keep only useful variables

removed.nodeids <- setdiff(nodes_orig$Id, nodes$Id) # An index for the nodes we removed, adn will need to remove from links
forgotten_nodes <- nodes_orig %>% filter(!is.na(ForgottenDateTime))


# Lightly Munge: LINKS ------------------------------------------------------
links <- links_orig %>%
    filter(!ThoughtIdA %in% "00000000-0000-0000-0000-000000000000") %>%
    filter(!Relation==3)  %>%  ## remove jump links
    filter(!ThoughtIdA %in% removed.nodeids) %>%
    filter(!ThoughtIdB %in% removed.nodeids) %>%
    filter(!ThoughtIdA %in% forgotten_nodes$Id) %>%
    filter(!ThoughtIdB %in% forgotten_nodes$Id) %>%
    filter(!TypeId %in% removed.nodeids) %>%
    select(ThoughtIdA, ThoughtIdB, Id, Meaning, Relation) # keep only useful cols

# QA/QC Test -------------------------------------------------------------------
# check to make sure all Thoughts are represented in the nodes (should = null ornodes charater(0))
if(!is_empty(unique(links$ThoughtIdA)[!which((unique(links$ThoughtIdA) %in% nodes_orig$Id))])) warning("links and nodes are not matching up, check it")
if(!is_empty(unique(nodes_orig$Id)[!which((unique(nodes_orig$Id) %in%links$ThoughtIdA))])) warning("links and nodes are not matching up, check it")
if(!is_empty(unique(nodes_orig$Id)[!which((unique(nodes_orig$Id) %in%links$ThoughtIdB))])) warning("links and nodes are not matching up, check it")


# Next, append all the names to the ThoughtIdA and ThoughtIdB -------------
temp <- links %>% left_join(nodes, by=c("ThoughtIdA"='Id'))
links.full <- temp %>% left_join(nodes, by=c("ThoughtIdB"= "Id"),  suffix=c(".Parent",".Child")) %>%
    rename(LinkId=Id)



# Next, add the TypeNames to TypeId n links -------------------------------
## first, grab all the "typeids" from ndoes
type_ids <- nodes %>% filter(!is.na(TypeId)) %>% distinct(TypeId) %>%
    rename(Id=TypeId)
## append the names to this df
euts <- type_ids %>% left_join(nodes %>% select(Id, Name)) %>%
    rename(TypeName=Name)

# Add end user type names to the links df -------------------------------------------------------------------------
links <- links.full %>% left_join(euts, by=c("TypeId.Parent"="Id")) %>% left_join(euts, by=c("TypeId.Child"="Id"), suffix=c(".Parent",".Child"))

# reorder cols
links <- links %>% relocate(Name.Parent, Name.Child,
                   TypeName.Parent, TypeName.Child,
                   Label.Parent, Label.Child)


# Save objs to export -----------------------------------------------------
export <- c(paste(export), "nodes", "links")
if(exists("defs")) export <- c(paste(export), "defs")
# remove all else from mem
rm(list=setdiff(ls(), export))

# End run -----------------------------------------------------------------


