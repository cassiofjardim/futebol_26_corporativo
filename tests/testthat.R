if (!requireNamespace("testthat", quietly = TRUE)) {
  stop("Pacote 'testthat' não instalado. Rode: install.packages('testthat')", call. = FALSE)
}

testthat::test_dir("tests/testthat")

