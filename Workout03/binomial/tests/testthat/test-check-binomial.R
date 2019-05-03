context("Check binomial arguments")

test_that("check_prob with valid inputs", {
  expect_true(check_prob(0.5))
  expect_true(check_prob(1))
  expect_true(check_prob(0))
})

test_that("check_prob fails with invalid inputs", {
  expect_true(check_prob(c(0.4, 0.3))[1])
  expect_error(check_prob(4))
  expect_error(check_prob(-0.3))
})

test_that("check_trials with valid inputs", {
  expect_true(check_trials(7))
  expect_true(check_trials(0))
})

test_that("check_trials fails with invalid inputs", {
  expect_error(check_trials(10.3))
  expect_error(check_trials(-4))
  expect_error(check_trials(0.3))
})

test_that("check_success with valid inputs", {
  expect_true(check_success(7, 10))
  expect_true(check_success(0, 2))
})

test_that("check_trials fails with invalid inputs", {
  expect_error(check_success(-3, 4))
  expect_error(check_success(4, 3))
  expect_error(check_success(0.5, 0.7))
})
