testthat::test_that("sb_auth_demo autentica credenciais demo", {
  testthat::skip_if_not_installed("shiny")

  source(file.path("R", "helpers_supabase.R"), local = TRUE)

  ok <- sb_auth_demo("demo@demo.com", "654321")
  testthat::expect_true(ok$success)
  testthat::expect_equal(ok$user_email, "demo@demo.com")
})

testthat::test_that("sb_auth_demo rejeita credenciais inválidas e normaliza email", {
  testthat::skip_if_not_installed("shiny")

  source(file.path("R", "helpers_supabase.R"), local = TRUE)

  bad <- sb_auth_demo("x@x.com", "654321")
  testthat::expect_false(bad$success)
  testthat::expect_true(is.na(bad$user_email))

  ok2 <- sb_auth_demo("  DEMO@DEMO.COM  ", "654321")
  testthat::expect_true(ok2$success)
})

testthat::test_that("sb_auth_demo falha para tipos não-character", {
  testthat::skip_if_not_installed("shiny")

  source(file.path("R", "helpers_supabase.R"), local = TRUE)

  bad <- sb_auth_demo(123, 456)
  testthat::expect_false(bad$success)
})

