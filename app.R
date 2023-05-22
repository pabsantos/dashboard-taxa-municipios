# setup -------------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(bs4Dash)
library(shinyWidgets)
library(tmap)
library(sf)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(DT)

source("utils.R")

# app ---------------------------------------------------------------------

# ui ----------------------------------------------------------------------

tab_mapa <- tabItem(
  tabName = "mapa",
  h2("Taxa de Óbitos por 100 mil Habitantes"),
  fluidRow(
    column(
      width = 8,
      box(
        title = "Mapa dos municípios",
        width = 12,
        tmapOutput("map_obitos", height = 600)
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
            choices = unique(geo_municipios_ponto$uf |> sort()),
            options = list(size = 10,`live-search` = TRUE)
          ),
          pickerInput(
            inputId = "filter_municipio",
            label = "",
            choices = unique(sort(geo_municipios_ponto$nome_municipio)),
            options = list(size = 10,`live-search` = TRUE)
          ),
          actionButton(
            "search_municipio",
            "Pesquisar",
            icon = icon("magnifying-glass")
          )
        )
      )
    )
  )
)

tab_tabela <- tabItem(
  tabName = "tabela",
  h2("Taxa de Óbitos por 100 mil Habitantes"),
  fluidRow(
    column(
      width = 6,
      fluidRow(box(
        width = 12,
        title = "Série Temporal",
        plotlyOutput("grafico")
      )),
      fluidRow(box(
        width = 12,
        title = "UF e Município",
        pickerInput(
          inputId = "plot_filter_uf",
          label = "Selecione local:",
          choices = unique(geo_municipios_ponto$uf |> sort()),
          options = list(size = 10,`live-search` = TRUE, `actions-box` = TRUE),
          multiple = TRUE
        ),
        pickerInput(
          inputId = "plot_filter_municipio",
          label = "",
          choices = unique(sort(geo_municipios_ponto$nome_municipio)),
          options = list(size = 10,`live-search` = TRUE, `actions-box` = TRUE),
          multiple = TRUE
        )
      ))
    ),
    column(
      width = 6,
      fluidRow(box(
        width = 12,
        title = "Tabela Completa",
        DTOutput("tabela")
      ))
    )
  )
)

tab_sobre <- tabItem(
  tabName = "sobre",
  h2("Sobre:"),
  fluidRow(
    column(width = 6, box(
      width = 12,
      title = "Metodologia",
      includeMarkdown("metodologia.md")
    )),
    column(width = 6, box(
      width = 12,
      title = "Versionamento",
      includeMarkdown("versionamento.md")
    ))
  )
)

ui <- dashboardPage(
  skin = "midnight",
  header = dashboardHeader(
    title = img(src = "onsv_logo_branco.png", width = "100%", align = "center")
  ),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem("Mapa", tabName = "mapa", icon = icon("map")),
      menuItem("Tabela", tabName = "tabela", icon = icon("table")),
      menuItem("Sobre", tabName = "sobre", icon = icon("info-circle"))
    ),
    skin = "dark"
  ),
  body = dashboardBody(tabItems(tab_mapa, tab_tabela, tab_sobre)),
  footer = dashboardFooter(
    left = "Observatório Nacional de Segurança Viária (2023)",
    right = tags$a(href = "https://www.onsv.org.br", "onsv.org.br")
  ),
  title = "Dados Municipais da Mortalidade no Trânsito Brasileiro",
  dark = NULL
)

# server ------------------------------------------------------------------

server <- function(input, output, session) {

# Mapa --------------------------------------------------------------------
  
  observe({
    novos_muns <- subset(
      geo_municipios_ponto,
      uf == input$filter_uf
    )
    
    novos_muns <- novos_muns$nome_municipio
    
    updatePickerInput(
      session = session,
      inputId = "filter_municipio",
      choices = sort(unique(novos_muns))
    )
  })
  
  plot_map <- reactive({
    plot_obitos_map(input$filter_ano)
  })
  
  zoom_map <- reactive({
    zoom_obitos_map(input$filter_uf, input$filter_municipio)
  })
  
  output$map_obitos <- renderTmap({
    if (input$search_municipio) {
      plot_map() + zoom_map()
    } else {
      plot_map()
    }
  })
  
# Tabela ------------------------------------------------------------------
  
  observe({
    novos_muns_plot <- subset(
      geo_municipios_ponto,
      uf %in% input$plot_filter_uf
    )
    
    novos_muns_plot <- novos_muns_plot$nome_municipio
    
    updatePickerInput(
      session = session,
      inputId = "plot_filter_municipio",
      choices = sort(unique(novos_muns_plot))
    )
  })
  
  make_plotly <- reactive({
    req(input$plot_filter_municipio)
    plot_timeseries(input$plot_filter_municipio)
  })
  
  output$grafico <- renderPlotly({
    make_plotly()
  })
  
}

shinyApp(ui, server)