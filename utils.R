load("data/geo_municipios_pontos.rda")

tmap_mode("view")

plot_obitos_map <- function(ano) {
  
  municipios_ano <- subset(geo_municipios_ponto, ano_ocorrencia == ano)
  
  tm_shape(municipios_ano) +
    tm_dots(
      col = "taxa_pop",
      size = "taxa_pop",
      alpha = 0.5,
      border.lwd = 0.5,
      palette = "YlOrRd",
      style = "cont",
      id = "nome_municipio",
      title = "Mortes / 100 mil hab."
    )
}

zoom_obitos_map <- function(uf, municipio) {
  coord_mun <- geo_municipios_ponto |> 
    filter(uf == uf, nome_municipio == municipio) |> 
    st_coordinates() |>
    head(n = 1)
  
  long <- coord_mun[1]
  lat <- coord_mun[2]
  
  tm_view(set.view = c(long, lat, 10))
}

plot_timeseries <- function(uf_list, municipios_list) {
  plot <- geo_municipios_ponto |> 
    mutate(uf_mun = paste(uf, nome_municipio, sep = " - ")) |> 
    filter(uf %in% uf_list, uf_mun %in% municipios_list) |> 
    drop_na() |> 
    ggplot(aes(
      x = ano_ocorrencia,
      y = taxa_pop,
      color = uf_mun,
      group = uf_mun,
      text = paste(
        "Município: ",
        uf_mun,
        "; ",
        "Taxa:",
        round(taxa_pop, digits = 2)
      )
    )) +
    geom_point() +
    geom_path() +
    theme_minimal() +
    scale_y_continuous(limits = c(0, NA)) +
    labs(x = "Ano", y = "Mortes / 100 mil hab.", color = "Município:")
  
  ggplotly(plot, tooltip = "text")
}

make_table <- function(ano) {
  geo_municipios_ponto |> 
    st_drop_geometry() |>
    as_tibble() |> 
    mutate(taxa_pop = round(taxa_pop, digits = 2)) |> 
    filter(ano_ocorrencia == ano) |> 
    select(uf, nome_municipio, taxa_pop)
  
}

uf_mun_list <- geo_municipios_ponto |> 
    st_drop_geometry() |> 
    as_tibble() |> 
    mutate(uf_mun = paste(uf, nome_municipio, sep = " - ")) |> 
    select(uf, uf_mun)