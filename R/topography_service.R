#' File path for topography
#'
#' Obtain the installed file path for a GDAL WMS source for an online topography.
#'
#' @param x name of the 'label' of the topography source, see [topography_services]
#'
#' @return file path to an installed .xml configuration of an online raster (WMS) tile service
#' @export
#'
#' @examples
#' topography_source("aws")
#' topography_source("gebco")
topography_source <- function(x = c("gebco", "aws")) {
  x <- match.arg(x)
  services <- topography_services()
  idx <- match(x, services$label)
  if (!is.na(idx)) {
    return(services$file[idx])
  } else {
    stop(sprintf("cannot find topography source %s", x))
  }
}
#' Available topography services
#'
#' Name, label, and file path for online raster sources.
#'
#' See [topography_source] for a direct lookup for a given file.
#' @export
#' @value data frame of label, name, file
#' @examples
#' topography_services()
topography_services <- function() {
  tibble::tibble(name = c("GEBCO_GRID", "AWS_ELEVATION-TILES-PROD"),
                 label = c("gebco", "aws"),
                 file =
                    c(                      system.file("gdalwms/gebco_grid.xml", package = "topography", mustWork = TRUE),
                                            system.file("gdalwms/aws_elevation-tiles-prod.xml", package = "topography", mustWork = TRUE)))
}
