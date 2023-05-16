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
        tabItems(
            tabItem(
                tabName = "mapa",
                h2("Taxa de Óbitos por 100 mil Habitantes"),
                fluidRow(
                    column(
                        width = 8,
                        box(
                            title = "Mapa dos municípios",
                            width = 12
                        )
                    ),
                    column(
                        width = 4,
                        fluidRow(
                            box(
                                title = "Ano",
                                width = 12
                            )
                        ),
                        fluidRow(
                            box(
                                title = "Estado e Município",
                                width = 12
                            )
                        )
                    )
                ),
            ),
            tabItem(
                tabName = "tabela",
                h2("Taxa de Óbitos por 100 mil Habitantes"),
                column(
                    width = 6,
                    fluidRow(
                        box(
                            width = 12,
                            title = "Série Temporal"
                        )
                    ),
                    fluidRow(
                        box(
                            width = 12,
                            title = "Estado e Município"
                        )
                    )
                ),
                column(
                    width = 6,
                    fluidRow(
                        box(
                            width = 12,
                            title = "Tabela Completa"
                        )
                    )
                )
            ),
            tabItem(
                tabName = "sobre",
                h2("Sobre:"),
                fluidRow(
                    column(
                        width = 6,
                        box(
                            width = 12,
                            title = "Metodologia"
                        )
                    ),
                    column(
                        width = 6,
                        box(
                            width = 12,
                            title = "Versionamento"
                        )
                    )
                )
            )
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