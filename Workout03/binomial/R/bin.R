
#' @title binominal variable
#' @description gives data frame with the corresponding probability distribution with cumulative stats
#' @param trials how many trials
#' @param prob probability of a success in any given trial
#' @return object of class "binvar", list with named elements trials and prob
#' @export
#' @examples
#' bin_variable(5, 0.5)
bin_variable <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  object <- list(trials = trials, prob = prob)
  attr(object, "trials") <- trials
  attr(object, "prob") <- prob
  class(object) <- "binvar"
  object
}

#' @export
print.binvar <- function(binvar1) {
  trials = attr(binvar1, "trials")
  prob = attr(binvar1, "prob")
  cat('Binomial variable\n\n')
  cat('Paramters\n')
  cat('- number of trials: ', trials)
  cat('\n')
  cat('- prob of success: ', prob)
}

#' @export
summary.binvar <- function(binvar1) {
  trials = attr(binvar1, "trials")
  prob = attr(binvar1, "prob")
  object <- list(trials = trials,
                 prob = prob,
                 mean = aux_mean(trials, prob),
                 variance = aux_variance(trials, prob),
                 mode = aux_mode(trials, prob),
                 skewness = aux_skewness(trials, prob),
                 kurtosis = aux_kurtosis(trials, prob))
  attr(object, "trials") <- trials
  attr(object, "prob") <- prob
  attr(object, "mean") <- aux_mean(trials, prob)
  attr(object, "variance") <- aux_variance(trials, prob)
  attr(object, "mode") <- aux_mode(trials, prob)
  attr(object, "skewness") <- aux_skewness(trials, prob)
  attr(object, "kurtosis") <- aux_kurtosis(trials, prob)
  class(object) <- "summary.binvar"
  object
}

#' @export
print.summary.binvar <- function(binvar1) {
  trials = attr(binvar1, "trials")
  prob = attr(binvar1, "prob")
  print.binvar(binvar1)
  cat('\n\n')
  cat('Measures\n\n')
  cat('- mean: ')
  cat(aux_mean(trials, prob))
  cat('\n- variance: ')
  cat(aux_variance(trials, prob))
  cat('\n- mode: ')
  cat(aux_mode(trials, prob))
  cat('\n- skewness: ')
  cat(aux_skewness(trials, prob))
  cat('\n- kurtosis: ')
  cat(aux_kurtosis(trials, prob))
}

#' @title binominal cumulative
#' @description gives data frame with the corresponding probability distribution with cumulative stats
#' @param trials how many trials
#' @param prob probability of a success in any given trial
#' @return data frame with the probability distribution: sucesses in the first column, probability in the second, and cumulative in the third
#'
#' @export
#' @examples
#' bin_cumulative(5, 0.5)
bin_cumulative <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  success <- seq(0, trials, 1)
  prob <- bin_probability(success, trials, prob)
  cumulative <- cumsum(prob)
  df <- data.frame("success" = success, "prob" = prob, "cumulative" = cumulative)
  attr(df, "l") = trials
  attr(df, "data") = data.frame("success" = success, "prob" = prob, "cumulative" = cumulative)
  class(df) <- "bincum"
  df
}

#' @export
plot.bincum <- function(dis) {
  df = attr(dis, "data")
  a = attr(dis, "l")
  print(df)
  plot(df$success, df$cumulative, type="b", xlab = "Number of successes", ylab = "Cumulative probability", xlim = c(0, a), ylim = c(0,1))
}

#' @title binominal distribution
#' @description gives data frame with the corresponding probability distribution
#' @param trials how many trials
#' @param prob probability of a success in any given trial
#' @return data frame with the probability distribution: sucesses in the first column, probability in the second
#'
#' @export
#' @examples
#' bin_distribution(5, 0.5)
bin_distribution <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  success <- seq(0, trials, 1)
  prob <- bin_probability(success, trials, prob)
  df <- data.frame("success" = success, "probability" = prob)
  attr(df, "data") <- data.frame("success" = success, "probability" = prob)
  class(df) <- "bindis"
  df
}

