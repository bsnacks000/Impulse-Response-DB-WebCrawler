load("./page_information.rda")  # loads page_info helper
load("./freq_data_builder.rda") # loads freq table helper
load("./build_location.rda") # loads build-single location function
load("./page_names.rda") # loads page_names for file reference download

library(stringr)
library(dplyr)

### ::main script:: 
###    builds local HTML folder from github content...
###    creates file names from local Html folder
###    builds dataframe using lapply
###    saves resulting image for use with analysis script


# 1. Load Html files locally for scraping in working directory if not already present.
#    Creates folder Html in working directory if it does not exist and loads 
#    content from project github site.


if (!dir.exists("Html")){    
    
    base_url = "https://raw.githubusercontent.com/bsnacks000/IS607_Final/master/Html/"

    dir.create("Html")

    sapply(page_names, function(i){
        
        web_raw_url = paste(base_url,i,sep="") 
        
        download.file(
            web_raw_url, 
            destfile=paste("./Html/", str_extract(i,pattern="[^\\/]*$"),sep=""),
            mode = 'wb'
        ) 
        
    })
}
###

filenames = list.files("./Html", full.names = TRUE)
dfs = lapply(filenames, build_single_location)  # builds list of dataframes

# build large dataframe for project master and sort by Location 
large_df = dfs[[1]]
dfs = dfs[-1]

for (i in 1:length(dfs)){
    large_df = dplyr::union(large_df, dfs[[i]])
}

large_df = dplyr::arrange(large_df, Location)  # arrange by location descending
large_df ## final df for project

save.image("current_main.rda")
