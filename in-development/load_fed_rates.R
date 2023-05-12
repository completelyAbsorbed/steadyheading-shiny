################################################################################
#                                                                              #
# load_fed_rates.R                                                             #  
#                                                                              #  
#   loads, formats, and updates various interest rate series                   #  
#                                                                              #
################################################################################


################################################################################
#                                                                              #
# define constants                                                             #  
#                                                                              #
################################################################################

names_fed_rates <- c("Date",
                     "1-month",
                     "3-month",
                     "6-month",
                     "1-year",
                     "2-year",
                     "3-year",
                     "5-year",
                     "7-year",
                     "10-year",
                     "20-year",
                     "30-year")

first_five <- c("Unit:", # our assumption of the first five values in the Date column before fixing
                "Multiplier:",
                "Currency:",
                "Unique Identifier:",
                "Time Period")

################################################################################
#                                                                              #
# library() calls                                                              #  
#                                                                              #
################################################################################
library(tidyverse)

################################################################################
#                                                                              #
# function definitions                                                         #  
#                                                                              #
################################################################################

load_fed_rates_raw_from_fed <- function(filepath){
  # load the fed rates raw from the FED, and fix up the formats
  fed_rates <- read.csv(filepath)
  
  # data is in the format of Market Yield on US Treasury securities at <colname>
  # ... constant maturity, quoted on investment basis
  
  # fix the column names
  names(fed_rates) <- names_fed_rates
  
  if(!(sum(fed_rates$Date[1:5] == first_five) == 5)){
    # do nothing, our assumption about the first five rows being off is erroneous
    print("a raw file wasn't fed to load_fed_rates_raw_from_fed()")
  }else{
    # remove the first five rows, as they aren't relevant to our concerns
    fed_rates <- fed_rates[-1*(1:5),]
    head(fed_rates)
    return(fed_rates)
  }
  
  return(fed_rates)
}

write_fed_rates <- function(fed_rates,
                            separate_ND_flag = TRUE,
                            path,
                            filename){
  # if the separate_ND_flag is TRUE, separate out rows with all ND and write as a separate .DATASAVE
  # to make our lives easier, first convert all ND to ""
  if(separate_ND_flag){
    fed_rates[fed_rates == "ND"] <- ""
    empty_which <- fed_rates == ""
    empty_which_rowSums <- rowSums(empty_which)
    
    width <- dim(fed_rates)[2] - 1 # the number of maturities
    
    remove_rows <- empty_which_rowSums == width
    
    fed_rates <- fed_rates[which(!remove_rows),]
  }
  
  # write out the fed_rates dataframe as an object file .DATASAVE
  save(fed_rates,
       file = paste(path,
                    "/",
                    filename,
                    ".DATASAVE"))
  
  
}

prepare_for_plotting <- function(fed_rates,
                                 flag_replace_NA = TRUE,
                                 replacement_NA = "",
                                 flag_drop_NA = TRUE){
  # converts maturity columns to a single column and returns a dataframe ready for ggplot2
  
  dates <- fed_rates$Date # save the dates
  
  rates <- fed_rates[,-1] # lop dates off of fed_rates
  
  rates_stack <- stack(rates) # turns maturities into a factor column, "ind"
  
  rates_prepared <- data.frame(dates,
                               rates_stack[,1],
                               rates_stack[,2])
  
  names(rates_prepared) <- c("Date",
                             "Interest",
                             "Maturity")
  
  # fix the formats of the columns
  rates_prepared$Date <- as.Date(rates_prepared$Date)
  rates_prepared$Interest <- as.numeric(rates_prepared$Interest)
  
  # if flag_replace_NA is raised, replace NAs in the Interest column with the specified value
  if(flag_replace_NA){
    index_Interest_NA <- which(is.na(rates_prepared$Interest))
    rates_prepared$Interest[index_Interest_NA] <- replacement_NA
  }
  
  # if flag_drop_NA is raised, drop rows with NA
  if(flag_drop_NA){
    rates_prepared <- drop_na(rates_prepared)
  }
  
  return(rates_prepared)
  
}
