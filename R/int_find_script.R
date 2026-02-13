#'
#' @title Internal Function for pathing of the standardised files and scripts
#' @description This is an internal function which will find the correct path for the scripts during project setup after installation.
#' @details This function adapts the code from the internal function find_template from the `usethis::use_template` function.
#' @param script_name specifies which script is called.
#' @param package is the name of the package where the scripts are included ("mepr").
#' @return the path of the script_name
#' @author Florian Schwarz
#' @import fs
#' @import usethis
#'


int_find_script <- function(script_name, package = "mepr"){
  #usethis:::check_installed(package)
  path <- tryCatch(
    fs::path_package(package = package, "templates", script_name),
    error = function(e) ""
  )
  if(identical(path, "")){
    stop(paste0("Could not find the file: ", script_name, ". Please contact the developer team.") , call. = FALSE)
  }
  path
}
