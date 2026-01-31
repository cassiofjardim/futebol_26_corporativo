# app.R — Projeto Futebol Brasileiro Dash -------------------------------

library(shiny)
library(tidyverse)
library(highcharter)
library(ggplot2)
library(reactable)
library(lubridate)
library(scales)
library(fontawesome)


source("R/mod_login.R")
source("R/mod_dashboard.R")
source("R/helpers_supabase.R")
source("R/helpers_theme.R")

ui <- fluidPage(
  tags$head(
    # ================== GOOGLE FONTS ==================
    tags$link(rel = "preconnect", href = "https://fonts.googleapis.com"),
    tags$link(
      rel        = "preconnect",
      href       = "https://fonts.gstatic.com",
      crossorigin = "anonymous"
    ),
    tags$link(
      rel  = "stylesheet",
      href = "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@400;500;600;700;800&display=swap"
    ),
    # ================== CSS DO PROJETO =================
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  
  # Mantém as duas views montadas e apenas alterna a exibição,
  # evitando re-render completo e reduzindo flicker na troca.
  conditionalPanel(
    condition = "!output.logged_in",
    mod_login_ui("login")
  ),
  conditionalPanel(
    condition = "output.logged_in",
    mod_dashboard_ui("dashboard")
  )
)

server <- function(input, output, session) {
  
  user_rv <- reactiveValues(
    logged_in = FALSE,
    email     = NULL
  )
  
  callModule(mod_login_server,     "login",     user_rv = user_rv)
  callModule(mod_dashboard_server, "dashboard", user_rv = user_rv)
  
  output$logged_in <- reactive(isTRUE(user_rv$logged_in))
  outputOptions(output, "logged_in", suspendWhenHidden = FALSE)
}

shinyApp(ui, server)
