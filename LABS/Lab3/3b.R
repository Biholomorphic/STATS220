library(dplyr)
library(tidyr)
library(jsonlite)
library(stringr)

song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab3b_json20.json")

question_1 <- song_data[35, "track_name"]
question_1

question_2 <- song_data |>
  pull(duration_ms)
length(question_2)

question_3 <- median(question_2)
question_3

question_4 <- song_data |>
  pull(track_popularity)
length(unique(question_4))

question_5 <- song_data |>
  separate_rows(artist_name, sep = ",") |>
  mutate(artist_name = str_trim(artist_name)) |>
  distinct(artist_name)
nrow(question_5)

