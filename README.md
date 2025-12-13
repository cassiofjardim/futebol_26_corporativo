# Dashboard de Futebol (Shiny)

Este repositório é um app em Shiny com login e um dashboard “por time” (abas). A interface e os módulos já estão montados, mas os dados ainda são de exemplo (`data/base_rh.csv`) — a ideia é trocar isso por uma base real de partidas quando você estiver pronto.

## Navegação rápida
- [Rodando em 2 minutos](#rodando-em-2-minutos)
- [Credenciais de demo](#credenciais-de-demo)
- [Onde está cada coisa](#onde-esta-cada-coisa)
- [Requisitos](#requisitos)
- [Dados (trocar o mock pelo real)](#dados-trocar-o-mock-pelo-real)
- [Personalização rápida](#personalizacao-rapida)
- [Testes e CI](#testes-e-ci)

## Rodando em 2 minutos <a id="rodando-em-2-minutos"></a>
1) Abra o projeto na raiz (`Projeto 11 Futebol`).
2) Instale os pacotes (se ainda não tiver):
   - `install.packages(c("shiny","tidyverse","highcharter","ggplot2","reactable","lubridate","scales","fontawesome","readr","rmarkdown","knitr"))`
3) Rode:
   - `shiny::runApp()` (ou `shiny::runApp(".", launch.browser = TRUE)`)
4) Entre com as credenciais de demo abaixo.

## Credenciais de demo <a id="credenciais-de-demo"></a>
- Email: `demo@demo.com`
- Senha: `654321`
- Ajuste em: `R/helpers_supabase.R` (variáveis `.demo_email` e `.demo_senha`)

## Onde está cada coisa <a id="onde-esta-cada-coisa"></a>
- `app.R`: liga o app e alterna entre login e dashboard.
- `R/mod_login.R`: tela + lógica do login.
- `R/mod_dashboard.R`: abas dos clubes, leitura do CSV mock e geração do relatório.
- `R/mod_clube.R`: “template” de cada clube (KPIs, gráficos, vídeos e tabela).
- `R/helpers_supabase.R`: autenticação de demo (não é Supabase de verdade, é só um helper).
- `R/helpers_theme.R`: tema do `ggplot2` (uso futuro).
- `data/base_rh.csv`: dados de exemplo só para não deixar o app vazio.
- `www/`: escudos/imagens e o CSS em `www/styles.css`.

## Requisitos <a id="requisitos"></a>
- R instalado
- Pacotes: `shiny`, `tidyverse`, `highcharter`, `ggplot2`, `reactable`, `lubridate`, `scales`, `fontawesome`, `readr`, `rmarkdown`, `knitr`

## Dados (trocar o mock pelo real) <a id="dados-trocar-o-mock-pelo-real"></a>
- Hoje o app lê `data/base_rh.csv` em `R/mod_dashboard.R` só para alimentar os componentes.
- O “relatório” também usa métricas fictícias (xG, finalizações, posse, PPDA etc.) para preencher campos e tabela.
- Quando você trouxer sua base de futebol, o caminho mais direto é:
  - trocar a leitura em `R/mod_dashboard.R`;
  - filtrar por clube dentro de `mod_clube_server()` (em `R/mod_clube.R`).

## Personalização rápida <a id="personalizacao-rapida"></a>
- Logos/cores: mexa em `www/` e em `www/styles.css`.
- KPIs reais: substitua os placeholders em `R/mod_clube.R` por métricas do seu dataset.
- Login: se não quiser credencial fixa, `R/helpers_supabase.R` é o ponto de corte.
- Fonte/estilo: o app usa Google Fonts no `app.R` (se estiver offline, pode cair para fonte padrão).

## Testes e CI <a id="testes-e-ci"></a>
- Testes: `tests/testthat/` (runner em `tests/testthat.R`)
- CI: GitHub Actions roda em `push` e `pull_request`

### Rodando os testes localmente
1) `install.packages("testthat")`
2) `Rscript -f tests/testthat.R` (ou `testthat::test_dir("tests/testthat")`)

## Ideias que fazem sentido depois
- Conectar uma base real de partidas e fazer os filtros por clube/rodada/campeonato.
- Ajustar os KPIs/gráficos para o que você realmente quer acompanhar.
- Tirar credenciais hardcoded (usar `.Renviron`/Secrets) quando for fazer deploy.
