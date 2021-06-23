for(i in seq_along(export)){
    if(export[i]%in% c("data.in", "data.out"))next()

    df <- as.data.frame(eval(as.name(export[i])))

    # the nodes_orig has a list, need to munge before export
    if(export[i]=="nodes_orig") df <- nodes_orig %>% select(-TagIds)

    # write to OneDrive wd for backup
    write.csv(df, paste0(data.out, export[i], ".csv"))
    # write_json(df, paste0("data/", export[i],".json"))
    message(export[i]," successfully saved to ", data.out)

}

## Clean up all extra objects in case I wnat to source this script. from elsewhere to ping the links and nodes.
rm(list= ls()[!(ls() %in% export)])


