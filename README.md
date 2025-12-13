# Dashboard de Futebol (demo em Shiny)

Aplicação Shiny com tela de login e um painel multi-times inspirado em um vestiário de dados de futebol. O projeto está pronto para ser conectado a uma base real de partidas, mas usa uma base de RH fictícia como placeholder apenas para validar layout, navegação e geração de relatórios.

## Principais recursos
- Login temático com credenciais de demonstração (`demo@demo.com` / `654321`), guardadas em `R/helpers_supabase.R`.
- Dashboard com abas para clubes e identidade visual por time (`R/mod_dashboard.R` + `R/mod_clube.R`), incluindo KPIs, gráficos Highcharter e área de vídeos de análise.
- Geração de relatório HTML customizado via RMarkdown direto do painel, com pré-visualização embutida e download (aba “Relatório Custom”).
- Assets prontos em `www/` (escudos, plano de fundo, ícones) e CSS próprio em `www/styles.css`.
- Estrutura modular fácil de estender: tela de login (`R/mod_login.R`) e módulo genérico de clube (`R/mod_clube.R`).

## Estrutura de pastas
- `app.R`: ponto de entrada do Shiny, carrega login e dashboard.
- `R/mod_login.R`: UI/Server do login, valida credenciais demo.
- `R/mod_dashboard.R`: navegação por times, painel de relatório e ligação com `mod_clube`.
- `R/mod_clube.R`: layout padrão por clube (KPIs, gráficos, vídeos e tabela mock).
- `R/helpers_supabase.R`: credenciais e helper de autenticação demo.
- `R/helpers_theme.R`: tema ggplot minimal para futuros gráficos.
- `data/base_rh.csv`: base fictícia usada como mock de dados (substitua por base de futebol).
- `www/`: escudos, imagens e `styles.css`.

## Requisitos
- R instalado.
- Pacotes: `shiny`, `tidyverse`, `highcharter`, `ggplot2`, `reactable`, `lubridate`, `scales`, `fontawesome`, `readr`, `rmarkdown`, `knitr`.

## Como rodar localmente
1) Abrir o projeto na raiz (`Projeto 11 Futebol`).
2) No R/RStudio, instalar os pacotes necessários (ex.: `install.packages(c("shiny","tidyverse","highcharter","reactable","lubridate","scales","fontawesome","rmarkdown"))`).
3) Executar o app: `shiny::runApp()` (ou `shiny::runApp(".", launch.browser = TRUE)`).
4) Fazer login com `demo@demo.com` e senha `654321`.

## Notas sobre dados
- Os módulos de clube usam a base placeholder `data/base_rh.csv` apenas para manter o layout estável (não é dado real de futebol).
- O relatório custom utiliza um data frame interno com métricas fictícias de futebol (xG, finalizações, posse, PPDA etc.) somente para gerar a tabela e os campos selecionáveis.
- Para plugar dados reais, troque a leitura em `R/mod_dashboard.R` e aplique filtros por clube dentro de `mod_clube_server()`.

## Customização rápida
- Credenciais demo: edite `.demo_email` e `.demo_senha` em `R/helpers_supabase.R`.
- Logos/cores: substitua imagens em `www/` e ajuste `www/styles.css` ou os blocos `tags$style` nos módulos.
- KPIs reais: troque os placeholders em `R/mod_clube.R` por métricas do seu dataset (por rodada, por jogo, etc.).
- Relatório: o template está montado em tempo de execução em `R/mod_dashboard.R`; personalize o HTML/CSS do RMarkdown conforme necessário.

## Próximos passos sugeridos
- Conectar uma base real de partidas e filtrar `dados` por clube.
- Revisar as métricas de KPI e gráficos para refletir estatísticas de jogo (xG, finalizações, posse, PPDA).
- Incluir controles de período/campeonato e filtros por posição ou atleta.
