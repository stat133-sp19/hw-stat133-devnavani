% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bin.R
\name{bin_probability}
\alias{bin_probability}
\title{binominal probability}
\usage{
bin_probability(success, trials, prob)
}
\arguments{
\item{success}{how many successes}

\item{trials}{how many trials}

\item{prob}{probability of a success in any given trial}
}
\value{
probability of getting success number of successes in trials number of trials with probability prob
}
\description{
returns the probability of some amount of success associated with a specific binomial model
}
\examples{
bin_probability(2, 5, 0.5)
bin_probability(0:3, 3, 0.3)
}
