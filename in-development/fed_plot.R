library(ggplot2)

# define the filepath for the working directory
# directory_working <- "C:/Users/liz/iCloudDrive/code/shiny/dashboards/public/steadyheading-shiny/in-development"

# set the working directory
# setwd(directory_working)

# define the filepath for fed rates
# filepath_fed_rates <- "C:/Users/liz/iCloudDrive/code/shiny/dashboards/public/steadyheading-shiny/in-development/data/FRB_H15.csv"
filepath_fed_rates <- "data/FRB_H15.csv"


# source the fed rates loading and transforming helper file
source("load_fed_rates.R")

# load the fed rates, prepare for plotting
rates_prepared <- filepath_fed_rates |> 
  load_fed_rates_raw_from_fed() |> 
  prepare_for_plotting(flag_replace_NA = FALSE)

# head(rates_prepared)
# tail(rates_prepared)




# start_date <- "2022-01-01"



# recent <- rates_prepared[which(rates_prepared$Date >= 
#                                  start_date),]


# head(recent)
# tail(recent)
# summary(recent)







filter_maturity <- c("1-month",
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

plot_fed_rates <- function(date_start,
                           date_end,
                           flags_maturity){
  
  recent <- rates_prepared[which(rates_prepared$Date >= 
                                   date_start),]
  
  datebreaks <- seq(from = as.Date(date_start), # https://r-graphics.org/recipe-axes-axis-date
                    to = as.Date(date_end),
                    # by = "1 month",
                    length.out = 12)
  
  filter_display <- filter_maturity[which(flags_maturity)]
  
  recent_filtered <- recent[which(recent$Maturity %in% filter_display),]
  
  # constants to automate/reactify
  interest_minimum <- 0
  interest_maximum <- recent$Interest |> max(na.rm = TRUE) |> ceiling()
  interest_by <- 0.125
  
  interestbreaks <- round(x = seq(from = interest_minimum,
                                  to = interest_maximum,
                                  # by = interest_by,
                                  length.out = 24),
                          digits = 2)
  
  plot_rates <- ggplot(data = recent_filtered,
                       mapping = aes(x = Date,
                                     y = Interest,
                                     color = Maturity,
                                     group = Maturity)) +
    geom_line() +
    scale_x_date(breaks = datebreaks) + 
    scale_y_continuous(breaks = interestbreaks,
                       limits = c(interest_minimum,
                                  interest_maximum)) + 
    theme(text = element_text(size = 16))  +
    ylab("Interest (percent)")
  
  # maturities <- unique(recent$Maturity)
  # maturities
  # filter_maturity 
  # maturities %in% filter_maturity
  
  return(plot_rates)
}