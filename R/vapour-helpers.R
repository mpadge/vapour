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
#' * `type` integer value of geometry type from [GDAL enumeration](https://www.gdal.org/ogr__core_8h.html#a800236a0d460ef66e687b7b65610f12a)
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
vapour_geom_summary <- function(dsource, layer = 0L, sql = "", limit_n = NULL, skip_n = 0, extent = NA) {
  #limit_n <- validate_limit_n(limit_n)
  if (!is.numeric(layer)) layer <- index_layer(x = dsource, layername = layer)
  extent <- validate_extent(extent, sql, warn = FALSE)

  extents <- vapour_read_extent(dsource = dsource, layer = layer, sql = sql, limit_n = limit_n, skip_n = skip_n, extent = extent)
  fids <- vapour_read_names(dsource = dsource, layer = layer, sql = sql, limit_n = limit_n, skip_n = skip_n, extent = extent)
  ## FIXME the other funs deal with these args
  limit_n <- validate_limit_n(limit_n)
  extent <- validate_extent(extent, sql)
   types <- unlist(vapour_read_geometry_cpp(dsource = dsource, layer = layer, sql = sql, limit_n = limit_n, skip_n = skip_n, ex = extent, what = "type"))
  na_geoms <- unlist(lapply(extents, anyNA))
  list(FID = fids,
       valid_geometry = !na_geoms,
       type = types,
       xmin = unlist(lapply(extents, "[", 1L)),
       xmax = unlist(lapply(extents, "[", 2L)),
       ymin = unlist(lapply(extents, "[", 3L)),
       ymax = unlist(lapply(extents, "[", 4L)))
}

#' GDAL version and drivers.
#'
#' Return information about the GDAL library in use.
#'
#' `vapour_gdal_version` returns the version of GDAL as a string. This corresponds to the "--version"
#' as described for "GDALVersionInfo". [GDAL documentation](https://www.gdal.org/gdal_8h.html).
#'
#' `vapour_all_drivers` returns the names and capabilities of all available drivers, in a list. This contains:
#' * `driver` the driver (short) name
#' * `name` the (long) description name
#' * `vector` logical vector indicating a vector driver
#' * `raster` logical vector indicating a raster driver
#' * `create` driver can create (note vapour provides no write capacity)
#' * `copy`   driver can copy (note vapour provides no write capacity)
#' * `virtual` driver has virtual capabilities ('vsi')
#' @export
#' @aliases vapour_all_drivers vapour_driver
#' @rdname GDAL-library
#' @examples
#' vapour_gdal_version()
vapour_gdal_version <- function() {
  vapour_gdal_version_cpp()
}
#' @rdname GDAL-library
#' @export
vapour_all_drivers <- function() {
  vapour_all_drivers_cpp()
}


#' @rdname GDAL-library
#' @export
#' @param dsource data source string (i.e. file name or URL or database connection string)
vapour_driver <- function(dsource) {
  stopifnot(is.character(dsource))
  stopifnot(nchar(dsource) > 0)
  vapour_driver_cpp(dsource)
}

