# This is the original source script to grab the Html files for placement in the 
# project repo on github. These files are downloaded locally and then scraped.
# If you do not want to build the files locally this script can be used to build
# a local Html repo directly from openairlib.net

load("./crawler.rda") # loads crawler

library(stringr)

### Extracts websites, filters out 2 bad entries and builds into a local directory

web_urls = crawler()
web_urls = web_urls[c(-37, -44)]  # no freq data for these pages - eliminating

if (!dir.exists("Html")){
    dir.create("Html")
}

sapply(web_urls, function(i){
    
    download.file(
        paste("http://www.openairlib.net",i,sep=""), 
        destfile=paste("./Html/", str_extract(i,pattern="[^\\/]*$"),sep=""),
        mode = 'wb'
    ) 
})

