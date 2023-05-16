# setup -------------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(tmap)

source("utils.R")

# app ---------------------------------------------------------------------

ui <- dashboardPage(
    skin = "midnight",
    header = dashboardHeader(
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
                            width = 12,
                            tmapOutput(
                                "map_obitos",
                                height = 600
                            )
                        )
                    ),
                    column(
                        width = 4,
                        fluidRow(
                            box(
                                title = "Ano do Óbito",
                                width = 12,
                                sliderInput(
                                    "filter_ano",
                                    label = "Selecione o ano:",
                                    value = 2011,
                                    min = 2011,
                                    max = 2021,
                                    step = 1,
                                    animate = TRUE,
                                    sep = ""
                                )
                            )
                        ),
                        fluidRow(
                            box(
                                title = "UF e Município",
                                width = 12,
                                pickerInput(
                                    inputId = "filter_uf",
                                    label = "Selecione local para zoom:", 
                                    choices = unique(
                                        geo_municipios_ponto$uf |> sort()
                                    ),
                                    options = list(
                                        size = 10,
                                        `live-search` = TRUE
                                    )
                                ),
                                pickerInput(
                                    inputId = "filter_municipio",
                                    label = "",
                                    choices = unique(
                                        sort(
                                            geo_municipios_ponto$nome_municipio
                                        )
                                    ),
                                    options = list(
                                        size = 10,
                                        `live-search` = TRUE
                                    )
                                )
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