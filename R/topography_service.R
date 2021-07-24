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
topography_source <- function(x = c("gebco", "aws", "mars", "rema_100m", "srtm15", "nasadem", "id18_struble_op", "id18_struble_hh", "id18_struble_be", "srtm_gl1", "srtm_gl3")) {
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
#' @return data frame of label, name, file
#' @importFrom tibble tibble
#' @examples
#' topography_services()
topography_services <- function() {
  tibble::tibble(name = c("GEBCO_GRID", "AWS_ELEVATION-TILES-PROD", "HRSC_MOLA_Blend", "REMA_100m", "SRTM15Plus", "NASADEM",
                          "ID18_Struble_op", "ID18_Struble_hh", "ID18_Struble_be", "SRTM_GL1", "SRTM_GL3"),
                 label = c("gebco", "aws", "mars", "rema_100m", "srtm15", "nasadem", "id18_struble_op", "id18_struble_hh", "id18_struble_be", "srtm_gl1", "srtm_gl3"),
                 file =
                    c(                      system.file("gdalwms/gebco_grid.xml", package = "topography", mustWork = TRUE),
                                            system.file("gdalwms/aws_elevation-tiles-prod.xml", package = "topography", mustWork = TRUE),
                                            "/vsicurl/https://planetarymaps.usgs.gov/mosaic/Mars/HRSC_MOLA_Blend/Mars_HRSC_MOLA_BlendDEM_Global_200mp_v2.tif",
                                            "/vsicurl/ftp://ftp.data.pgc.umn.edu/elev/dem/setsm/REMA/mosaic/v1.1/100m/REMA_100m_dem.tif",
                                            "/vsicurl/https://opentopography.s3.sdsc.edu/raster/SRTM15Plus/SRTM15Plus_srtm.vrt",
                                            "/vsicurl/https://opentopography.s3.sdsc.edu/raster/NASADEM/NASADEM_be.vrt",
                                            "/vsicurl/https://opentopography.s3.sdsc.edu/raster/ID18_Struble/ID18_Struble_op.vrt",
                                            "/vsicurl/https://opentopography.s3.sdsc.edu/raster/ID18_Struble/ID18_Struble_hh.vrt",
                                            "/vsicurl/https://opentopography.s3.sdsc.edu/raster/ID18_Struble/ID18_Struble_be.vrt",
                                            "/vsicurl/https://opentopography.s3.sdsc.edu/raster/SRTM_GL1/SRTM_GL1_srtm.vrt",
                                            "/vsicurl/https://opentopography.s3.sdsc.edu/raster/SRTM_GL3/SRTM_GL3_srtm.vrt"
                    )
                    )
}

