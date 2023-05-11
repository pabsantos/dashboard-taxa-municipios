# setup -------------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(tmap)

load("data/geo_municipios_pontos.rda")

source("utils.R")

# app ---------------------------------------------------------------------

ui <- dashboardPage(
    dashboardHeader(
        title = p(
            "Mortalidade no Trânsito Brasileiro",
            style = "font-size:12px"
        )
    ),
    dashboardSidebar(
        sidebarMenu(
            menuItem(
                "Mapa",
                tabName = "mapa",
                icon = icon("map")
            ),
            menuItem(
                "Tabela",
                tabName = "tabela",
                icon = icon("table")
            ),
            menuItem(
                "Sobre",
                tabName = "sobre",
                icon = icon("info-circle")
            )
        )
    ),
    dashboardBody(
        tabItem(
            tabName = "mapa",
            fluidRow(
                column(
                    width = 8,
                    box(
                        width = 12
                    )
                ),
                column(
                    width = 4,
                    fluidRow(
                        box(
                            width = 12
                        )
                    ),
                    fluidRow(
                        box(
                            width = 12
                        )
                    )
                )
            ),
        ),
        tabItem(
            tabName = "tabela"
        )
    ),
    dashboardFooter(
        left = p("Observatório Nacional de Segurança Viária (2023"),
        right = img("")
    ),
    title = "Dados Municipais da Mortalidade no Trânsito Brasileiro"
)

server <- function(input, output, session) {
      
}

shinyApp(ui, server)