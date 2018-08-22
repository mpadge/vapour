context("test-helpers")

file <- "list_locality_postcode_meander_valley.tab"
mvfile <- system.file(file.path("extdata/tab", file), package="vapour")

##dput(vapour_geom_summary(mvfile, sql = sprintf("SELECT FID FROM %s WHERE FID = 15", vapour_layer_names(mvfile)[1L])))
sql_bench <- list(FID = 15L, valid_geometry = TRUE, xmin = 455980.34, xmax = 463978.72,
                  ymin = 5392869.75, ymax = 5399258.91)

test_that("helpers work", {
  vapour_geom_summary(mvfile) %>% expect_named(c("FID", "valid_geometry", "xmin", "xmax", "ymin", "ymax"))

  vapour_geom_summary(mvfile, sql = sprintf("SELECT FID FROM %s WHERE FID = 15", vapour_layer_names(mvfile)[1L])) %>%
    expect_equal(sql_bench)

  expect_warning(
    fid_select("SELECT donkey FROM donkykong")  %>% expect_equal("SELECT FID FROM donkykong"),
    "boilerplate"
)
  fid_select("") %>% expect_equal("")
})