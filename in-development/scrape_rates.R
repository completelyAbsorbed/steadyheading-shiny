# scrape fed rates

library(tidyverse)
library(rvest)

webpage_h15 <- "https://www.federalreserve.gov/releases/h15/"

selector_date <- ".date" # //*[contains(concat( " ", @class, " " ), concat( " ", "dates", " " ))]

html_h15 <- read_html(webpage_h15)

html_h15 |> html_elements(selector_date)
