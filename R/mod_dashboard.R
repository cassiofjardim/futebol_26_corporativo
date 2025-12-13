# mod_dashboard.R — Abas de times com scroll + módulo de clube ----------------

mod_dashboard_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    # CSS inline para garantir aplicação imediata no painel (estética estilo Fluent/Microsoft)
    tags$style(HTML("
      body {
        font-family: 'Segoe UI', 'Inter', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        background: radial-gradient(circle at 12% 20%, rgba(59,130,246,0.08), transparent 32%),
                    radial-gradient(circle at 82% 12%, rgba(99,102,241,0.08), transparent 32%),
                    linear-gradient(135deg, #f5f7fb 0%, #e9edf7 40%, #eef1f8 100%);
        color: #0f172a;
      }
      .header {
        background: linear-gradient(90deg, rgba(255,255,255,0.94), rgba(245,248,255,0.96));
        border-bottom: 1px solid #dce3f5;
        box-shadow: 0 10px 30px rgba(15,23,42,0.08);
        border-radius: 14px;
        margin: 12px 16px 8px;
        padding: 12px 20px;
      }
      .logo-image { filter: drop-shadow(0 4px 10px rgba(0,0,0,0.1)); }
      .subtitle-rigarr { color: #475569; font-size: 12px; line-height: 1.4; }
      .user-area { color: #0f172a; }
      .header .btn {
        background: linear-gradient(90deg, #2563eb, #1d4ed8);
        color: #fff;
        border: none;
        font-weight: 700;
        border-radius: 10px;
        padding: 6px 14px;
        box-shadow: 0 10px 25px rgba(37, 99, 235, 0.25);
      }
      .tabs-scroll-container { margin: 0 16px 12px; }
      .tabs-scroll-container .nav-tabs {
        border-bottom: 1px solid #d9e1f2;
      }
      .tabs-scroll-container .nav-tabs > li > a {
        background: #f3f6fc;
        color: #1f2a44;
        border-radius: 14px 14px 0 0;
        border: 1px solid transparent;
        padding: 8px 16px;
      }
      .tabs-scroll-container .nav-tabs > li > a:hover {
        background: #e7ecf8;
        color: #111827;
      }
      .tabs-scroll-container .nav-tabs > li.active > a,
      .tabs-scroll-container .nav-tabs > li.active > a:hover,
      .tabs-scroll-container .nav-tabs > li.active > a:focus {
        background: linear-gradient(90deg, #2563eb, #1d4ed8);
        color: #fff;
        border: 1px solid #1d4ed8;
        border-bottom-color: transparent;
        border-top: 3px solid #22c55e;
      }
      .kpi-row { padding: 16px 18px; gap: 12px; }
      .kpi-card {
        background: #ffffff;
        border: 1px solid #e3e8f5;
        border-radius: 12px;
        box-shadow: 0 12px 30px rgba(15,23,42,0.08);
      }
      .kpi-header { color: #475569; }
      .kpi-value { color: #0f172a; font-size: 20px; }
      .kpi-comment-kpi { color: #64748b; }
      .layout { padding: 0 18px 18px; gap: 16px; }
      .card {
        background: #ffffff;
        border: 1px solid #e5eaf5;
        border-radius: 14px;
        box-shadow: 0 16px 36px rgba(15,23,42,0.1);
        padding: 16px 16px 12px;
        color: #0f172a;
      }
      .card h2, .card h3 { color: #0f172a; margin-top: 0; font-weight: 800; }
      .card-comment { color: #475569; }
      .card-comment-data { color: #64748b; }
      table { color: #000000 !important; }
      table th, table td { border-color: #b3bac5 !important; color: #000000 !important; }
      .map-info {
        background: #f7f9fd;
        border: 1px dashed #d5def4;
        color: #0f172a;
      }
      .map-info-title { color: #0f172a; }
      .map-info-subtitle { color: #475569; }
      .map-info-text { color: #64748b; }
      .relatorio-stack { display:flex; flex-direction:column; gap:14px; padding:0 16px 18px; }
      .relatorio-preview-card { margin-top:6px; }
      .relatorio-actions { display:flex; gap:10px; align-items:center; margin-top:10px; }
      .relatorio-btn-row { display:flex; justify-content:flex-start; }
      .relatorio-btn { width:auto !important; padding:8px 16px; }
    ")),
    
    # HEADER ---------------------------------------------------------
    div(
      class = "header",
      div(
        class = "logo-container",
        img(
          src = "Logo Grupo Rigarr.png",
          class = "logo-image",
          style = "height:40px; margin-right:10px;"
        )
      ),
      div(
        class = "title-block",
        div(
          class = "subtitle-rigarr",
          "Dashboard de Futebol (layout base em construção). Selecione um time nas abas abaixo para acessar o painel específico."
        )
      ),
      div(
        class = "user-area",
        textOutput(ns("user_email")),
        actionButton(ns("logout"), "Sair", class = "btn btn-light")
      )
    ),
    
    # WRAPPER COM SCROLL HORIZONTAL + TABSET ------------------------
    div(
      class = "tabs-scroll-container",
      
      tabsetPanel(
        id   = ns("tabs"),
        type = "tabs",
        
        tabPanel(
          title = tagList(
            img(src = "Atlético_Mineiro.png", class = "team-tab-logo"),
            "Atlético-MG"
          ),
          mod_clube_ui(ns("clube_atletico_mg"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Bahia.png", class = "team-tab-logo"),
            "Bahia"
          ),
          mod_clube_ui(ns("clube_bahia"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Botafogo.png", class = "team-tab-logo"),
            "Botafogo"
          ),
          mod_clube_ui(ns("clube_botafogo"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Ceará.png", class = "team-tab-logo"),
            "Ceará"
          ),
          mod_clube_ui(ns("clube_ceara"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Corinthians.png", class = "team-tab-logo"),
            "Corinthians"
          ),
          mod_clube_ui(ns("clube_corinthians"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Cruzeiro.png", class = "team-tab-logo"),
            "Cruzeiro"
          ),
          mod_clube_ui(ns("clube_cruzeiro"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Flamengo.png", class = "team-tab-logo"),
            "Flamengo"
          ),
          mod_clube_ui(ns("clube_flamengo"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Fluminense.png", class = "team-tab-logo"),
            "Fluminense"
          ),
          mod_clube_ui(ns("clube_fluminense"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Fortaleza.png", class = "team-tab-logo"),
            "Fortaleza"
          ),
          mod_clube_ui(ns("clube_fortaleza"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Grêmio.png", class = "team-tab-logo"),
            "Grêmio"
          ),
          mod_clube_ui(ns("clube_gremio"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Internacional.png", class = "team-tab-logo"),
            "Internacional"
          ),
          mod_clube_ui(ns("clube_internacional"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Juventude.png", class = "team-tab-logo"),
            "Juventude"
          ),
          mod_clube_ui(ns("clube_juventude"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Mirassol-SP.png", class = "team-tab-logo"),
            "Mirassol-SP"
          ),
          mod_clube_ui(ns("clube_mirassol"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Palmeiras.png", class = "team-tab-logo"),
            "Palmeiras"
          ),
          mod_clube_ui(ns("clube_palmeiras"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Red Bull Bragantino.png", class = "team-tab-logo"),
            "Red Bull Bragantino"
          ),
          mod_clube_ui(ns("clube_bragantino"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Santos.png", class = "team-tab-logo"),
            "Santos"
          ),
          mod_clube_ui(ns("clube_santos"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "São Paulo.png", class = "team-tab-logo"),
            "São Paulo"
          ),
          mod_clube_ui(ns("clube_sao_paulo"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Sport_Recife.png", class = "team-tab-logo"),
            "Sport Recife"
          ),
          mod_clube_ui(ns("clube_sport"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Vasco_da_Gama.png", class = "team-tab-logo"),
            "Vasco da Gama"
          ),
          mod_clube_ui(ns("clube_vasco"))
        ),
        
        tabPanel(
          title = tagList(
            img(src = "Vitória.png", class = "team-tab-logo"),
            "Vitória"
          ),
          mod_clube_ui(ns("clube_vitoria"))
        ),
        
        tabPanel(
          title = tagList(icon("file-text"), "Relatório Custom"),
          div(
            class = "relatorio-stack",
            div(
              class = "card",
              h3("Monte seu relatório"),
              p(
                class = "card-comment",
                "Selecione variáveis do banco e gere um HTML com visual executivo focado em futebol."
              ),
              textInput(ns("titulo_rel"), "Título do relatório", value = "Relatório customizado"),
              textAreaInput(ns("obs_rel"), "Descrição/observações", rows = 3, placeholder = "Breve resumo do que este relatório cobre."),
              selectInput(
                ns("cols_rel"),
                "Variáveis do banco",
                choices = NULL,
                multiple = TRUE,
                width = "100%"
              ),
              div(
                class = "relatorio-btn-row",
                actionButton(ns("btn_relatorio"), "Gerar relatório", class = "btn btn-primary relatorio-btn")
              )
            ),
            div(
              class = "card relatorio-preview-card",
              h3("Pré-visualização"),
              uiOutput(ns("relatorio_preview"), class = "relatorio-preview"),
              div(
                class = "relatorio-actions",
                downloadButton(ns("download_relatorio"), "Baixar HTML", class = "btn btn-success"),
                uiOutput(ns("whatsapp_link"))
              )
            )
          )
        )
      )
    )
  )
}

# --------------------------------------------------------------------
# SERVER
# --------------------------------------------------------------------

mod_dashboard_server <- function(input, output, session, user_rv) {
  ns <- session$ns
  
  # Base principal (mantemos a base CSV para estabilidade dos módulos de clube)
  dados <- reactive({
    readr::read_csv("data/base_rh.csv", show_col_types = FALSE)
  })
  
  # Base demo específica para relatório (métricas de futebol com nomes coerentes)
  dados_relatorio <- reactive({
    data.frame(
      clube          = c("Flamengo", "Palmeiras", "Atlético-MG", "São Paulo", "Grêmio", "Botafogo", "Bahia", "Fortaleza", "Vasco", "Corinthians"),
      adversario     = c("Botafogo", "Corinthians", "Bahia", "Vasco", "Inter", "Fluminense", "Ceará", "Cuiabá", "Santos", "Athletico-PR"),
      xg             = c(2.1, 1.4, 1.9, 1.3, 1.1, 1.8, 1.2, 1.5, 1.0, 1.6),
      finalizacoes   = c(15, 11, 14, 10, 9, 13, 9, 12, 8, 12),
      posse_pct      = c(58, 54, 55, 52, 49, 56, 50, 51, 47, 53),
      ppda           = c(8.2, 9.1, 7.8, 9.5, 10.2, 8.4, 9.8, 9.3, 10.5, 8.9),
      gols           = c(2, 1, 3, 1, 0, 2, 1, 1, 0, 2),
      assistencias   = c(2, 1, 2, 1, 0, 2, 1, 1, 0, 1),
      cartoes        = c(3, 2, 4, 2, 1, 3, 2, 2, 3, 2),
      desarmes       = c(17, 15, 16, 14, 13, 16, 14, 15, 12, 15),
      passes_certos  = c(510, 468, 489, 455, 422, 478, 436, 441, 398, 447),
      data_jogo      = as.Date(c(
        "2024-06-15", "2024-06-16", "2024-06-17", "2024-06-18", "2024-06-19",
        "2024-06-20", "2024-06-21", "2024-06-22", "2024-06-23", "2024-06-24"
      )),
      stringsAsFactors = FALSE,
      check.names      = FALSE
    )
  })
  
  # Saudação do usuário ---------------------------------------------
  output$user_email <- renderText(paste("Olá,", user_rv$email))
  
  # Liga cada aba ao módulo de clube -------------------------------
  mod_clube_server("clube_atletico_mg", dados, "Atlético-MG")
  mod_clube_server("clube_bahia",       dados, "Bahia")
  mod_clube_server("clube_botafogo",    dados, "Botafogo")
  mod_clube_server("clube_ceara",       dados, "Ceará")
  mod_clube_server("clube_corinthians", dados, "Corinthians")
  mod_clube_server("clube_cruzeiro",    dados, "Cruzeiro")
  mod_clube_server("clube_flamengo",    dados, "Flamengo")
  mod_clube_server("clube_fluminense",  dados, "Fluminense")
  mod_clube_server("clube_fortaleza",   dados, "Fortaleza")
  mod_clube_server("clube_gremio",      dados, "Grêmio")
  mod_clube_server("clube_internacional", dados, "Internacional")
  mod_clube_server("clube_juventude",   dados, "Juventude")
  mod_clube_server("clube_mirassol",    dados, "Mirassol-SP")
  mod_clube_server("clube_palmeiras",   dados, "Palmeiras")
  mod_clube_server("clube_bragantino",  dados, "Red Bull Bragantino")
  mod_clube_server("clube_santos",      dados, "Santos")
  mod_clube_server("clube_sao_paulo",   dados, "São Paulo")
  mod_clube_server("clube_sport",       dados, "Sport Recife")
  mod_clube_server("clube_vasco",       dados, "Vasco da Gama")
  mod_clube_server("clube_vitoria",     dados, "Vitória")
  
  # Logout ----------------------------------------------------------
  observeEvent(input$logout, {
    user_rv$logged_in <- FALSE
    user_rv$email     <- NULL
  })
  
  # ---------------------------------------------------------------
  # Relatório custom (RMarkdown)
  # ---------------------------------------------------------------
  relatorio_path <- reactiveVal(NULL)
  
  observe({
    df <- dados_relatorio()
    req(df)
    col_names <- names(df)
    label_map <- c(
      clube         = "Clube",
      adversario    = "Adversário",
      xg            = "xG",
      finalizacoes  = "Finalizações",
      posse_pct     = "Posse (%)",
      ppda          = "PPDA",
      gols          = "Gols",
      assistencias  = "Assistências",
      cartoes       = "Cartões",
      desarmes      = "Desarmes",
      passes_certos = "Passes certos",
      data_jogo     = "Data"
    )
    labels <- label_map[col_names]
    labels[is.na(labels)] <- col_names[is.na(labels)]
    named_choices <- stats::setNames(col_names, labels)
    updateSelectInput(session, "cols_rel", choices = named_choices, selected = head(col_names, 5))
  })
  
  observeEvent(input$btn_relatorio, {
    df <- req(dados_relatorio())
    cols <- input$cols_rel
    if (is.null(cols) || length(cols) == 0) cols <- names(df)
    
    tmp_dir  <- tempdir()
    rmd_file <- file.path(tmp_dir, "relatorio_custom.Rmd")
    out_file <- file.path(tmp_dir, "relatorio_custom.html")
    meta_file <- file.path(tmp_dir, "meta_relatorio.rds")
    data_file <- file.path(tmp_dir, "dados_relatorio.rds")
    
    meta <- list(
      titulo = if (nzchar(input$titulo_rel)) input$titulo_rel else "Relatório customizado",
      resumo = if (is.null(input$obs_rel)) "" else input$obs_rel,
      cols   = cols,
      generated = Sys.time()
    )
    saveRDS(meta, meta_file)
    saveRDS(df, data_file)
    
    rmd_content <- c(
      "---",
      sprintf("title: \"%s\"", meta$titulo),
      "output:",
      "  html_document:",
      "    toc: false",
      "    theme: readable",
      "---",
      "",
      "<style>",
      "body {font-family: 'Segoe UI','Inter',system-ui,sans-serif; background: #f7f9fc; color:#000000; padding:0 6px 20px;}",
      "body, p, li {color:#000000;}",
      "h1, h2, h3, h4, h5, h6 {color:#000000;}",
      ".hero {background: linear-gradient(135deg,#1d4ed8,#0ea5e9); color:#fff; padding:18px 18px 14px; border-radius:16px; box-shadow:0 12px 30px rgba(0,0,0,.18); margin-bottom:14px;}",
      ".hero h1 {margin:0 0 4px;font-size:24px; font-weight:800;}",
      ".hero p {margin:0; opacity:.95;}",
      ".pill {display:inline-flex;align-items:center;gap:6px;background:rgba(255,255,255,.14);color:#fff;padding:6px 10px;border-radius:999px;font-weight:700;font-size:12px;}",
      ".section {background:#fff;border:1px solid #e5e7eb;border-radius:14px;padding:14px 16px;margin-bottom:12px;box-shadow:0 8px 20px rgba(15,23,42,.08);}",
      ".section h2 {margin:0 0 8px;font-size:18px;font-weight:800;color:#000000;}",
      ".section p {margin:0 0 8px;color:#000000;}",
      ".kpi-row {display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:10px;margin:10px 0 6px;}",
      ".kpi {background:#f8fafc;border:1px solid #e5e7eb;border-radius:12px;padding:10px 12px;}",
      ".kpi .label {font-size:12px;color:#111827;text-transform:uppercase;font-weight:700;letter-spacing:.4px;}",
      ".kpi .value {font-size:20px;font-weight:800;color:#000000;}",
      ".insight-grid {display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:10px;margin:10px 0 6px;}",
      ".insight-card {background:#f8fafc;border:1px solid #e5e7eb;border-radius:12px;padding:12px;box-shadow:0 6px 14px rgba(15,23,42,.08);}",
      ".insight-card .label {font-size:12px;color:#0f172a;font-weight:800;text-transform:uppercase;letter-spacing:.3px;}",
      ".insight-card p {margin:6px 0 0;color:#000000;font-size:13px;}",
      "table {width:100%;border-collapse:collapse;margin-top:4px;color:#000000;}",
      "th, td {border:1px solid #a9afba;padding:8px 10px;color:#000000;}",
      "th {background:#d5dbe5;color:#000000;text-transform:uppercase;font-size:12px;font-weight:800;}",
      "td {color:#000000;font-size:12px;}",
      ".muted {color:#111827; font-size:12px;}",
      "</style>",
      "",
      "```{r setup, echo=FALSE}",
      "meta <- readRDS('meta_relatorio.rds')",
      "dados <- readRDS('dados_relatorio.rds')",
      "sel <- meta$cols",
      "if (length(sel) == 0) sel <- names(dados)",
      "df_sel <- dados[, sel, drop = FALSE]",
      "label_map <- c(",
      "  clube = 'Clube',",
      "  adversario = 'Adversário',",
      "  xg = 'xG',",
      "  finalizacoes = 'Finalizações',",
      "  posse_pct = 'Posse (%)',",
      "  ppda = 'PPDA',",
      "  gols = 'Gols',",
      "  assistencias = 'Assistências',",
      "  cartoes = 'Cartões',",
      "  desarmes = 'Desarmes',",
      "  passes_certos = 'Passes certos',",
      "  data_jogo = 'Data'",
      ")",
      "colnames(df_sel) <- ifelse(is.na(label_map[sel]), sel, label_map[sel])",
      "```",
      "",
      "```{r echo=FALSE, results='asis'}",
      "if (length(sel) == 0) sel <- names(dados)",
      "kpi_html <- sprintf(\"<div class='kpi-row'>",
      "  <div class='kpi'><div class='label'>Linhas na base</div><div class='value'>%s</div></div>",
      "  <div class='kpi'><div class='label'>Variáveis selecionadas</div><div class='value'>%s</div></div>",
      "  <div class='kpi'><div class='label'>Geração</div><div class='value'>%s</div></div>",
      "</div>\",",
      "  nrow(dados), length(sel), format(Sys.time(), '%d/%m %H:%M'))",
      "cat(sprintf(\"<div class='hero'><div class='pill'>Relatório executivo • Futebol</div><h1>%s</h1><p>%s</p></div>\",",
      "  meta$titulo, if (!is.null(meta$resumo) && nzchar(meta$resumo)) meta$resumo else \"Snapshot customizado com variáveis selecionadas do painel.\"))",
      "cat(\"<div class='section'><h2>Resumo rápido</h2>\")",
      "cat(kpi_html)",
      "cat(\"<p class='muted'>Este relatório é renderizado com as colunas escolhidas e pode ser baixado ou compartilhado.</p></div>\")",
      "cat(\"<div class='section'><h2>Tabela (variáveis selecionadas)</h2><p class='muted'>Amostra das primeiras 20 linhas das colunas escolhidas.</p>\")",
      "```",
      "",
      "```{r echo=FALSE}",
      "knitr::kable(head(df_sel, 20), format = 'html', table.attr = 'class=\"table\"')",
      "```",
      "",
      "```{r echo=FALSE, results='asis'}",
      "cat(\"</div>\")",
      "cat(\"<div class='section'><h2>Insights táticos</h2><div class='insight-grid'>\")",
      "cat(\"<div class='insight-card'><div class='label'>Pressão alta</div><p>Linha de pressão sobe após perda aos 6 segundos, forçando lançamentos longos do adversário.</p></div>\")",
      "cat(\"<div class='insight-card'><div class='label'>Amplitude</div><p>Pontas abrem o campo e criam 1v1 na ala, favorecendo cruzamentos rasteiros para o 9.</p></div>\")",
      "cat(\"<div class='insight-card'><div class='label'>Transição</div><p>Roubos em meio-campo geram finalização em até 12 segundos em 42% das jogadas.</p></div>\")",
      "cat(\"</div><p class='muted'>Sugestões de ajuste tático com base em padrões recentes de xG, pressão e ocupação de corredores.</p></div>\")",
      "```",
      "",
      "<div class='section'>",
      "  <h2>Exemplo de scouting (dados fictícios)</h2>",
      "  <p class='muted'>Exemplo ilustrativo de métricas de jogo para contexto: clube, adversário, xG, finalizações, posse e pressão.</p>",
      "",
      "```{r echo=FALSE}",
      "scout <- data.frame(",
      "  Clube = c('Flamengo','Palmeiras','Atlético-MG','São Paulo','Grêmio'),",
      "  Adversário = c('Botafogo','Corinthians','Bahia','Vasco','Inter'),",
      "  xG = c(2.1,1.4,1.9,1.3,1.1),",
      "  Finalizações = c(15,11,14,10,9),",
      "  `Posse (%)` = c('58%','54%','55%','52%','49%'),",
      "  PPDA = c(8.2,9.1,7.8,9.5,10.2),",
      "  Resultado = c('2-0','1-0','3-1','1-1','0-0')",
      ")",
      "knitr::kable(scout, format = 'html', table.attr = 'class=\"table\"')",
      "```",
      "",
      "</div>",
      "",
      "<p class='muted'>Relatório gerado em `r format(Sys.time(), '%d/%m/%Y %H:%M:%S')`. Compartilhe o HTML para leitura offline ou integração em apresentações.</p>",
      ""
    )
    
    writeLines(rmd_content, rmd_file, useBytes = TRUE)
    
    rmarkdown::render(
      input = rmd_file,
      output_file = out_file,
      params = list(
        titulo = if (nzchar(input$titulo_rel)) input$titulo_rel else "Relatório customizado",
        resumo = if (is.null(input$obs_rel)) "" else input$obs_rel,
        cols   = cols,
        dados  = df
      ),
      quiet = TRUE,
      envir = new.env(parent = globalenv())
    )
    
    relatorio_path(out_file)
  })
  
  output$relatorio_preview <- renderUI({
    path <- relatorio_path()
    if (is.null(path) || !file.exists(path)) {
      return(div(class = "card-comment", "Gere um relatório para visualizar aqui."))
    }
    html_content <- paste(readLines(path, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
    div(
      class = "relatorio-embed",
      htmltools::HTML(html_content)
    )
  })
  
  output$download_relatorio <- downloadHandler(
    filename = function() paste0("relatorio_custom_", Sys.Date(), ".html"),
    content = function(file) {
      path <- relatorio_path()
      req(path, file.exists(path))
      file.copy(path, file, overwrite = TRUE)
    }
  )
  
  output$whatsapp_link <- renderUI({
    txt <- URLencode("Relatório gerado no dashboard. Baixe o HTML e compartilhe no WhatsApp.")
    tags$a(
      href = paste0("https://wa.me/?text=", txt),
      target = "_blank",
      class = "btn btn-secondary",
      icon("whatsapp"), " WhatsApp"
    )
  })
}
