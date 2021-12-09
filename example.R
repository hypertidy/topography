


















library(gdalio)
source(system.file("raster_format/raster_format.codeR", package = "gdalio", mustWork = TRUE))

ll <- cbind(55.7558, 37.6173)[,2:1, drop = FALSE]
g <- list(extent = c(-1, 1, -1, 1) * 10000, dimension = as.integer(c(623, 623)/2), projection = sprintf("+proj=laea +lon_0=%f +lat_0=%f", ll[1], ll[2]))
gdalio_set_default_grid(g)

plot_topo_service <- function(src) {
  if (grepl("bandscount>3", src, ignore.case = TRUE)) {
    x <- gdalio_raster(src, bands = 1:3)
    raster::plotRGB(x)
  } else {
    x <- gdalio_raster(src, bands = 1)
    raster::image(x, col = hcl.colors(256), asp = 1)
  }
  x
}

library(dplyr)
srvs <- topography_services() %>% dplyr::filter(!grepl("mars", label),
                                                !grepl("rema", label),
                                                !grepl("struble", label))

s <- srvs <- topography_services() %>% dplyr::filter(grepl("struble", label))

par(mfrow = n2mfrow(nrow(srvs)))
for (i in seq_len(nrow(srvs))) {
  m <- plot_topo_service(srvs$file[i])
}






