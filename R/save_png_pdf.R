

#' Save a ggplot as png and pdf in two seperate folders
#'
#' @param plot
#' @param name
#' @param dir
#' @param height
#' @param width
#'
#' @return
#' @export
#'
#' @examples
png_pdf_save <- function(plot,
                         name,
                         dir = here::here("plots"),
                         height,
                         width) {

  # set paths
  pdf_path <- file.path(dir, "pdf")
  png_path <- file.path(dir, "png")

  # create dirs if not present
  fs::dir_create(path = pdf_path)
  fs::dir_create(path = png_path)

  # set file names
  pdf_name <- file.path(pdf_path, name)
  png_name <- file.path(png_path, name)

  # save ggplot as pdf
  ggplot2::ggsave(plot = plot,
                  filename = glue::glue("{pdf_name}.pdf"),
                  height = height,
                  width = width,
                  units = "cm",
                  dpi = 300,
                  device = cairo_pdf)

  # Convert to png and save
  pdftools::pdf_convert(pdf = glue::glue("{pdf_name}.pdf"),
                        filenames = glue::glue("{png_name}.png"),
                        format = "png",
                        dpi = 300)
}
