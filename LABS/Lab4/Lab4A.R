library(tidyverse)
library(jsonlite)

# Question 1
song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

summarised_data <- song_data %>%
    mutate(song_speed = ifelse(tempo > 120, 'fast', 'slow')) %>%
    group_by(song_speed) %>%
    summarise(n = n())

ggplot(data = summarised_data) +
    geom_col(aes(x = song_speed, y = n, fill = song_speed)) +
    labs(title = 'Comparing the speed of songs', x = 'Speed of song based on tempo', y = 'Number of songs')

# Question 2
song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

summarise_data <- song_data %>%
    mutate(valence_group = case_when(
      valence < 0.33 ~ 'sad',
      valence < 0.67 ~ 'OK',
      TRUE ~ 'happy')) %>%
    group_by(mode_name, valence_group) %>%
    summarise(mean_tempo = mean(tempo, na.rm = TRUE))

summarise_data %>%
    ggplot() +
    geom_point(aes(x = mean_tempo, y = mode_name, colour = valence_group),
      size = 5)
