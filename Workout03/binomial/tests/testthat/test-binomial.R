context("Test for binomial")

test_that("bin_choose",{
    expect_true(bin_choose(5, 2) == 10)
    expect_true(bin_choose(6,6) == 1)
    expect_true (bin_choose(7,6) == 7)
})

test_that("bin_probability",{
  expect_true (bin_probability(2, 5, 0.5) == 0.3125)
  expect_true(all.equal(bin_probability(0:2, 5, 0.5),c(0.03125, 0.15625, 0.3125)))
  expect_true(all.equal(bin_probability(0:5, 5, 0.2),c(0.32768, 0.4096, 0.2048, 0.0512, 0.0064, 0.00032)))
})

test_that("bin_distribution", {
  expect_true(all.equal(attr(bin_distribution(5, 0.5), "data"), data.frame("success" = c(0, 1, 2, 3,4, 5), "probability" = c(0.03125, 0.15625, 0.3125, 0.3125, 0.15625, 0.03125))))
  expect_true(all.equal(attr(bin_distribution(1, 0.2), "data"), data.frame("success" = c(0, 1), "probability" = c(0.8, 0.2))))
  expect_true(all.equal(attr(bin_distribution(8, 0.7), "data"), data.frame("success" = seq(0, 8, 1), "probability" = c(0.00006561,
                                                                                                  0.00122472,
                                                                                                  0.01000188,
                                                                                                  0.04667544,
                                                                                                  0.13613670,
                                                                                                  0.25412184,
                                                                                                  0.29647548,
                                                                                                  0.19765032,
                                                                                                  0.05764801))))
})

test_that("bin_cumulative", {
  expect_true(all.equal(attr(bin_cumulative(5, 0.5), "data"), data.frame("success" = c(0, 1, 2, 3,4, 5), "prob" = c(0.03125, 0.15625, 0.3125, 0.3125, 0.15625, 0.03125),
                                                                     "cumulative" = c(0.03125,0.18750,0.50000,0.81250,0.96875,1.00000))))
  expect_true(all.equal(attr(bin_cumulative(1, 0.2), "data"), data.frame("success" = c(0, 1), "prob" = c(0.8, 0.2), "cumulative" = c(0.8, 1))))
  expect_true(all.equal(attr(bin_cumulative(8, 0.7), "data") , data.frame("success" = seq(0, 8, 1), "prob" = c(0.00006561,
                                                                                                0.00122472,
                                                                                                0.01000188,
                                                                                                0.04667544,
                                                                                                0.13613670,
                                                                                                0.25412184,
                                                                                                0.29647548,
                                                                                                0.19765032,
                                                                                                0.05764801),
                                                                              "cumulative" = c(0.00006561
                                                                                               ,0.00129033
                                                                                               ,0.01129221
                                                                                               ,0.05796765
                                                                                               ,0.19410435
                                                                                               ,0.44822619
                                                                                               ,0.74470167
                                                                                               ,0.94235199
                                                                                               ,1.00000000


                                                                              ))))
})
