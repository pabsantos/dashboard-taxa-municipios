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
      title = "Óbitos / 100 mil hab."
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

