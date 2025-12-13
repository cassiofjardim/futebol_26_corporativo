# mod_login.R ---------------------------------------------------------
# Nova tela de login estilo futebol:
# - Background: stadium_bg.png (na pasta www)
# - Card central com 2 colunas: player (esquerda) + formulário (direita)

mod_login_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    # CSS inline para garantir aplicação no login (mesmo que cache ignore styles.css)
    tags$style(
      HTML(
        "
        .login-frame{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:48px 32px;background:radial-gradient(circle at 15% 20%,rgba(59,130,246,.16),transparent 32%),radial-gradient(circle at 85% 18%,rgba(236,72,153,.2),transparent 30%),radial-gradient(circle at 18% 80%,rgba(16,185,129,.16),transparent 34%),linear-gradient(140deg,#02040b 0%,#060a17 45%,#02040b 100%);color:#e9efff;box-sizing:border-box;overflow:hidden;}
        .login-frame *,.login-frame *::before,.login-frame *::after{box-sizing:border-box;}
        .login-shell{position:relative;z-index:2;width:100%;max-width:1120px;min-height:620px;border-radius:26px;padding:32px 34px 26px;background:radial-gradient(circle at 18% 20%,rgba(56,189,248,.12),transparent 36%),radial-gradient(circle at 82% 80%,rgba(244,114,182,.14),transparent 38%),linear-gradient(145deg,rgba(9,12,26,.96),rgba(3,4,11,.96));border:1px solid rgba(255,255,255,.08);box-shadow:0 30px 90px rgba(0,0,0,.65),inset 0 1px 0 rgba(255,255,255,.04);backdrop-filter:blur(10px);}
        .login-glow{position:absolute;filter:blur(60px);opacity:.5;z-index:1;}
        .login-glow-1{width:320px;height:320px;background:#2dd4bf;top:-40px;left:10%;}
        .login-glow-2{width:280px;height:280px;background:#e11d48;bottom:-50px;right:8%;}
        .login-glow-3{width:240px;height:240px;background:#3b82f6;bottom:12%;left:-60px;}
        .login-top{display:flex;align-items:center;justify-content:space-between;gap:12px;font-size:12px;color:#c7d4ff;padding-bottom:10px;border-bottom:1px solid rgba(255,255,255,.08);}
        .login-pill{background:linear-gradient(90deg,rgba(37,99,235,.95),rgba(14,165,233,.9));padding:8px 16px;border-radius:999px;border:1px solid rgba(255,255,255,.2);font-weight:700;text-transform:uppercase;letter-spacing:.5px;}
        .login-top-meta{display:inline-flex;align-items:center;gap:8px;padding:8px 12px;border-radius:12px;background:rgba(255,255,255,.06);}
        .login-grid{display:grid;grid-template-columns:minmax(380px,1.05fr) minmax(360px,.95fr);gap:24px;margin-top:18px;align-items:stretch;width:100%;}
        .login-spotlight{position:relative;overflow:hidden;border-radius:18px;border:1px solid rgba(255,255,255,.1);padding:28px 26px;background:linear-gradient(180deg,rgba(5,8,17,.15),rgba(5,8,17,.9)),url('player.png');background-size:cover;background-position:center right;box-shadow:inset 0 1px 0 rgba(255,255,255,.04),0 16px 44px rgba(0,0,0,.5);}
        .login-spotlight::after{content:\"\";position:absolute;inset:0;background:radial-gradient(circle at 25% 30%,rgba(59,130,246,.32),transparent 45%),radial-gradient(circle at 75% 70%,rgba(236,72,153,.28),transparent 42%);}
        .login-spotlight>*{position:relative;z-index:1;}
        .login-spotlight-badge{display:inline-flex;align-items:center;gap:6px;padding:7px 12px;border-radius:999px;background:rgba(15,23,42,.6);border:1px solid rgba(255,255,255,.16);font-weight:600;color:#d8e5ff;}
        .login-spotlight h1{margin:14px 0 6px;font-size:32px;font-weight:800;color:#f4f7ff;letter-spacing:-.5px;text-shadow:0 10px 32px rgba(0,0,0,.6);}
        .login-spotlight-sub{margin:0 0 18px;color:#d1dcff;font-size:14px;max-width:520px;}
        .login-highlight-row{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:14px;margin-bottom:14px;}
        .login-highlight-card{background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.12);border-radius:14px;padding:16px;box-shadow:0 10px 24px rgba(0,0,0,.25);}
        .login-highlight-title{font-size:12px;text-transform:uppercase;color:#c4d1ff;letter-spacing:.6px;}
        .login-highlight-value{font-size:26px;font-weight:800;color:#fff;margin:4px 0;}
        .login-highlight-desc{margin:0;color:#c9d5ff;font-size:12px;}
        .login-timeline{display:flex;flex-wrap:wrap;gap:8px;}
        .login-timeline-item{display:inline-flex;align-items:center;gap:6px;padding:8px 10px;background:rgba(10,18,38,.6);border:1px solid rgba(255,255,255,.12);border-radius:999px;color:#d7e4ff;font-size:12px;}
        .login-card{background:#ffffff;color:#0f172a;border-radius:20px;padding:24px 22px;box-shadow:0 20px 60px rgba(0,0,0,.3);border:1px solid #e2e8f0;display:flex;flex-direction:column;gap:12px;}
        .login-card-header{display:flex;align-items:center;justify-content:space-between;gap:10px;padding-bottom:8px;border-bottom:1px solid #f1f5f9;}
        .login-logo-wrap{display:inline-flex;align-items:center;gap:8px;}
        .login-logo{height:42px;width:auto;}
        .login-logo-text{font-weight:800;font-size:15px;color:#0f172a;letter-spacing:.2px;}
        .login-tag{display:inline-flex;align-items:center;gap:6px;padding:6px 12px;border-radius:999px;background:#fef3c7;color:#92400e;font-weight:700;font-size:12px;border:1px solid #fcd34d;}
        .login-form .form-group{margin-bottom:12px;}
        .login-form label{font-size:11.5px;text-transform:uppercase;color:#6b7280;font-weight:700;letter-spacing:.4px;}
        .login-form .form-control,.login-form input[type=text],.login-form input[type=password]{border-radius:10px;border:1px solid #cbd5e1;height:44px;font-size:14px;color:#0f172a;box-shadow:none;background:#f8fafc;}
        .login-form .form-control:focus,.login-form input[type=text]:focus,.login-form input[type=password]:focus{border-color:#2563eb;box-shadow:0 0 0 2px rgba(37,99,235,.16);background:#fff;}
        .login-row-inline{display:flex;flex-wrap:wrap;gap:8px;margin-top:6px;}
        .login-ghost-pill{display:inline-flex;align-items:center;gap:6px;padding:7px 10px;border-radius:999px;background:#f1f5f9;color:#0f172a;font-size:12px;border:1px solid #e2e8f0;}
        .login-button-row{display:flex;justify-content:flex-end;margin-top:6px;}
        .login-button{background:linear-gradient(90deg,#16a34a,#22c55e);border:none;color:white;padding:12px 20px;border-radius:12px;font-weight:800;letter-spacing:.3px;display:inline-flex;align-items:center;gap:10px;box-shadow:0 14px 32px rgba(16,185,129,.35);}
        .login-button:hover{background:linear-gradient(90deg,#22c55e,#16a34a);color:white;}
        .login-button-chevron{font-weight:900;font-size:16px;opacity:.9;}
        .login-helper-row{display:flex;justify-content:space-between;align-items:flex-start;gap:10px;margin-top:6px;}
        .login-helper{display:inline-flex;align-items:center;gap:6px;color:#475569;font-size:12px;}
        .login-message{font-size:12px;color:#dc2626;min-height:18px;}
        .login-footer{margin-top:16px;display:flex;gap:12px;flex-wrap:wrap;color:#cdd9ff;font-size:12px;}
        .login-footer-item{display:inline-flex;align-items:center;gap:6px;padding:8px 10px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:10px;}
        @media(max-width:1024px){.login-grid{grid-template-columns:1fr;min-height:auto;} .login-shell{min-height:auto;} }
        @media(max-width:720px){.login-frame{padding:22px 14px;} .login-shell{padding:20px 16px;} .login-top{flex-direction:column;align-items:flex-start;} .login-helper-row{flex-direction:column;} .login-spotlight h1{font-size:26px;} }
        "
      )
    ),
    
    div(
      class = "login-frame",
      div(class = "login-glow login-glow-1"),
      div(class = "login-glow login-glow-2"),
      div(class = "login-glow login-glow-3"),
      
      div(
        class = "login-shell",
        
        # Barra superior com status
        div(
          class = "login-top",
          div(class = "login-pill", "Temporada 2024/25 • Live Data"),
          div(
            class = "login-top-meta",
            icon("wifi"),
            span("Link seguro | Dados sintéticos para demo")
          )
        ),
        
        # Conteúdo principal: vitrine + formulário
        div(
          class = "login-grid",
          
          # Painel esquerdo com narrativa
          div(
            class = "login-spotlight",
            div(class = "login-spotlight-badge", icon("fire"), "Arena Analytics"),
            h1("Novo vestiário de dados"),
            p(
              class = "login-spotlight-sub",
              "Monitoramento em tempo real do Brasileirão, scouting por posição e cartões interativos de performance."
            ),
            
            div(
              class = "login-highlight-row",
              div(
                class = "login-highlight-card",
                div(class = "login-highlight-title", "Clutch time"),
                div(class = "login-highlight-value", "82%"),
                p(class = "login-highlight-desc", "Jogos com virada no 2º tempo nos últimos 30 dias.")
              ),
              div(
                class = "login-highlight-card",
                div(class = "login-highlight-title", "Pace médio"),
                div(class = "login-highlight-value", "9.4 km/j"),
                p(class = "login-highlight-desc", "Volume médio percorrido por atleta titular em partidas recentes.")
              )
            ),
            
            div(
              class = "login-timeline",
              div(class = "login-timeline-item", icon("bolt"), span("Alertas automáticos de scout")),
              div(class = "login-timeline-item", icon("bar-chart"), span("KPIs já calibrados por posição")),
              div(class = "login-timeline-item", icon("film"), span("Clipes táticos sincronizados"))
            )
          ),
          
          # Cartão de autenticação
            div(
              class = "login-card",
              
              div(
                class = "login-card-header",
              div(
                class = "login-logo-wrap",
                img(
                  src   = "bola_futebol.png",
                  class = "login-logo",
                  alt   = "Futebol Analytics"
                ),
                span(class = "login-logo-text", "Futebol Pro Access")
              ),
              div(class = "login-tag", icon("shield"), "Ambiente Demo")
            ),
            
            div(
              class = "login-form",
              
              textInput(
                inputId     = ns("email"),
                label       = "E-mail de acesso",
                placeholder = "demo@demo.com"
              ),
              
              passwordInput(
                inputId     = ns("senha"),
                label       = "Senha",
                placeholder = "123456"
              ),
              
              div(
                class = "login-row-inline",
                div(class = "login-ghost-pill", icon("lock"), span("Conexão TLS ativa")),
                div(class = "login-ghost-pill", icon("user"), span("Conta restrita para testes"))
              ),
              
              div(
                class = "login-button-row",
                actionButton(
                  inputId = ns("btn_login"),
                  label   = HTML("<span>Entrar no painel</span><span class='login-button-chevron'>&rarr;</span>"),
                  class   = "btn login-button"
                )
              ),
              
              div(
                class = "login-helper-row",
                div(
                  class = "login-helper",
                  icon("info-circle"),
                  span("Use as credenciais demo acima para navegar pelos cards, mapas e clipes.")
                ),
                div(
                  class = "login-message",
                  textOutput(ns("msg"))
                )
              )
            )
          )
        ),
        
        # Rodapé
        div(
          class = "login-footer",
          div(
            class = "login-footer-item",
            icon("clock"),
            span("Atualização simulada a cada 15s")
          ),
          div(
            class = "login-footer-item",
            icon("shield"),
            span("Dados fictícios, ambiente seguro para apresentação")
          ),
          div(
            class = "login-footer-item",
            icon("television"),
            span("Design otimizado para telão e mobile")
          )
        )
      )
    )
  )
}

mod_login_server <- function(input, output, session, user_rv) {
  
  login_msg <- reactiveVal("")
  
  observeEvent(input$btn_login, {
    auth <- sb_auth_demo(input$email, input$senha)
    
    if (auth$success) {
      user_rv$logged_in <- TRUE
      user_rv$email     <- auth$user_email
      login_msg("")
    } else {
      login_msg("Credenciais inválidas.")
    }
  })
  
  output$msg <- renderText(login_msg())
}
