# =====================================================
# Devtools workflow
#library(devtools)
# =====================================================

devtools::document()          # create documentation
devtools::check_man()         # check documentation
devtools::test()              # run tests
devtools::build_vignettes()   # knit vignettes
devtools::build()             # build bundle
devtools::install()           # install package
devtools::check()             # check
