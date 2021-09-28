
require(tidyverse)
require(glue)
require(httr)
require(renv)



get_API_data <- function() {
  
  # Tree Data
  # -- https://data.sfgov.org/City-Infrastructure/Street-Tree-List/tkzw-k3nq
  
  temp <- geojsonR::FROM_GeoJson("data/raw/Park Lands - Recreation and Parks Department.geojson")
  
  
  
  # Park Data
  # -- https://data.sfgov.org/Culture-and-Recreation/Park-Lands-Recreation-and-Parks-Department/42rw-e7xk
  
  temp <- readr::read_csv("data/raw/Stree_Tree_List.csv")
  
  
  # 
  
  # tree_data <- 
  glue::glue("https://data.sfgov.org/resource/{data_ids[[name]]}.json")
  
  for (name in names(data_ids)) {
    # data_df[[name]] <- 
    #   glue::glue("https://data.sfgov.org/resource/{data_ids[[name]]}.json") %>% 
    #   httr::GET() %>% httr::content() %>% 
    #   purrr::map_df(tibble::as_tibble)
    
    data_df[[name]] <- 
      glue::glue("https://data.sfgov.org/resource/{data_ids[[name]]}.json") %>% 
      RSocrata::read.socrata() %>% tibble::as_tibble()
  }
  
  
  
}

get_parks_data <- function() {
  
  # data_id <-
  # 
  # data_id = "3nje-yn2u"
  # raw = requests.get(f"https://data.sfgov.org/resource/{data_id}.json")
  # raw.content
  
}

