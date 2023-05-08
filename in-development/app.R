library(shiny)

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
                tabPanel("Fed Rates"),
                tabPanel("Weather"),
                tabPanel("Excel")
    )
    
  )
  
)

# Define server logic 
server_logic <- function(input, 
                         output) {
  
  
  
}

# run the app
shinyApp(ui = user_interface,
         server = server_logic)