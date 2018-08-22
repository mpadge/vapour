## helpers

## TODO
## add limit_n, good example to ensure it works for extent, names, and check in combo with SQL


#' Summary of available geometry
#'
#' Read properties of geometry from a source, optionally after SQL execution.
#'
#' Use `limit_n` to arbitrarily limit the number of features queried.
#' @inheritParams vapour_read_geometry
#'
#' @return list containing the following
#' * `FID` the feature id value (an integer, usually sequential)
#' * `valid_geometry` logical value if a non-empty geometry is available
#' * `xmin, xmax, ymin, ymax` numeric values of the extent (bounding box) of each geometry
#' @export
#'
#' @examples
#' file <- "list_locality_postcode_meander_valley.tab"
#' mvfile <- system.file(file.path("extdata/tab", file), package="vapour")
#' vapour_geom_summary(mvfile, limit_n = 3L)
#'
#' gsum <- vapour_geom_summary(mvfile)
#' plot(NA, xlim = range(c(gsum$xmin, gsum$xmax), na.rm = TRUE),
#'          ylim = range(c(gsum$ymin, gsum$ymax), na.rm = TRUE))
#' rect(gsum$xmin, gsum$ymin, gsum$xmax, gsum$ymax)
#' text(gsum$xmin, gsum$ymin, labels = gsum$FID)
vapour_geom_summary <- function(dsource, layer = 0L, sql = "", limit_n = NULL) {
  #limit_n <- validate_limit_n(limit_n)
  if (!is.numeric(layer)) layer <- index_layer(x = dsource, layername = layer)
  extents <- vapour_read_extent(dsource = dsource, layer = layer, sql = sql, limit_n = limit_n)
  fids <- vapour_read_names(dsource = dsource, layer = layer, sql = sql)
  if (!is.null(limit_n) && limit_n > 0) {
    ## we can't pass limit_n to vapour_read_names ()
    fids <- fids[seq(1L, limit_n)]
  }
  na_geoms <- unlist(lapply(extents, anyNA))
  list(FID = fids,
       valid_geometry = !na_geoms,
       xmin = unlist(lapply(extents, "[", 1L)),
       xmax = unlist(lapply(extents, "[", 2L)),
       ymin = unlist(lapply(extents, "[", 3L)),
       ymax = unlist(lapply(extents, "[", 4L)))
}