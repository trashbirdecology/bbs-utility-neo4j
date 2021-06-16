
# Create a lookup table for brain metadata --------------------------------
## These were taken from this forum: https://forums.thebrain.com/post/in-links-json-what-are-these-fields-10616870
## I could not find this in their documentation...
defs <- read.csv("data-raw/brain-meta-ref.csv") # this will be saved in the package

defs <- defs %>% mutate(num=as.integer(num))


# Munge a little for ease of joining with nodes and links -----------------
# defs.wide <- defs %>% select(-explanation) %>% pivot_wider(
#     names_from=ind,
#     values_from=num)
defs.links <- defs %>% filter(source=="Links.json") %>%
    select(-source)
defs.nodes <- defs %>% filter(source=="Thoughts.json") %>%
    select(-source)

# Append the defs metadata to nodes and links -----------------------------
## Unless theres a more eloquent way to do this..
## We need to append meaning descriptions to
# left_join(nodes, defs.nodes) -> test

# merge defs with nodes and links

objs.defs <- list(defs.nodes, defs.links)
objs.df <- list(nodes, links)
names(objs.df) <- c("nodes", "links")
for(j in seq_along(objs.defs)) {
    cols = unique(objs.defs[[j]]$ind)
    for (i in seq_along(cols)) {
        index = cols[i]
        def.df <- objs.defs[[j]]
        data.df <-  objs.df[[j]]
        if(!index %in% names(data.df)) next(print(paste("skipping",index, "...DNE")))
        def.df <- def.df %>% filter(ind %in% index) %>%
            select(-ind) %>%
            rename(
                !!index := num,!!paste0(index, "Explanation") := explanation,
                !!paste0(index, "RelationshipText") := text
            )
        if(names(objs.df)[j]=="nodes") {nodes <- left_join(nodes, def.df)}
        if(names(objs.df)[j]=="links") {links <- left_join(links, def.df)}

        # print(paste("i=",i, "j=",j))
    }
}


# Clear junk  -------------------------------------------------------------
export <- c(paste(export), "defs")
rm(list=setdiff(ls(), export))
