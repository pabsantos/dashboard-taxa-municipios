load("data/geo_municipios_pontos.rda")
load("data/geo_municipios_poly.rda")

tmap_mode("view")

plot_obitos_map <- function(ano) {
  municipios_ano <- filter(geo_municipios_ponto, ano_ocorrencia == ano)
  
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