##' Welsh Air Quality Network data import for openair
##'
##' @keywords methods
##' @describeIn importAURN Import data from the Welsh Air Quality Network
##' @export
##' 

importWAQN <- function(site = "card", year = 2018, data_type = "hourly",
                       pollutant = "all", 
                       meta = FALSE, ratified = FALSE,
                       to_narrow = FALSE) {
  
  if (data_type %in% c("annual", "monthly")) {
    
    files <- paste0("https://airquality.gov.wales/sites/default/files/openair/R_data/summary_", 
                    data_type, "_WAQ_", year, ".rds")
    
    
    aq_data <- map_df(files, readSummaryData, 
                      data_type = data_type, 
                      to_narrow = to_narrow,
                      hc = FALSE)
    
    # add meta data?
    if (meta) {
      
      aq_data <- add_meta(source = "waqn", aq_data)
      
    }
    
    
  } else {
  
  aq_data <- importUKAQ(site = site, year = year, data_type,
                        pollutant = pollutant,
                        meta = meta, ratified = ratified,
                        to_narrow = to_narrow, 
                        source = "waqn")  
  
  }
  
  return(as_tibble(aq_data))
  
}
