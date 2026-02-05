
#' Check if Prentice weighting worked by visualizing follow-up times
#'
#' @param df A data frame containing the dataset.
#' @param start_time A numeric vector representing the start times.
#' @param stop_time A numeric vector representing the stop times.
#' @param outcome A binary variable indicating the outcome (1 if event occurred, 0 otherwise).
#' @param subcohort A binary variable indicating whether a participant is in the subcohort (1) or not (0).
#' @param id A unique identifier for each participant.
#' @param samplesize An integer specifying the number of samples to visualize (default is 10).
#
#' @return A ggplot object visualizing the follow-up times.
#' @export
#'
#' @examples
#' # Example usage:
#' df <- data.frame(start_time = c(50, 60), stop_time = c(55, 65),
#' outcome = c(1, 0), subcohort = c(1, 0), id = c(1, 2))
#' sanity_check_fup_time(df, start_time, stop_time, outcome, subcohort, id)
check_prentice <- function(df,
                           start_time,
                           stop_time,
                           outcome,
                           subcohort,
                           id,
                           samplesize = 10) {
  df |>
    # Select the first n samples from each outcome and subcohort group
    dplyr::slice_head(n = samplesize,
                      by = c({{outcome}}, {{subcohort}})) |>
    # Categorize the participants
    dplyr::mutate(cats = dplyr::case_when({{outcome}} == 1 & {{subcohort}} == 1 ~ "Internal cases",
                                          {{outcome}} == 1 & {{subcohort}} == 0 ~ "External cases",
                                          {{outcome}} == 0 & {{subcohort}} == 1 ~ "Non-cases")) |>
    # Select relevant columns
    dplyr::select({{start_time}}, {{stop_time}}, cats, {{id}}) |>
    # Reshape data for plotting
    pivot_longer(-c({{id}}, cats)) |>
    # Create the plot
    ggplot(aes(y = {{id}} |> as_factor(),
               x = value,
               group = {{id}},
               fill = name)) +
    facet_wrap(~fct_rev(cats),
               ncol = 1,
               scales = "free_y") +
    theme_classic() +
    labs(y = NULL,
         fill = NULL,
         x = "Age of participants at start/stop") +
    geom_line(lty = 3) +
    theme(legend.position = "bottom") +
    geom_point(aes(size = name),
               shape = 21) +
    scale_size_manual(values = c(4, 2)) +
    guides(size = "none")
}
