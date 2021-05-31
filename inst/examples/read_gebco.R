.tp_standard_version_check <- function() {
  vers <- try(packageVersion("vapour"), silent = TRUE)
  if (inherits(vers, "try-error")) vers <- "0."
  if (vers < "0.5.5.9602") {
    stop("the development version of {vapour} is required, at least 0.5.5.9602
         to install please run
         remotes::install_github(\"hypertidy/vapour\")
         you might need to install.packages(\"remotes\") first ;)
         and if an earlier version of {vapour} is installed try restarting R first
         ")
  }

}

## note this is RGB (there's no elevation data afaics)
read_gebco <- function(xylim = NULL, ...) {
  .tp_standard_version_check()
  ext <- topography:::.tp_gebco_defaultgrid(xylim)

  vfile <- topography::topography_source("gebco")
  prj <- ext@crs@projargs
  if (is.na(prj) || nchar(prj) == 0) stop("no valid projection metadata on 'xylim', this must be present")
  l <- vapour::vapour_warp_raster(vfile, band = 1:3, extent = raster::extent(ext), dimension = dim(ext)[2:1],
                                  wkt = vapour::vapour_srs_wkt(raster::projection(ext)),
                                  resample = "near")
  raster::setValues(raster::brick(ext, ext, ext), matrix(unlist(l), ncol = 3))
}
