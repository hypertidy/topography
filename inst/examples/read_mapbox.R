




read_mapbox_satellite <- function(xylim = NULL, ...) {
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
  .tp_standard_version_check()


  MAPBOX_API_KEY <- Sys.getenv("MAPBOX_API_KEY")
  url <- sprintf("https://api.mapbox.com/v4/mapbox.satellite/${z}/${x}/${y}.jpg?access_token=%s", MAPBOX_API_KEY)

  vfile <- tempfile(fileext = ".xml")
  writeLines(sprintf(readLines(system.file("examples/mapbox_template.xml", package = "topography", mustWork = TRUE)), url), vfile)


  ext <- topography:::.tp_gebco_defaultgrid(xylim)

  prj <- ext@crs@projargs
  if (is.na(prj) || nchar(prj) == 0) stop("no valid projection metadata on 'xylim', this must be present")
  l <- vapour::vapour_warp_raster(vfile, band = 1:3, extent = raster::extent(ext), dimension = dim(ext)[2:1],
                                  wkt = vapour::vapour_srs_wkt(raster::projection(ext)),
                                  resample = "near")
  raster::setValues(raster::brick(ext, ext, ext), matrix(unlist(l), ncol = 3))

}

library(raster)
mb <- read_mapbox_satellite(raster(extent(c(-1, 1, -1, 1) * 5e6), res = 25000, crs = "+proj=laea +lat_0=-90"))
plotRGB(mb)



















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

read_mapbox_terrain <- function(xylim = NULL, ...) {

  .tp_standard_version_check()


  MAPBOX_API_KEY <- Sys.getenv("MAPBOX_API_KEY")
  url <- sprintf("https://api.mapbox.com/v4/mapbox.terrain-rgb/${z}/${x}/${y}.png?access_token=%s", MAPBOX_API_KEY)

  vfile <- tempfile(fileext = ".xml")
  writeLines(sprintf(readLines(system.file("examples/mapbox_template.xml", package = "topography", mustWork = TRUE)), url), vfile)


  ext <- topography:::.tp_gebco_defaultgrid(xylim)

  prj <- ext@crs@projargs
  if (is.na(prj) || nchar(prj) == 0) stop("no valid projection metadata on 'xylim', this must be present")
  l <- vapour::vapour_warp_raster(vfile, band = 1:3, extent = raster::extent(ext), dimension = dim(ext)[2:1],
                                  wkt = vapour::vapour_srs_wkt(raster::projection(ext)),
                                  resample = "near")
  dat <-  -10000 + ((l[[1]] * 256 * 256 + l[[2]] * 256 + l[[3]]) * 0.1)
  raster::setValues(ext, dat)
}

library(raster)
ele <- read_mapbox_terrain(raster(extent(c(-1, 1, -1, 1) * 5e5), res = 1000, crs = "+proj=laea +lat_0=-42 +lon_0=147"))
## fixme
#ele[ele < -9000] <- NA
plot(ele, col = grey.colors(256))

