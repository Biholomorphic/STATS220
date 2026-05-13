library(tidyverse)


# Question One, using names to extract the names of the columns
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=2074032693&single=true&output=csv")
names(song_data)[4] # Returns the var name of the fourth column


# Question Two, 
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=1567466879&single=true&output=csv")
spec(song_data)    # Spec returns the data type in each column
glimpse(song_data) # Returns much more information than spec


# Question Three,
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=39175924&single=true&output=csv")
names(song_data) # Find which is called a certain name
song_data %>%
  rename(new_name = 5)


# Question Four, Using slice() to create specified table
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=599797011&single=true&output=csv")
song_data %>%
  slice(5:6)


# Question Five
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=2133150618&single=true&output=csv")
song_data |>
  select(duration_ms, tempo)



# Quesiton Six
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=997193167&single=true&output=csv")
song_data |>
  ggplot() +
  geom_bar(aes(x = danceability)) # Don't forget aes(x=...)



# Question 7 
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=844794252&single=true&output=csv")
song_data |>
  ggplot() +
  geom_bar(aes(x = track_name), fill = "#aecdd2")


# Question 8
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=367178289&single=true&output=csv")
song_data |>
  ggplot() +
  geom_bar(aes(x = energy))


# Question 9
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=424581954&single=true&output=csv")
song_data |>
  ggplot() +
  geom_bar(aes(x = popularity)) +
  labs(caption = "STATS 220 is awesome")


# Question 10
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=1307623581&single=true&output=csv")
song_data |>
  ggplot() +
  geom_bar(aes(x = popularity, fill = artist_name))
