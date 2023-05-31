## Fontes

Os dados de mortes relacionadas à sinistros de trânsito têm como fonte o Sistema de Informações de Mortalidade (SIM), do Departamento de Informática do Sistema Único de Saúde do Brasil (DATASUS) - Ministério da Saúde. Filtrou-se as declarações de óbito cuja causa se encontra entre os códigos CID-10 entre V01 e V89. Os dados foram coletados com auxílio do pacote [`microdatasus`](www.github.com/rfsaldanha/microdatasus), de autoria de [rfsaldanha](www.github.com/rfsaldanha).

Os dados de população por município são estimativas elaboradas pelo Instituto Brasileiro de Geografia e Estatística (IBGE) utilizadas pelo Tribunal de Contas da União (TCU), e foram coletados através do sistema [Tabnet](https://datasus.saude.gov.br/informacoes-de-saude-tabnet/) do DATASUS.

Os dados espaciais de cada município brasileiro também têm como fonte o IBGE e foram coletados através do pacote [`geobr`](www.github.com/ipeagit/geobr), produzido pelo Instituto de Pesquisa Econômica Aplicada (IPEA)

## Referências

Pereira, R.H.M.; Gonçalves, C.N.; et. all (2019) geobr: Loads Shapefiles of Official Spatial Data Sets of Brazil. GitHub repository - https://github.com/ipeaGIT/geobr.

SALDANHA, Raphael de Freitas; BASTOS, Ronaldo Rocha; BARCELLOS, Christovam. Microdatasus: pacote para download e pré-processamento de microdados do Departamento de Informática do SUS (DATASUS). Cad. Saúde Pública, Rio de Janeiro , v. 35, n. 9, e00032419, 2019 . Available from <http://ref.scielo.org/dhcq3y>.
