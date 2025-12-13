testthat::test_that("mod_login_server faz login quando credenciais estão corretas", {
  testthat::skip_if_not_installed("shiny")

  source(file.path("R", "helpers_supabase.R"), local = TRUE)
  source(file.path("R", "mod_login.R"), local = TRUE)

  user_rv <- shiny::reactiveValues(logged_in = FALSE, email = NULL)

  shiny::testServer(
    mod_login_server,
    args = list(user_rv = user_rv),
    {
      session$setInputs(email = "demo@demo.com", senha = "654321", btn_login = 1)
      session$flushReact()

      testthat::expect_true(user_rv$logged_in)
      testthat::expect_equal(user_rv$email, "demo@demo.com")
      testthat::expect_equal(output$msg, "")
    }
  )
})

testthat::test_that("mod_login_server mostra mensagem quando credenciais são inválidas", {
  testthat::skip_if_not_installed("shiny")

  source(file.path("R", "helpers_supabase.R"), local = TRUE)
  source(file.path("R", "mod_login.R"), local = TRUE)

  user_rv <- shiny::reactiveValues(logged_in = FALSE, email = NULL)

  shiny::testServer(
    mod_login_server,
    args = list(user_rv = user_rv),
    {
      session$setInputs(email = "errado@x.com", senha = "000000", btn_login = 1)
      session$flushReact()

      testthat::expect_false(user_rv$logged_in)
      testthat::expect_equal(output$msg, "Credenciais inválidas.")
    }
  )
})

