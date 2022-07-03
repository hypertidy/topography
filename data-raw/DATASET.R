topos <-  rbind(topography_services(), more_topography_services()) |> dplyr::distinct()

readr::write_csv(topos, "inst/extdata/topos.csv")

#raadtools::topofile knows about these
# topos <- c("gebco_08",  "ibcso",
#   "etopo1", "etopo2",
#   "kerguelen", "george_v_terre_adelie",
#   "smith_sandwell", "gebco_14", "macrie1100m", "macrie2100m", "cryosat2",
#   "lake_superior",
#   "ramp", "ibcso_is", "ibcso_bed",
#   "ga_srtm",
#   "rema_1km",
#   "rema_200m",
#   "rema_100m",
#   "rema_8m",
#   "srtm", "gebco_19")


## gdal_translate WMS:https://www.gebco.net/data_and_products/gebco_web_services/web_map_service/mapserv?LAYERS=GEBCO_Grid inst/gdalwms/gebco_grid.xml -of WMS
