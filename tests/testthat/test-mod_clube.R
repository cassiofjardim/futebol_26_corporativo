testthat::test_that("mod_clube_server calcula KPI de jogos via nrow", {
  testthat::skip_if_not_installed("shiny")
  testthat::skip_if_not_installed("highcharter")

  source(file.path("R", "mod_clube.R"), local = TRUE)

  df <- data.frame(a = 1:10)
  dados_reactive <- shiny::reactive(df)

  shiny::testServer(
    mod_clube_server,
    args = list(dados_reactive = dados_reactive, nome_time = "Palmeiras"),
    {
      session$flushReact()

      testthat::expect_equal(output$titulo_time, "Palmeiras")
      testthat::expect_equal(output$kpi_jogos, "10")
    }
  )
})

