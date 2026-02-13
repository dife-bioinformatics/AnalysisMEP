# Brief description

# load libraries
library(tidyverse)
library(survival)
library(pak)


# read all custom functions in R/utils
# purrr::walk(fs::dir_ls(here::here("R/utils")), ~source(.))

# Read data
# df_0 <- haven::read_sas("/home/USER/HSZ_MEP_datahub/PXXXX/data.sas") |>
# .....
