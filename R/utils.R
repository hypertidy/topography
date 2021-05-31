#' @importFrom raster raster projection extent
.tp_gebco_defaultgrid <- function(x) {
  if (missing(x) || is.null(x)) {
    return(raster::raster(raster::extent(-180, 180, -90, 90), res = 0.1, crs = "+proj=longlat +datum=WGS84"))
  }
  if (inherits(x, "RasterLayer")) {
    return(x)
  } else {
    ext <- raster::raster(x, res = 0.1, crs = "+proj=longlat +datum=WGS84")
    if (is.na(raster::projection(ext))) {
      ext <- raster::projection(ext) <- "+proj=longlat +datum=WGS84"
    }
  }
  ext
}
