# vapour 0.2.0

* Add 'type' to output of `vapour_geom_summary`, the integer code for each geometry type. 

* Restructured conversion to text geometries to properly free up memory, was causing memory leaks (found
 with valgrind). 
 
* Use of `sql` now correctly uses 'GDALDataset::ReleaseResultsSet()' in each applicable function. Query
 with the 'sql' argument was not being executed in `vapour_layer_names` but now is - only has utility for
 insert and drop queries, so will be rarely used and probably never had any impact before. 

* Raster read gains a new argument `native = FALSE` to control use of the native window without
 specifiying it. If `native = TRUE` then the native dimensions are used and read in full. 

* Vector read functions gain new `extent` argument to apply a spatial filter in conjunction with 
 the `sql` argument, per discussion #34. The extent can be of type sp, sf, raster, or generic 
 vector `c(xmin, xmax, ymin, ymax)`.  The extent is ignored if the `sql` argument is not specified, 
 with a warning.  Applies to `vapour_geom_summary`,  `vapour_read_attributes`, `vapour_read_extent`, 
 `vapour_read_geometry`, `vapour_read_geometry_text`, and `vapour_read_names`. 

* Vector read functions gain new `limit_n` and `skip_n` arguments to specify a sequential set of 
 features to be read, added to `vapour_geom_summary`,  `vapour_read_attributes`, `vapour_read_extent`, 
 `vapour_read_geometry`, `vapour_read_geometry_text`, and `vapour_read_names`. Their effect occurs 
 after that of the `sql` argument. 
 
* New function `vapour_driver` to determine chosen driver (vector, short name) of the data source. 

* New argument `min_max` to allow fast default use of `vapour_raster_info`, as per #50. 

* New function `vapour_raster_gcp` to return GCP (ground control points) if present. 

* New function `vapour_report_attributes` to return a string description of the internal
 GDAL type for data attributes. 
 
* Attribute types 'OFTInteger64' are now returned as doubles, 'Date' and 'DateTime' are  returned as strings. 

* New functions `vapour_gdal_version` and `vapour_all_drivers` to return information about the GDAL library in use. 

* Function `vapour_read_names` is now implemented using the library API, rather than via OGRSQL. 
 All trace of the OGRSQL FID workaround and warning has been removed. 

* New function `vapour_geom_summary` to return basic identity, validity, and extent of feature geometries. 

* Values for the extent (bounding box) of a feature are now set to NA values for an  
 empty or missing geometry. 

* Fix drastic memory leak in `vapour_read_attributes`, thanks to Grant Williamson. 

# vapour 0.1.0

* Functions that include a `layer` index now accept a layer name which is used to find the (0-based) layer index. 

* This is a breaking release, all old functions have been made defunct or removed entirely. 

# vapour 0.0.1

* All C++ functions now have explicit R wrappers instead of Rcpp exports. 

* New naming convention uses `vapour_` for vector sources, `raster_` for raster sources 
 to make function names a little more consistent. 

* New wrapper `vapour_sds_names` to replace `sds_info` and `raster_sds_info` which are now deprecated. 

* New wrapper `vapour_read_geometry_what` to replace `vapour_read_feature_what` which i  is now deprecated. 

* New function  `vapour_read_names` to return the vector of FID values. 

* The read for raster data now returns numeric or integer appropriately. 

* `vapour_raster_info` now includes `bands` as the count of available bands. 

* The IO read now allows a 4-element `window` to return data at native resolution, by
 copying the third and fourth values (source dimension) to the fifth and sixth values
 (output dimension) respectively. 
 
* Subdatasets are now supported. 

* Added sanity check behaviour to `vapour_raster_read` to avoid out of bounds read attempts. 

* Resampling options added to raster data read. 

* Upgraded to rwinlib gdal 2.2.3. 

* added function `vapour_layer_names` to return character layer names, and
 implicitly provide a layer count

* feature iteration now avoids "GetFeatureCount" and collects each element
 in a growing list, thanks to Jim Hester

* renamed `format` argument to `textformat`, this is ignored unless `what = "text"`

* Created a single C++ feature read to remove repeated logic, `vapour_read_geometry`, `vapour_read_geometry_text`,  and `vapour_read_extent` all call the same function. 
