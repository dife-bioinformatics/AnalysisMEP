
test_that(".find script", {

  package <- "mepr"
  test_name <- "testproj-456"
  tmp_path <- fs::path_temp()
  tmp_path_to_proj <- mepr::initialize_project(path = tmp_path, name = test_name)

  script_name1 <- "scripts/01_data_management.R"
  script_name2 <- "scripts/example_script.R"
  script_name3 <- "scripts/custom_functions.R"
  script_name4 <- "utils/config.yml"
  script_name5 <- "utils/placeholder.txt"
  script_name6 <- "utils/README.md"

  testthat::expect_no_error(mepr:::int_find_script(script_name = script_name1))
  testthat::expect_no_error(mepr:::int_find_script(script_name = script_name2))
  testthat::expect_no_error(mepr:::int_find_script(script_name = script_name3))
  testthat::expect_no_error(mepr:::int_find_script(script_name = script_name4))
  testthat::expect_no_error(mepr:::int_find_script(script_name = script_name5))
  testthat::expect_no_error(mepr:::int_find_script(script_name = script_name6))

  #### Testing when pathing goes wrong to the scripts / files
  script_name_error <- "01_data_management.R"
  error_message <- testthat::expect_error(mepr:::int_find_script(script_name = script_name_error))

  #### Testing that the error message is consistent
  testthat::expect_equal(error_message$message,
                         paste0("Could not find the file: ", script_name_error, ". Please contact the developer team."))


})



