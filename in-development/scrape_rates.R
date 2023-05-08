# scrape fed rates

library(tidyverse)
library(rvest)
library(lubridate)

# define the url we will pull from
webpage_h15 <- "https://www.federalreserve.gov/releases/h15/"

# define the selector for the release date
selector_date <- ".dates"

# read the webpage
html_h15 <- read_html(webpage_h15)

# pull the release date element
raw_date_release <- html_h15 |> html_elements(selector_date)

# define a character variable from the xml_nodeset element for release date
date_release <- html_text2(raw_date_release)

# define the chaff to separate from date_release
chaff_release_date <- "Release date: "

# trim the tags and unnecessary text from date_release
date_release_trimmed <- str_remove(string = date_release,
                                   pattern = chaff_release_date)


# finalize processing of the element into Date() format
date_of_release <- lubridate::mdy(date_release_trimmed)


### ### functionalize the above process, add to a helper script file, make this one be rates specific  ### ### 
