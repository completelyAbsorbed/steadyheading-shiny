library(shiny)

source("fed_plot.R")




# define a custom text input class - adapted from : https://stackoverflow.com/questions/20637248/shiny-4-small-textinput-boxes-side-by-side
text_input <- function(inputId,
                       label,
                       value = "",
                       ...){
  div(style = "display-inline-block",
      tags$label(label,
                 'for' = inputId),
      tags$input(id = inputId,
                 type = "text",
                 value = value,
                 ...))
}


# Define UI for random distribution app ----
user_interface <- fluidPage(
  
  # App title ----
  titlePanel("Liz Young - Public Portfolio"),
  
  # Sidebar panel ----
  sidebarPanel(
    h3("This Page"),
    p("steadyheading.com is a Shiny app I wrote in R and Shiny to illustrate some of my analysis, programming, and visualization skills."),
    br(),
    h3("About Me"),
    p("I'm a data science nerd, expert in R, Shiny, Excel, and VBA. Open to full-time, contract-to-hire, and freelance project work."),
    br(),
    p("Experienced with - Analysis, Visualization, Business Communication, Machine Learning, SQL, SAS, Python, APL, Random Forests, XGBoost, Regression, Financial Data, Claims Data, ETL, Automation, Scraping, Loss Reserving, Property & Casualty Data, Workers Compensation, and more!"),
    br(),
    p("<<< link to youtube demo here >>>"),
    br(),
    h3("Get in Touch"),
    p("email : liz -at- completelyabsorbed -dot- com"),
    p("LinkedIn : <link>")
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Tabset ----
    tabsetPanel(type = "tabs",
                tabPanel("About",
                         img(src = "liz.jpg",
                             width = 400),
                         img(src = "polynomial.jpg",
                             width = 400),
                         br(),
                         br(),
                         p("I like spending time in nature. My cat, Polynomial is a sweet guy.")),
                tabPanel("Fed Rates",
                         br(),
                         p("Start : "),
                         splitLayout(text_input(inputId = "year_start",
                                                label = "Year",
                                                value = "2022"),
                                     text_input(inputId = "month_start",
                                                label = "Month",
                                                value = "01"),
                                     text_input(inputId = "day_start",
                                                label = "Day",
                                                value = "01")),
                         p("End : "),
                         splitLayout(text_input(inputId = "year_end",
                                                label = "Year",
                                                value = "2023"),
                                     text_input(inputId = "month_end",
                                                label = "Month",
                                                value = "06"),
                                     text_input(inputId = "day_end",
                                                label = "Day",
                                                value = "01")),
                         br(),
                         p("Maturities : "),
                         splitLayout(cellWidths = 75,
                                     checkboxInput(inputId = "maturity_1mo",
                                                   label = "1-month",
                                                   value = TRUE),
                                     checkboxInput(inputId = "maturity_3mo",
                                                   label = "3-month",
                                                   value = TRUE),
                                     checkboxInput(inputId = "maturity_6mo",
                                                   label = "6-month",
                                                   value = TRUE),
                                     checkboxInput(inputId = "maturity_1yr",
                                                   label = "1-year",
                                                   value = TRUE)),
                         splitLayout(cellWidths = 75,
                                     checkboxInput(inputId = "maturity_2yr",
                                                   label = "2-year",
                                                   value = FALSE),
                                     checkboxInput(inputId = "maturity_3yr",
                                                   label = "3-year",
                                                   value = FALSE),
                                     checkboxInput(inputId = "maturity_5yr",
                                                   label = "5-year",
                                                   value = FALSE),
                                     checkboxInput(inputId = "maturity_7yr",
                                                   label = "7-year",
                                                   value = FALSE)),
                         splitLayout(cellWidths = 75,
                                     checkboxInput(inputId = "maturity_10yr",
                                                   label = "10-year",
                                                   value = FALSE),
                                     checkboxInput(inputId = "maturity_20yr",
                                                   label = "20-year",
                                                   value = FALSE),
                                     checkboxInput(inputId = "maturity_30yr",
                                                   label = "30-year",
                                                   value = FALSE)),
                         plotOutput("plot_fed_rates",
                                    height = 750)),
                tabPanel("Weather"),
                tabPanel("Excel")
    )
  )
)



# Define server logic 
server_logic <- function(input, 
                         output) {
  
  output$plot_fed_rates <- renderPlot(
    {
      
      date_start <- paste(input$year_start,
                          "-",
                          input$month_start,
                          "-",
                          input$day_start,
                          "-",
                          sep = "")
      
      date_end <- paste(input$year_end,
                        "-",
                        input$month_end,
                        "-",
                        input$day_end,
                        "-",
                        sep = "")
      
      flags_maturity <- c(input$maturity_1mo,
                          input$maturity_3mo,
                          input$maturity_6mo,
                          input$maturity_1yr,
                          input$maturity_2yr,
                          input$maturity_3yr,
                          input$maturity_5yr,
                          input$maturity_7yr,
                          input$maturity_10yr,
                          input$maturity_20yr,
                          input$maturity_30yr)
      
      plot_fed_rates(date_start = date_start,
                     date_end = date_end,
                     flags_maturity = flags_maturity)
    }
  )
  
}

# run the app
shinyApp(ui = user_interface,
         server = server_logic)