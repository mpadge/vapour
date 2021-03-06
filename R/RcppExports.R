# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

vapour_gdal_version_cpp <- function() {
    .Call('_vapour_vapour_gdal_version_cpp', PACKAGE = 'vapour')
}

vapour_all_drivers_cpp <- function() {
    .Call('_vapour_vapour_all_drivers_cpp', PACKAGE = 'vapour')
}

raster_info_cpp <- function(filename, min_max) {
    .Call('_vapour_raster_info_cpp', PACKAGE = 'vapour', filename, min_max)
}

raster_gcp_cpp <- function(filename) {
    .Call('_vapour_raster_gcp_cpp', PACKAGE = 'vapour', filename)
}

raster_io_cpp <- function(filename, window, band = 1L, resample = "nearestneighbour") {
    .Call('_vapour_raster_io_cpp', PACKAGE = 'vapour', filename, window, band, resample)
}

sds_info_cpp <- function(pszFilename) {
    .Call('_vapour_sds_info_cpp', PACKAGE = 'vapour', pszFilename)
}

vapour_driver_cpp <- function(dsource) {
    .Call('_vapour_vapour_driver_cpp', PACKAGE = 'vapour', dsource)
}

vapour_layer_names_cpp <- function(dsource, sql = "") {
    .Call('_vapour_vapour_layer_names_cpp', PACKAGE = 'vapour', dsource, sql)
}

vapour_read_attributes_cpp <- function(dsource, layer = 0L, sql = "", limit_n = 0L, skip_n = 0L, ex = 0L) {
    .Call('_vapour_vapour_read_attributes_cpp', PACKAGE = 'vapour', dsource, layer, sql, limit_n, skip_n, ex)
}

vapour_read_geometry_cpp <- function(dsource, layer = 0L, sql = "", what = "geometry", textformat = "json", limit_n = 0L, skip_n = 0L, ex = 0L) {
    .Call('_vapour_vapour_read_geometry_cpp', PACKAGE = 'vapour', dsource, layer, sql, what, textformat, limit_n, skip_n, ex)
}

vapour_projection_info_cpp <- function(dsource, layer = 0L, sql = "") {
    .Call('_vapour_vapour_projection_info_cpp', PACKAGE = 'vapour', dsource, layer, sql)
}

vapour_read_names_cpp <- function(dsource, layer = 0L, sql = "", limit_n = 0L, skip_n = 0L, ex = 0L) {
    .Call('_vapour_vapour_read_names_cpp', PACKAGE = 'vapour', dsource, layer, sql, limit_n, skip_n, ex)
}

vapour_report_attributes_cpp <- function(dsource, layer = 0L, sql = "") {
    .Call('_vapour_vapour_report_attributes_cpp', PACKAGE = 'vapour', dsource, layer, sql)
}

