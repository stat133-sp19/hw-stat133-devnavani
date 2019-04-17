#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving Timelines Using Three Different Modalities"),
   
   # Sidebar with a slider input for number of bins 
   fluidRow(column(4, sliderInput("amount",
                                  "Initial Amount ($):",
                                  min = 0,
                                  max = 100000,
                                  value = 1000,
                                  step = 500),
                     sliderInput("contrib",
                                  "Annual Contribution (%):",
                                  min = 0,
                                  max = 50000,
                                  value = 2000,
                                  step = 500)),
            column(4, sliderInput("return",
                                  "Return Rate (%)",
                                  min = 0,
                                  max = 20,
                                  value = 5,
                                  step = 0.1),
                   sliderInput("growth",
                               "Growth Rate (%)",
                               min = 0,
                               max = 20,
                               value = 5,
                               step = 0.1)),
            column(4, sliderInput("bins",
                                  "Years:",
                                  min = 0,
                                  max = 50,
                                  value = 20,
                                  step = 1),
                   selectInput("facet",
                               "Facet?:",
                               c("No", "Yes")))),
   verticalLayout(textOutput("timelines"),
                  plotOutput("Timelines"),
                  textOutput("Balances"),
                  tableOutput("balances"))
)
            


# Define server logic required to draw a histogram
server <- function(input, output) {
  
   output$timelines <- renderText({
      print("Timelines")
   })
   output$Timelines <- renderPlot({
      library(ggplot2)
      future_value <- function(amount, rate, years) {
        return(amount*(1 + rate)**years)
      }
      annuity <- function(contrib, rate, years) {
        return(contrib*((((1+rate)**years) - 1)/rate))
      }
      growing_annuity <- function(contrib, rate, growth, years) {
        num = (1 + rate)**years - (1 + growth)**years
        denom = rate - growth
        return(contrib*num/denom)
      }
      years <- seq(0, input$bins, 1)
      for (year in years) {
        no_contrib <- future_value(input$amount, 0.01*input$return, years)
        fixed_contrib <- future_value(input$amount, 0.01*input$return, years) + annuity(input$contrib, 0.01*input$return, years)
        growing_contrib <- growing_annuity(input$contrib, 0.01*input$return, 0.01*input$growth, years) + future_value(input$amount, 0.01*input$return, years)
      }
      modalities <- data.frame("year" = years, no_contrib, fixed_contrib, growing_contrib)
      if (input$facet == "No") {
        ggplot() + geom_line(data = modalities, aes(x = year, y = no_contrib, color = "no_contrib")) + geom_line(data = modalities, aes(x = year, y = fixed_contrib, color = "fixed_contrib")) + geom_line(data = modalities, aes(x = year, y = growing_contrib, color = "growing_contrib")) + ggtitle("Three modes of investing") + xlab("Year") + ylab("Money ($)")
      } else {
        years <- c(years, years, years)
        value <- c(no_contrib, fixed_contrib, growing_contrib)
        type <- c("no_contrib")
        for (i in seq(0, input$bins-1, 1)) {
          type <- c(type, "no_contrib")
        }
        for (i in seq(0, input$bins, 1)) {
          type <- c(type, "fixed_contrib")
        }
        for (i in seq(0, input$bins, 1)) {
          type <- c(type, "growing_contrib")
        }
        modalities = data.frame(year = years, value = value, type = type)
        modalities
        ggplot(data = modalities, aes(x = year, y = value, color = type)) + geom_line() + facet_wrap(~type) + geom_area(aes(fill = type))
      }
   })
   
   output$Balances <- renderText({
     print("Balances")
   })
   
   output$balances <- renderTable({
     
     future_value <- function(amount, rate, years) {
       return(amount*(1 + rate)**years)
     }
     annuity <- function(contrib, rate, years) {
       return(contrib*((((1+rate)**years) - 1)/rate))
     }
    
     growing_annuity <- function(contrib, rate, growth, years) {
       num = (1 + rate)**years - (1 + growth)**years
       denom = rate - growth
       return(contrib*num/denom)
     }

     years <- seq(0, input$bins, 1)
     years <- as.integer(years)
     
     for (year in years) {
       no_contrib <- future_value(input$amount, 0.01*input$return, years)
       fixed_contrib <- future_value(input$amount, 0.01*input$return, years) + annuity(input$contrib, 0.01*input$return, years)
       growing_contrib <- growing_annuity(input$contrib, 0.01*input$return, 0.01*input$growth, years) + future_value(input$amount, 0.01*input$return, years)
     }
  

     final <- data.frame(year = years, no_contrib = no_contrib, fixed_contrib = fixed_contrib, growing_contrib = growing_contrib)
     final
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

