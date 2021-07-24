# /vsicurl/https://opentopography.s3.sdsc.edu/raster/SRTM15Plus/SRTM15Plus_srtm.vrt
# /vsicurl/https://opentopography.s3.sdsc.edu/raster/NASADEM/NASADEM_be.vrt
# /vsicurl/https://opentopography.s3.sdsc.edu/raster/ID18_Struble/ID18_Struble_op.vrt
# /vsicurl/https://opentopography.s3.sdsc.edu/raster/ID18_Struble/ID18_Struble_hh.vrt
# /vsicurl/https://opentopography.s3.sdsc.edu/raster/ID18_Struble/ID18_Struble_be.vrt
# /vsicurl/https://opentopography.s3.sdsc.edu/raster/SRTM_GL1/SRTM_GL1_srtm.vrt
# /vsicurl/https://opentopography.s3.sdsc.edu/raster/SRTM_GL3/SRTM_GL3_srtm.vrt
#



#NOPE


# #opentopography
# baseurl <- "https://opentopography.s3.sdsc.edu/raster"
# xml <- readLines(baseurl)
# xml <-paste(xml, collapse = " ")
# tx0 <- unlist(strsplit(xml, "<Key>"))[-1]
# tx <- unlist(lapply(strsplit(tx0, "</Key"), "[", 1))
#
# ## just adf or vrt
# #unique(fs::path_ext(tx))
#
# library(dplyr)
# opentopography_all <- tibble::tibble(url = fs::path(baseurl, tx))
# opentopography_sources <- opentopography_all %>%
#   mutate(type = fs::path_ext(url)) %>% dplyr::filter(type %in% c("vrt", "adf")) %>%
#   dplyr::filter(stringr::str_detect(type, "vrt$") | stringr::str_detect(url, "w001001.adf") )
#
# opentopography_vrt <- dplyr::filter(opentopography_sources, type == "vrt")