#' @export
plot.bindis <- function(dis) {
  df = attr(dis, "data")
  barplot(df$probability, names = df$success, xlab = "Number of successes", ylab = "Probability")
}

#' @title binominal probability
#' @description returns the probability of some amount of success associated with a specific binomial model
#' @param success how many successes
#' @param trials how many trials
#' @param prob probability of a success in any given trial
#' @return probability of getting success number of successes in trials number of trials with probability prob
#'
#' @export
#' @examples
#' bin_probability(2, 5, 0.5)
#' bin_probability(0:3, 3, 0.3)
bin_probability <- function(success, trials, prob) {
  check_success(success, trials)
  check_prob(prob)
  check_trials(trials)
  c = factorial(trials) / (factorial(success)*factorial(trials - success))
  return(c*(prob^success)*((1-prob)^(trials-success)))
}


#' @title binominal choose
#' @description choose function
#' @param n how many trials
#' @param k how many success
#' @return n choose k
#' @export
#' @examples
#' bin_choose(10,6)
bin_choose <- function(n, k) {
  check_success(k, n)
  check_trials(n)
  if (k > n) {
    stop("invalid number of successes")
  }
  c = factorial(n) / (factorial(k)*factorial(n - k))
  return(c)
}


# private function to check if it is a valid probability
check_prob <- function(prob) {
  ifelse((0 <= prob & prob <= 1), TRUE,stop("invalid prob value"))
}

# private function to check if the number of trials is valid
check_trials <- function(trials) {
  if (trials >= 0 & trials == round(trials)) {
    return(TRUE)
  }
  stop("invalid trials value")
}

# private function to check if an input success is a valid value for number of trials
check_success <- function(success, trials) {
  check_trials(trials)
  ifelse((success > trials | success < 0 | success != round(success) | trials != round(trials)), stop("invalid number of successes"), TRUE)
}

# private function to compute mean of binomial distribution with trials, prob parameters
aux_mean <- function(trials, prob) {
  return(trials*prob)
}

# private function to compute variance of binomial distribution with trials, prob parameters
aux_variance <- function(trials, prob) {
   return(trials*prob*(1-prob))
}

# private function to compute mode of binomial distribution with trials, prob parameters
aux_mode <- function(trials, prob) {
  a = as.integer(trials*prob + prob)
  if (trials == 0) {
    return(0)
  }
  return(a)
}

# private function to compute skewness of binomial distribution with trials, prob parameters
aux_skewness <- function(trials, prob) {
  num = 1 - 2*prob
  denom = (trials*prob*(1-prob))^0.5
  return(num/denom)
}

# private function to compute kurtosis of binomial distribution with trials, prob parameters
aux_kurtosis <- function(trials, prob) {
  num = 1 - 6*prob*(1-prob)
  denom = trials*prob*(1-prob)
  return(num/denom)
}

#' @title binominal mean
#' @description gives mean of the binomial
#' @param prob probability of success on any given trial
#' @param trials how many trials
#' @return mean of the specified binomal distribution
#'
#' @export
#' @examples
#' bin_mean(6, 0.3)
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}

#' @title binominal variance
#' @description gives variance of the binomial
#' @param prob probability of success on any given trial
#' @param trials how many trials
#' @return variance of the specified binomal distribution
#'
#' @export
#' @examples
#' bin_variance(6, 0.3)
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}

#' @title binominal mode
#' @description gives mode of the binomial
#' @param prob probability of success on any given trial
#' @param trials how many trials
#' @return mode of the specified binomal distribution
#'
#' @export
#' @examples
#' bin_mode(6, 0.3)
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}

#' @title binominal skewness
#' @description gives skewness of the binomial
#' @param prob probability of success on any given trial
#' @param trials how many trials
#' @return skewness of the specified binomal distribution
#'
#' @export
#' @examples
#' bin_skewness(6, 0.3)
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}

#' @title binominal kurtosis
#' @description gives kurtosis of the binomial
#' @param prob probability of success on any given trial
#' @param trials how many trials
#' @return kurtosis of the specified binomal distribution
#'
#' @export
#' @examples
#' bin_kurtosis(6, 0.3)
bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}
