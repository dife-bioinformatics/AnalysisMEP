#' Generate alcohol intake categories
#'
#' @param df A data frame containing the dataset.
#' @param gender A binary variable indicating the gender (0 for female, 1 for male).
#' @param alc_var A numeric variable representing alcohol intake.
#'
#' @return A data frame with a new column \code{alccat} representing alcohol intake categories.
#' @export
#'
#' @examples
#' # Example usage:
#' df <- data.frame(gender = c(0, 1), alc_var = c(10, 15))
#' make_alccat(df, gender, alc_var)
make_alccat <- function(df, gender, alc_var) {
  df %>%
    # Create alcohol intake categories based on gender and intake levels
    dplyr::mutate(
      alccat = dplyr::case_when(
        {{gender}} == 0 & {{alc_var}} == 0 ~ 0,
        {{gender}} == 0 & {{alc_var}} > 0 & {{alc_var}} <= 6 ~ 1,
        {{gender}} == 0 & {{alc_var}} > 6 & {{alc_var}} <= 12 ~ 2,
        {{gender}} == 0 & {{alc_var}} > 12 & {{alc_var}} <= 24 ~ 3,
        {{gender}} == 0 & {{alc_var}} > 24 & {{alc_var}} <= 60 ~ 4,
        {{gender}} == 0 & {{alc_var}} > 60 & {{alc_var}} <= 96 ~ 5,
        {{gender}} == 0 & {{alc_var}} > 96 ~ 6,
        {{gender}} == 1 & {{alc_var}} == 0 ~ 0,
        {{gender}} == 1 & {{alc_var}} > 0 & {{alc_var}} <= 6 ~ 1,
        {{gender}} == 1 & {{alc_var}} > 6 & {{alc_var}} <= 12 ~ 2,
        {{gender}} == 1 & {{alc_var}} > 12 & {{alc_var}} <= 24 ~ 3,
        {{gender}} == 1 & {{alc_var}} > 24 & {{alc_var}} <= 60 ~ 4,
        {{gender}} == 1 & {{alc_var}} > 60 ~ 5))
}
