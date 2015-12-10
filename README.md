## Impulse Response Database
### Scraping/Cleaning/Analysis 

Builds a small database of IR metadata from samples contained at the OpenAIR Library (www.openairlib.net)

### Reproducing the project:

1. Clone the repo and run main.R The Html content will be downloaded into the current working directory and scraped. 

2. Run the analysis.R file to plot average reverberation times.

3. Knit the presentation.rmd file for a complete explanation of the project. 

4. Alternatively, use extraction_script.R to crawl the URLs and download files directly from openairlib.net.
NOTE: Some content from the database was manually removed due to lack of data as of this publication. This might affect 
future results of the extraction script.


required packages: rvest, dplyr, tidyr and stringr



