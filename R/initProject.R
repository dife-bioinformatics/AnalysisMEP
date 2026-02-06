#'
#' @title Function to initiate a new project
#' @description The function will create a new DataSHIELD analysis project environment
#' @details This function adaptssome things.
#' @param location specifies the location where the project shall be created
#' @return the location of the script_name
#' @author Florian Schwarz for the German Institute of Human Nutrition
#' @import renv
#' @import usethis
#' @export
#'

initProject <- function(location = NULL){

  if(is.null(location)){
    stop("Please provide a path name for the project to be created.", call. = FALSE)
  }

  #### sets up normal R Project
  usethis::create_project(location,
                          open = FALSE,
                          rstudio = TRUE)

  #### creates additional folder structure
  dir.create(paste0(location, "/data"))
  dir.create(paste0(location, "/data-raw"))
  dir.create(paste0(location, "/results"))
  dir.create(paste0(location, "/results/tables"))
  dir.create(paste0(location, "/results/figures"))
  dir.create(paste0(location, "/R/utils"))

  #### copies over standardised R scripts for start
  file.copy(from = find_script("scripts/01_data_management.R"),
            to = paste0(location, "/R/01_data_management.R"))
  file.copy(from = find_script("scripts/example_script.R"),
            to = paste0(location, "/R/02_example.R"))
  file.copy(from = find_script("scripts/custom_functions.R"),
            to = paste0(location, "/R/utils/custom_function_example.R"))


  #### copies over placeholder files to keep folder structure in place for GitHub
  #### for folders that should not be shared (e.g. results)
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(location, "/results/tables/aim_for_machine_readable.txt"))
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(location, "/results/figures/aim_for_png.txt"))
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(location, "/data/all_processed_data.txt"))
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(location, "/data-raw/only_raw_data.txt"))

  #### copies over initial config.yml file
  #### not sure if we should keep this but it is extremely helpful for checking out to improve figures
  #### could be used to determine the theme in ggplot e.g.
  #### could also be used in connection with how to flexibly merge plots together into one figure
  #### set fixed fonts throughout
  file.copy(from = find_script("utils/config.yml"),
            to = paste0(location, "/config.yml"))


  #### modify .gitignore file
  gitignore_lines <- c("",
                       ".Renviron",
                       " ",
                       "data/*",
                       "!data/placeholder.txt",
                       "  ",
                       "data-raw/*",
                       "!data-raw/placeholder.txt",
                       "   ",
                       "results/plots/*",
                       "!results/plots/placeholder.txt",
                       "    ",
                       "results/tables/*",
                       "!results/tables/placeholder.txt")

  usethis::write_union(path = paste0(location, "/.gitignore"),
                       lines = gitignore_lines)


  #### initiate and fill standard .Renviron file

  r_environ_lines <- c("R_CONFIG_ACTIVE = 'default'")

  usethis::write_over(path = paste0(location, "/.Renviron"),
                      lines = r_environ_lines)

  r_profile_lines <- c("source(\"renv/activate.R\")")

  usethis::write_over(path = paste0(location, "/.Rprofile"),
                      lines = r_profile_lines)

  renv::init(project = location,
             load = FALSE)

  renv::install()
}
