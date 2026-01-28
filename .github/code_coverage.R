
library(badgen)
library(dplyr)

coverage_functions_detailed <- as.data.frame(covr::package_coverage())

coverage_functions <- coverage_functions_detailed |>
  rename(name = functions) |>
  mutate(relevant_lines = last_line - first_line + 1) |>
  mutate(value_adj = case_when(value == 9 ~ 0,
                               value == 1 ~ 1,
                               value == 0 ~ 0)) |>
  mutate(covered_lines = relevant_lines * value_adj) |>
  select(name,relevant_lines, covered_lines) |>
  group_by(name) |>
  summarise(across(everything(), ~ sum(., na.rm = TRUE))) |>
  mutate(cov_perc = round(covered_lines / relevant_lines *100,1))

coverage_package <- coverage_functions |>
  select(-cov_perc) |>
  summarise(across(where(is.numeric), sum)) |>
  mutate(cov_perc = round(covered_lines / relevant_lines *100,1)) |>
  mutate(name = "package") |>
  select(name,everything())

all_metrics <- rbind(coverage_package,
                     coverage_functions)

for(k in 1:length(all_metrics$name)){

  svg_test <- badgen(label = all_metrics$name[k],
                     status = paste0(as.character(all_metrics$cov_perc[k]), " %"),
                     color = case_when(all_metrics$cov_perc[k] < 30 ~ "red",
                                       all_metrics$cov_perc[k] > 75 ~ "green",
                                       TRUE ~ "yellow"),
                     style = "flat")

  writeLines(svg_test, here::here("status/badges", paste0(all_metrics$name[k], "_badge.svg")))

}



svg_test <- badgen(label = "Last Check",
                   status = as.character(as.Date(Sys.time())),
                   color = "blue",
                   style = "flat")

writeLines(svg_test, here::here("status/badges", "check_lasttest_badge.svg"))




