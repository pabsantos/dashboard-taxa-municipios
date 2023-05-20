load("data/geo_municipios_pontos.rda")
load("data/geo_municipios_poly.rda")

tmap_mode("view")
tmap_options(check.and.fix = TRUE)

geo_municipios_ponto |> 
filter(ano_ocorrencia == 2011) |>   
tm_shape() +
  tm_dots(
    col = "taxa_pop",
    size = "taxa_pop",
    alpha = 0.5,
    border.lwd = 0.5,
    # palette = "reds",
    style = "cont",
    id = "nome_municipio"
  )

geo_final |> 
  filter(ano_ocorrencia == 2021) |> 
  tm_shape() +
  tm_polygons(col = "taxa_pop", alpha = 0.5, lwd = 0.5)

geo_municipios_ponto |> 
  filter(ano_ocorrencia == 2011) |>
  ggplot() +
  geom_sf()
