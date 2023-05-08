# scrape fed rates
# 

library(rstudioapi) # for directory finding

# define the working directory as the directory this script lives in
this_filepath <- rstudioapi::getActiveDocumentContext()$path 
working_directory <- dirname(this_filepath)

# set the working directory
setwd(working_directory)

# source the scraping helper script
source("scrape_helper.R")

# define variables
url_rates <- "https://www.federalreserve.gov/releases/h15/"
selector_date <- ".dates"
chaff_date <- "Release date: "

# load the url
page_rates <- load_page(url = url_rates)

# pull the date element
date_of_release <- pull_date_element(format_date = "mdy",
                                     chaff = chaff_date,
                                     page = page_rates,
                                     selector = selector_date)

