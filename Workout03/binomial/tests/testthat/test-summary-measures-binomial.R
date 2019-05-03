context("Test summary measures for binomial")

test_that("aux_mean", {
  expect_that(aux_mean(10, 0.3), equals(3))
  expect_that(aux_mean(0, 0.1), equals(0))
  expect_that(aux_mean(3, 0.5), equals(1.5))
})

test_that("aux_variance", {
  expect_that(aux_variance(10, 0.3), equals(2.1))
  expect_that(aux_variance(5, 0.2), equals(0.8))
  expect_that(aux_variance(7, 0.5), equals(1.75))
})

test_that("aux_mode", {
  expect_that(aux_mode(10, 0.3), equals(3))
  expect_that(aux_mode(12, 0.4), equals(5))
  expect_that(aux_mode(0, 1), equals(0))
})

test_that("aux_kurtosis", {

  expect_equal(aux_kurtosis(10, 0.3), -0.1238095, tolerance = 0.001)
  expect_equal(aux_kurtosis(12, 0.4), -0.153, tolerance = 0.001)
  expect_equal(aux_kurtosis(1, 0.9), 5.111, tolerance = 0.001)
})

test_that("aux_skewness", {
  expect_equal(aux_skewness(10, 0.3), 0.276, tolerance = 0.001)
  expect_equal(aux_skewness(12, 0.4), 0.1178511, tolerance = 0.001)
  expect_equal(aux_skewness(1, 0.9), -2.667, tolerance = 0.001)
})
