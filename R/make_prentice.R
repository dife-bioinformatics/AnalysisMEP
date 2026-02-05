#' Generate start and stop times that can be used for a Prentice weighted Cox PH model
#'
#' @param df A data frame containing the dataset.
#' @param age A numeric vector representing the age of participants.
#' @param censor_date A Date vector representing the censor date for each participant.
#' @param diagnosis_date A Date vector representing the diagnosis date for each participant.
#' @param recruitment_date A Date vector representing the recruitment date for each participant.
#' @param subcohort A binary variable indicating whether a participant is in the subcohort (1) or not (0).
#' @param outcome_label A label for the outcome used in the generated column names.
#'
#' @return A modified data frame with start and stop times added.
#' @export
#'
#' @examples
#' # Example usage:
#' df <- data.frame(age = c(50, 60), censor_date = as.Date(c("2024-07-01", "2025-07-01")),
#' diagnosis_date = as.Date(c("2023-07-01", "2024-07-01")),
#' recruitment_date = as.Date(c("2020-07-01", "2019-07-01")),
#' subcohort = c(1, 0))
#' make_prentice(df, age, censor_date, diagnosis_date, recruitment_date, subcohort, "example")
make_prentice <- function(df,
                          age,
                          censor_date,
                          diagnosis_date,
                          recruitment_date,
                          subcohort,
                          outcome_label) {

  df |>
    # Calculate the temporary stop time
    dplyr::mutate(stop_time_temp = as.numeric({{age}} + (pmin({{censor_date}},
                                                              {{diagnosis_date}},
                                                              na.rm = TRUE) - {{recruitment_date}})/365.25),
                  # Define the start time for the outcome
                  "start_time_{outcome_label}" := dplyr::if_else({{subcohort}} == 1,
                                                                 {{age}},
                                                                 as.numeric(stop_time_temp - 0.0005)),
                  # Define the stop time for the outcome
                  "stop_time_{outcome_label}" := stop_time_temp
    )|>
    # Remove the temporary stop time
    dplyr::select(-stop_time_temp)
}
