 library(shiny)
 library(ggplot2)
 library(dplyr)
 library(RSQLite)
library(DBI)
library(plotly)
# fluidPage(sidebarLayout(
#   sidebarPanel(
#     #selectInput("year","year",choices = c(2017,2018,2019))),
#     sliderInput("year","year", min = 2017, max = 2019,value=2018, sep ="")),
#   mainPanel(plotOutput("primaryschoolplot"),
#             plotOutput("primbar"),
#             plotlyOutput("primadata")
# )))
ui <- navbarPage("Makueni Dashboard",
                 tabPanel("Education",
                          sliderInput("year","year", min = 2017, max = 2019,value=2018, sep =""),
                          plotOutput("primbar")),
                 
                 tabPanel("Agriculutre",
                          plotOutput("foodcropplot")),
                 tabPanel("Component 3"),
                 
                 tags$head(
                   tags$style(
                     HTML(
                       "
                            body{
                              background-color: yellow;
                            }
                            h2#app-header {
                            font-size: 28px;
                            font-family: monospaace;
                            color: #47a451;
                            text-align: center;
                            }
                            
                            "
                     )
                   )
                   
                   
                 ),
    
)

