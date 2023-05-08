################################################################################
#                                                                              #
# scrape_helper.R                                                              #  
#                                                                              #  
#   helper functions to make webscraping tasks easier                          #  
#                                                                              #
################################################################################


################################################################################
#                                                                              #
# library() calls                                                              #  
#                                                                              #
################################################################################

library(tidyverse)    
library(rvest)        # webscraping
library(lubridate)    # date processing


################################################################################
#                                                                              #
# function definitions                                                         #  
#                                                                              #
################################################################################

thresh <- function(unthreshed,
                   chaff){
  # 'threshes' a character object - removes a known, unnecessary substring
  
  # "separate the wheat from the chaff"
  wheat <- str_remove(string = unthreshed,
                      pattern = chaff)
  
  # return the threshed character object
  return(wheat)
}

load_page <- function(url){
  # loads a page to scrape from
  
  page <- read_html(url)
  
  return(page)
}

pull_character_element <- function(page,
                                   selector){
  # pulls a character element from a loaded webpage
  
  # pull the element
  element_raw <- page |> html_elements(selector)
  
  # transform the element to human-readable format
  element_readable <- html_text2(element_raw)
  
  # return the readable element
  return(element_readable)
  
}

pull_date_element <- function(format_date = "mdy",
                              chaff,
                              page,
                              selector_pull){
  # pulls a date element from a loaded webpage
  
  if(format_date == "mdy"){
    date_element <- lubridate::mdy(pull_character_element(page = page,
                                                          selector = selector))
  }else{
    # something went wrong, format_date isn't "mdy"
  }
  
  # separate the chaff from date_element
  date_element_trimmed <- thresh(unthreshed = date_element,
                                 chaff = chaff)
  
  return(date_element_trimmed)
}