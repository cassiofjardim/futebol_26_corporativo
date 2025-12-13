# mod_clube.R ---------------------------------------------------------------
# Módulo genérico de painel de clube
# - Mesmo layout para todos os times
# - Depois conectamos isso à base de dados de futebol

mod_clube_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    # -----------------------------------------------------------------
    # KPIs do clube
    # -----------------------------------------------------------------
    div(
      class = "kpi-row",
      
      div(
        class = "kpi-card",
        div(class = "kpi-header", span("Jogos analisados")),
        div(class = "kpi-value", textOutput(ns("kpi_jogos"))),
        div(
          class = "kpi-comment-kpi",
          "Quantidade de registros disponíveis na base para alimentar este painel (valor ilustrativo, será refinado quando a base de futebol for conectada)."
        )
      ),
      
      div(
        class = "kpi-card",
        div(class = "kpi-header", span("Vitórias")),
        div(class = "kpi-value", textOutput(ns("kpi_vitorias"))),
        div(
          class = "kpi-comment-kpi",
          "Indicador de vitórias do time no recorte atual. Neste momento é apenas um placeholder para fins de layout."
        )
      ),
      
      div(
        class = "kpi-card",
        div(class = "kpi-header", span("Gols marcados")),
        div(class = "kpi-value", textOutput(ns("kpi_gols_marcados"))),
        div(
          class = "kpi-comment-kpi",
          "Métrica que futuramente será alimentada pela base de gols. Aqui usamos um valor de exemplo para validar o design."
        )
      ),
      
      div(
        class = "kpi-card",
        div(class = "kpi-header", span("Gols sofridos")),
        div(class = "kpi-value", textOutput(ns("kpi_gols_sofridos"))),
        div(
          class = "kpi-comment-kpi",
          "Será usada para acompanhar a consistência defensiva do time ao longo da temporada."
        )
      )
    ),
    
    # -----------------------------------------------------------------
    # Layout principal: gráfico + tabela
    # -----------------------------------------------------------------
    div(
      class = "layout",
      
      # Coluna esquerda: gráfico
      div(
        class = "col-left",
        div(
          class = "card",
          h2(textOutput(ns("titulo_time"))),
          p(
            class = "card-comment",
            "Estrutura base do painel do clube. Aqui você poderá acompanhar os principais indicadores de desempenho do time, sempre utilizando a mesma arquitetura de visualização."
          ),
          p(
            class = "card-comment-data",
            "Por enquanto, este gráfico é apenas um exemplo para validar o layout. Quando a base de futebol estiver disponível, ele pode mostrar evolução de pontos, gols, vitórias, etc."
          ),
          highcharter::highchartOutput(ns("chart_placeholder"), height = "280px")
        )
      ),
      
      # Coluna direita: tabela / resumo
      div(
        class = "col-right",
        div(
          class = "card",
          h3("Resumo do painel"),
          p(
            class = "card-comment",
            "Quadro de informações gerais do clube selecionado, usado aqui apenas como mockup visual."
          ),
          p(
            class = "card-comment-data",
            "A ideia é que este bloco traga uma visão condensada: posição na tabela, desempenho recente (últimos 5 jogos), saldo de gols e outros indicadores importantes."
          ),
          tableOutput(ns("tabela_resumo"))
        )
      )
    ),
    
    # -----------------------------------------------------------------
    # Bloco extra: Análises em Vídeo + Card com 3 painéis de dados
    # -----------------------------------------------------------------
    div(
      class = "layout",
      
      # Coluna esquerda: vídeos
      div(
        class = "col-left",
        div(
          class = "card",
          h3("Análises em Vídeo – Desempenho em Campo"),
          p(
            class = "card-comment",
            "Este card é um protótipo para a área de vídeo análise do clube. No futuro, cada time poderá ter seus próprios vídeos táticos, lances chave e resumos de partida."
          ),
          p(
            class = "card-comment-data",
            "Use as abas abaixo para alternar entre diferentes conteúdos de vídeo. Aqui estamos usando três exemplos do YouTube, apenas para ilustrar como essa experiência ficará dentro do dashboard."
          ),
          
          # Abas internas com vídeos do YouTube -----------------------
          tabsetPanel(
            id   = ns("tabs_videos"),
            type = "tabs",
            
            tabPanel(
              "Análise 1",
              div(
                style = "margin-top:10px;",
                p(
                  class = "card-comment-data",
                  "Exemplo de vídeo 1. No futuro, este espaço pode trazer avaliações específicas de jogos, análises de gols marcados ou compactos táticos deste clube."
                ),
                tags$iframe(
                  width = "100%",
                  height = "315",
                  src = "https://www.youtube.com/embed/5RbUKdkE02Q",
                  title = "YouTube video player",
                  frameborder = "0",
                  allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
                  allowfullscreen = NA
                )
              )
            ),
            
            tabPanel(
              "Análise 2",
              div(
                style = "margin-top:10px;",
                p(
                  class = "card-comment-data",
                  "Exemplo de vídeo 2. Pode ser usado para focar em análise defensiva, posicionamento sem bola ou comportamento da equipe em fases específicas do jogo."
                ),
                tags$iframe(
                  width = "100%",
                  height = "315",
                  src = "https://www.youtube.com/embed/5RbUKdkE02Q",
                  title = "YouTube video player",
                  frameborder = "0",
                  allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
                  allowfullscreen = NA
                )
              )
            ),
            
            tabPanel(
              "Análise 3",
              div(
                style = "margin-top:10px;",
                p(
                  class = "card-comment-data",
                  "Exemplo de vídeo 3. Ideal para reunir clipes de scouting, análise individual de atletas ou comparativos entre partidas."
                ),
                tags$iframe(
                  width = "100%",
                  height = "315",
                  src = "https://www.youtube.com/embed/5RbUKdkE02Q",
                  title = "YouTube video player",
                  frameborder = "0",
                  allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
                  allowfullscreen = NA
                )
              )
            )
          )
        )
      ),
      
      # Coluna direita: card com 3 painéis (linha, barras, tabela)
      div(
        class = "col-right",
        div(
          class = "card",
          h3("Análises Táticas em Dados"),
          p(
            class = "card-comment",
            "Painel complementar de dados para apoiar a leitura dos vídeos: tendência de desempenho, distribuição de ações e visão tabular de métricas."
          ),
          p(
            class = "card-comment-data",
            "Os gráficos abaixo são placeholders. Quando a base de futebol estiver plugada, este card pode mostrar métricas como xG, finalizações, posse, desarmes e muito mais."
          ),
          
          tabsetPanel(
            id   = ns("tabs_metricas"),
            type = "tabs",
            
            # Aba 1: Gráfico de linha ---------------------------------
            tabPanel(
              "Linha",
              div(
                style = "margin-top:10px;",
                highcharter::highchartOutput(ns("chart_linha"), height = "260px")
              )
            ),
            
            # Aba 2: Gráfico de barras -------------------------------
            tabPanel(
              "Barras",
              div(
                style = "margin-top:10px;",
                highcharter::highchartOutput(ns("chart_barras"), height = "260px")
              )
            ),
            
            # Aba 3: Tabela ------------------------------------------
            tabPanel(
              "Tabela",
              div(
                style = "margin-top:10px;",
                tableOutput(ns("tabela_metricas"))
              )
            )
          )
        )
      )
    )
  )
}

