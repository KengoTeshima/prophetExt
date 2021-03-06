#' Get layers to overlay significant changepoints on prophet forecast plot.
#'
#' @param m Prophet model object.
#' @param threshold Numeric, changepoints where abs(delta) >= threshold are significant. (Default 0.01)
#' @param cp_color Character, color for ggplot. (Default "red")
#' @param cp_linetype Character or integer, linetype for ggplot. (Default "dashed")
#' @param trend Logical, if FALSE, do not draw trend line. (Default TRUE)
#' @param ... Other arguments passed on to layers.
#'
#' @return A list of ggplot2 layer.
#'
#' @import ggplot2
#'
#' @examples
#' \dontrun{
#' plot(m, fcst) + layer_changepoints(m)
#' }
#'
#' @export
layer_changepoints <- function(m, threshold = 0.01, cp_color = "red",
                               cp_linetype = "dashed", trend = TRUE, ...) {
  layers <- list()
  if (trend) {
    trend_layer <- geom_line(aes_string("ds", "trend"), colour = cp_color, ...)
    layers <- append(layers, trend_layer)
  }
  signif_changepoints <- m$changepoints[abs(m$params$delta) >= threshold]
  cp_layer <- geom_vline(xintercept = as.integer(signif_changepoints),
                         colour = cp_color, linetype = cp_linetype, ...)
  layers <- append(layers, cp_layer)
  layers
}

set_date <- get("set_date", envir = asNamespace("prophet"))
