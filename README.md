# Dashboard de Futebol (Shiny)

Aplicação Shiny com tela de login e um painel multi-times inspirado em um “vestiário de dados” de futebol. O projeto está pronto para ser conectado a uma base real de partidas, mas usa uma base fictícia (RH) como placeholder apenas para validar layout, navegação e geração de relatórios.

## Navegação rápida
- [Principais recursos](#principais-recursos)
- [Estrutura de pastas](#estrutura-de-pastas)
- [Requisitos](#requisitos)
- [Como rodar localmente](#como-rodar-localmente)
- [Notas sobre dados](#notas-sobre-dados)
- [Customização rápida](#customizacao-rapida)
- [Próximos passos sugeridos](#proximos-passos-sugeridos)

## Credenciais de demo <a id="credenciais-de-demo"></a>
- Email: `demo@demo.com`
- Senha: `654321`
- Onde fica: `R/helpers_supabase.R`

## Principais recursos <a id="principais-recursos"></a>
- Login com credenciais de demonstração (em `R/helpers_supabase.R`).
- Dashboard com abas por clube e identidade visual por time (`R/mod_dashboard.R` + `R/mod_clube.R`).
- KPIs e gráficos (Highcharter) com componentes reativos.
- Área de vídeos para análise (placeholder).
- Relatório HTML via RMarkdown com pré-visualização e download.
- Estrutura modular fácil de estender.
- Assets em `www/` + CSS em `www/styles.css`.

## Estrutura de pastas <a id="estrutura-de-pastas"></a>
- `app.R`: ponto de entrada do Shiny (login + dashboard).
- `R/mod_login.R`: UI/Server do login (valida credenciais demo).
- `R/mod_dashboard.R`: navegação por times + relatório + ligação com `mod_clube`.
- `R/mod_clube.R`: layout padrão por clube (KPIs, gráficos, vídeos e tabela mock).
- `R/helpers_supabase.R`: credenciais + helper de autenticação demo.
- `R/helpers_theme.R`: tema `ggplot2` minimal para futuros gráficos.
- `data/base_rh.csv`: base fictícia usada como mock (substitua por base de futebol).
- `www/`: escudos, imagens e `styles.css`.

## Requisitos <a id="requisitos"></a>
- R instalado
- Pacotes: `shiny`, `tidyverse`, `highcharter`, `ggplot2`, `reactable`, `lubridate`, `scales`, `fontawesome`, `readr`, `rmarkdown`, `knitr`

## Como rodar localmente <a id="como-rodar-localmente"></a>
1) Abra o projeto na raiz (`Projeto 11 Futebol`).
2) No R/RStudio, instale os pacotes necessários, por exemplo:
   - `install.packages(c("shiny","tidyverse","highcharter","reactable","lubridate","scales","fontawesome","rmarkdown"))`
3) Execute o app:
   - `shiny::runApp()` (ou `shiny::runApp(".", launch.browser = TRUE)`)
4) Faça login com `demo@demo.com` e senha `654321`.

## Notas sobre dados <a id="notas-sobre-dados"></a>
- Os módulos de clube usam o placeholder `data/base_rh.csv` apenas para manter o layout estável (não é dado real de futebol).
- O relatório custom utiliza um data frame interno com métricas fictícias (xG, finalizações, posse, PPDA etc.) para preencher tabela e campos selecionáveis.
- Para plugar dados reais, troque a leitura em `R/mod_dashboard.R` e aplique filtros por clube dentro de `mod_clube_server()`.

## Customização rápida <a id="customizacao-rapida"></a>
- Credenciais demo: edite `.demo_email` e `.demo_senha` em `R/helpers_supabase.R`.
- Logos/cores: substitua imagens em `www/` e ajuste `www/styles.css` (ou `tags$style` nos módulos).
- KPIs reais: troque os placeholders em `R/mod_clube.R` por métricas do seu dataset (por rodada, por jogo etc.).
- Relatório: o template é montado em tempo de execução em `R/mod_dashboard.R`; personalize o HTML/CSS do RMarkdown conforme necessário.

## Próximos passos sugeridos <a id="proximos-passos-sugeridos"></a>
- Conectar uma base real de partidas e filtrar `dados` por clube.
- Revisar KPIs e gráficos para refletir estatísticas de jogo (xG, finalizações, posse, PPDA).
- Incluir controles de período/campeonato e filtros por posição ou atleta.

## Qualidade (testes e CI)
Este repositório inclui testes automatizados e CI para dar mais segurança em refactors e evolução do app.

- Testes: `tests/testthat/`
- Runner: `tests/testthat.R`
- CI: GitHub Actions executa os testes em `push` e `pull_request`.

### Como rodar os testes localmente
1) Instale o pacote de testes:
   - `install.packages("testthat")`
2) Rode na raiz do projeto:
   - `Rscript -f tests/testthat.R`
   - (alternativa) `testthat::test_dir("tests/testthat")`

## Boas práticas já adotadas
- Estrutura modular com `R/mod_*.R` (UI/Server separados por domínio).
- Separação de helpers (`R/helpers_*.R`) para reutilização e testes.
- Organização de `www/` e dados mock em `data/`.

## Sugestões de evolução
- Reprodutibilidade de pacotes com `renv` (commit do `renv.lock`).
- Remover credenciais hardcoded e usar `.Renviron`/Secrets no deploy.
- Padronização: `styler` (formatação) + `lintr` (lint) no CI.
- Aumentar cobertura de testes para regras de negócio (KPIs reais, filtros e validações).
