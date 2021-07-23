
<!-- README.md is generated from README.Rmd. Please edit that file -->

# topography

<!-- badges: start -->
<!-- badges: end -->

The goal of topography is to provide configurations to some big player
topography sources. These are intended for use directly via GDAL (see
for example [gdalio](https://github.com/hypertidy/gdalio)) but we only
really need text processing stuff here, no actual spatial stuff.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
options(repos = c(
    hypertidy = 'https://hypertidy.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'))
install.packages("topography")
```

## Example

This is a basic example showing a few sources and read via GDAL into
matching grids.

``` r
library(gdalio)

## read as matrix
gdalio_matrix <- function(dsn, ...) {
  v <- gdalio_data(dsn, ...)
  g <- gdalio_get_default_grid()
  matrix(v[[1]], g$dimension[1])[,g$dimension[2]:1, drop = FALSE]
}
## plot the data
gdalio_plot <- function(x, col = grey.colors(256), ..., asp = 1,  useRaster = TRUE) {
  g <- gdalio_get_default_grid()
  image(list(x = seq(g$extent[1], g$extent[2], length.out = g$dimension[1] + 1),
             y = seq(g$extent[3], g$extent[4], length.out = g$dimension[2] + 1),
             z = x), col = col, ..., useRaster = useRaster, asp = asp)
}

## set default grid to use as target
gdalio_set_default_grid(list(extent = c(50, 180, -85, -20),
 dimension = as.integer(c(1024, 512)),
 projection = "OGC:CRS84"))

## package to configure some transparent online topography sources
library(topography)
par(mfrow = c(2, 2))
gebco <- gdalio_matrix(topography_source(x = "gebco"))
gdalio_plot(gebco, main = "GEBCO", asp = 1.6)
aws <- gdalio_matrix(topography_source("aws"))
gdalio_plot(aws, main = "AWS TERRAIN TILES", asp= 1.6)
## for mars we can't pretend to be earth anymore
gmars <- gdalio_get_default_grid()
gmars$projection <- "+proj=longlat +R=3389500"
gdalio_set_default_grid(gmars)
mars <- gdalio_matrix(topography_source("mars"))
gdalio_plot(mars, main = "MARS", asp = 1.6)



## set default grid to use as target
gdalio_set_default_grid(list(extent = c(-1, 1, -1, 1) * 5e6,
                             dimension = as.integer(c(1024, 1024)),
                             projection = "EPSG:3031"))

par(mfrow = c(2, 2))
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
gebco <- gdalio_matrix(topography_source(x = "gebco"))
gdalio_plot(gebco, main = "GEBCO")
aws <- gdalio_matrix(topography_source("aws"))
gdalio_plot(aws, main = "AWS TERRAIN TILES")
## for mars we can't pretend to be earth anymore
gmars <- gdalio_get_default_grid()
gmars$projection <- "+proj=stere +lat_0=-90 +type=crs +R=3389500"
gdalio_set_default_grid(gmars)
mars <- gdalio_matrix(topography_source("mars"))
gdalio_plot(mars, main = "MARS")
## this isn't really practical because ftp, we'll see
#rema <- gdalio_matrix(topography_source("rema"))
#gdalio_plot(rema)
```

<img src="man/figures/README-example-2.png" width="100%" />

------------------------------------------------------------------------

## Code of Conduct

Please note that the topography project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.