mod_clube_server <- function(id, dados_reactive, nome_time) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # Título do painel ----------------------------------------------
    output$titulo_time <- renderText(nome_time)
    
    # Dados base (no futuro, filtraremos por nome_time) -------------
    dados_time <- reactive({
      df <- dados_reactive()
      if (is.null(df)) return(NULL)
      df
    })
    
    # KPIs (por enquanto, ilustrativos) -----------------------------
    output$kpi_jogos <- renderText({
      df <- dados_time()
      if (is.null(df)) return("-")
      nrow(df)  # só para ter um número na tela
    })
    
    # Valores fixos apenas para layout – depois substituímos por métricas reais
    output$kpi_vitorias      <- renderText("—")
    output$kpi_gols_marcados <- renderText("—")
    output$kpi_gols_sofridos <- renderText("—")
    
    # Gráfico placeholder principal ---------------------------------
    output$chart_placeholder <- highcharter::renderHighchart({
      highcharter::highchart() %>%
        highcharter::hc_title(text = paste("Evolução de desempenho -", nome_time)) %>%
        highcharter::hc_xAxis(categories = c("Rodada 1", "Rodada 2", "Rodada 3", "Rodada 4", "Rodada 5")) %>%
        highcharter::hc_add_series(
          name = "Índice de desempenho (exemplo)",
          data = c(1, 3, 2, 4, 5),
          type = "line"
        )
    })
    
    # Tabela placeholder --------------------------------------------
    output$tabela_resumo <- renderTable({
      data.frame(
        Métrica = c("Clube", "Status do painel", "Observação"),
        Valor   = c(
          nome_time,
          "Layout base configurado",
          "Quando a base de futebol estiver disponível, este painel passará a exibir informações reais do time."
        ),
        check.names = FALSE
      )
    })
    
    # ---------------------- CARD DE 3 PAINÉIS ----------------------
    # Gráfico de linha (tendência fictícia por rodada) --------------
    output$chart_linha <- highcharter::renderHighchart({
      categorias <- c("R1", "R2", "R3", "R4", "R5", "R6")
      indice     <- c(0.8, 1.1, 0.9, 1.3, 1.2, 1.4)
      
      highcharter::highchart() %>%
        highcharter::hc_title(text = "Tendência de desempenho (exemplo)") %>%
        highcharter::hc_xAxis(categories = categorias, title = list(text = "Rodadas")) %>%
        highcharter::hc_yAxis(title = list(text = "Índice relativo")) %>%
        highcharter::hc_add_series(
          name = "Índice tático",
          data = indice,
          type = "line"
        )
    })
    
    # Gráfico de barras (distribuição fictícia de ações) ------------
    output$chart_barras <- highcharter::renderHighchart({
      categorias <- c("Ataque", "Defesa", "Transição", "Bolas Paradas")
      valores    <- c(35, 25, 20, 15)
      
      highcharter::highchart() %>%
        highcharter::hc_title(text = "Distribuição de ações em campo (exemplo)") %>%
        highcharter::hc_xAxis(categories = categorias, title = list(text = NULL)) %>%
        highcharter::hc_yAxis(title = list(text = "Índice / quantidade relativa")) %>%
        highcharter::hc_add_series(
          name = "Peso por fase do jogo",
          data = valores,
          type = "column"
        )
    })
    
    # Tabela de métricas simuladas ----------------------------------
    output$tabela_metricas <- renderTable({
      data.frame(
        Métrica      = c("xG (esperado)", "Finalizações", "Posse de bola", "Passes certos", "Desarmes"),
        Valor        = c("1.75", "12", "54%", "410", "18"),
        Interpretação = c(
          "Volume ofensivo razoável, com bom número de chances criadas.",
          "Time finaliza com frequência, mas qualidade pode ser refinada.",
          "Posse equilibrada, sem domínio absoluto do jogo.",
          "Boa consistência na circulação de bola.",
          "Nível de agressividade defensiva interessante."
        ),
        check.names = FALSE
      )
    })
  })
}
