#### modifying the README.md file to include latest test results


current_readme <- readLines(here::here("README.md"))

readmeAppend_line <- which(stringr::str_detect(current_readme, "The following percentages of code were covered during testing:"))
readmeAppendEnd_line <- which(stringr::str_detect(current_readme, "End of code coverage report."))

upper_block <- current_readme[1:(readmeAppend_line+1)]
lower_block <- current_readme[(readmeAppendEnd_line-1):length(current_readme)]

functions_R_folder <- list.files(path = here::here("R"),
                                 include.dirs = FALSE)

functions_test <- stringr::str_remove(string = functions_R_folder,
                                      pattern = ".R")

function_badges_block <- c()
function_badges_block[1:(2*length(functions_test)+1)] <- ""

for (i in 1:length(functions_test)){

  function_badges_block[(i-1)*2+2] <- paste0("![",functions_test[i],"](status/badges/",functions_test[i],"_badge.svg)")

}

readme_new <- c(upper_block,
                function_badges_block,
                lower_block)

writeLines(text = readme_new,
           con = here::here("README.md"))
