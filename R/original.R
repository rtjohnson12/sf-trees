
library(tidyverse)
library(RSocrata)
library(gganimate)
library(ggplot2)
library(ggmap)

options(dplyr.width = Inf)

# https://data.sfgov.org/Culture-and-Recreation/Park-Lands-Recreation-and-Parks-Department/42rw-e7xk
# https://data.sfgov.org/Energy-and-Environment/San-Francisco-Plant-Community-Areas/27u4-a5b3
# https://data.sfgov.org/Energy-and-Environment/Elevation-Contours/rnbg-2qxw
# https://data.sfgov.org/City-Infrastructure/Street-Tree-List/tkzw-k3nq

sf_tree_data_loc <- "https://data.sfgov.org/resource/tkzw-k3nq.json"
sf_tree_data_df  <- RSocrata::read.socrata(sf_tree_data_loc)

filtered_tree_dat <- sf_tree_data_df %>%
  tibble::as_tibble() %>% 
  tidyr::drop_na(latitude, longitude, plantdate) %>% 
  dplyr::mutate_at(dplyr::vars(latitude, longitude), as.numeric) %>% 
  dplyr::filter(between(latitude, 37.65, 40)) %>% 
  dplyr::mutate(year = as.integer(lubridate::year(plantdate)))

bbox <- ggmap::make_bbox(lat = latitude, lon = longitude, data = filtered_tree_dat)
base_map <- ggmap::get_map(location = bbox, source = "stamen", crop = FALSE, maptype = "toner", force = TRUE)

all_trees_plot <- ggmap::ggmap(base_map) + 
  geom_point(aes(x = longitude, y = latitude),
             color = 'forestgreen',
             alpha = 0.1,
             size = 0.1,
             data = filtered_tree_dat) + 
  labs(title= 'All Tress') +
  theme(legend.position = "none",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) 

anim <- ggmap::ggmap(base_map) +
  geom_point(aes(x = longitude,
                 y = latitude,
                 group = seq_along(year)),
             alpha = 0.25,
             size = 0.1,
             color = 'forestgreen',
             data = filtered_tree_dat) +
  labs(title = 'Year: {frame_along}') +
  transition_reveal(year) +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

