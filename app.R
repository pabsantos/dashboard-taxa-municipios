# setup -------------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(tmap)

load("data/geo_municipios_pontos.rda")

source("utils.R")

# app ---------------------------------------------------------------------

ui <- dashboardPage(
    skin = "midnight",
    header = dashboardHeader(
        # title = tags$a(href = "https://www.onsv.org.br", tags$img(
        #     src = "onsv_logo.png",
        #     width = "80%"
        # ))
        title = p(
            "Mortalidade no Trânsito Brasileiro",
            style = "font-size:12px"
        )
    ),
    sidebar = dashboardSidebar(
        sidebarMenu(
            img(src = "onsv_logo_branco.png", width = "100%", align = "center"),
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
    body = dashboardBody(
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
    footer = dashboardFooter(
        left = "Observatório Nacional de Segurança Viária (2023)",
        right = tags$a(href = "https://www.onsv.org.br", "onsv.org.br")
    ),
    title = "Dados Municipais da Mortalidade no Trânsito Brasileiro"
)

server <- function(input, output, session) {
      
}

shinyApp(ui, server)