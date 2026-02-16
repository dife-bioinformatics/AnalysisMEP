# Brief description of what the goal of the script is

# load libraries
# library(tidyverse)

# read all custom functions in R/utils
# purrr::walk(fs::dir_ls(here::here("R/utils")), ~source(.))

# Read data
# df_0 <- haven::read_sas("/home/USER/HSZ_MEP_datahub/PXXXX/data.sas")

# Analyze
# df_1 <- cars |>
#   tibble::as_tibble() |>
#   tidyr::pivot_longer(tidyselect::everything(),
#                       values_to = "value",
#                       names_to = "variable_name") |>
#   dplyr::summarise(mean = mean(value),
#                    median = median(value),
#                    sd = sd(value),
#                    .by = variable_name)
#
# df_1
#
# write to disk
# df_1 |>
#   write_rds(here::here("data/descriptive_summary.rds"))

