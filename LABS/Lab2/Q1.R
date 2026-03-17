library(tibble)
library(tidyverse)


# Question 1
song_length <- c(270586, 198324, 205946, 175163, 226088, 214613, 227527, 202133, 174000, 257213, 164818, 195013, 212000, 214416, 238805, 153000, 185600, 213718, 185855, 143901, 152137, 165772, 169237, 173182, 261818, 207065, 161840, 221693, 193279, 187111, 189560, 172626, 206772, 193346, 207853, 184893, 173381, 161853, 216764, 188918, 231832, 212878, 210560, 224773, 167480, 178147, 214405, 175344, 133613, 173549, 216120, 168873, 179426, 2e+05, 254181, 174680, 206385, 202226, 153190, 258799, 215281, 179720, 168601, 263288, 162680, 165760, 278440, 185422, 225148, 193506, 225664, 160656, 136266, 256000, 194050, 224694, 145800, 213493, 231041)
length(song_length)
min(song_length)
max(song_length)
sum(song_length)


# Question 2
song_popularity <- c(75, 93, 72, 81, 75, 83, 92, 86, 89, 74, 97, 92, 85, 77, 96, 67, 74, 93, 85, 95, 80, 85, 81, 73, 89, 84, 75, 91, 92, 70, 85, 71, 89, 87, 87, 87, 83, 98, 85, 33, 74, 85, 96, 83, 59, 76, 67, 74, 77, 91, 76, 71, 90, 88, 83, 95, 93, 95, 75, 87, 96, 79, 83, 86, 76, 70, 90, 87, 96, 82, 89, 100)
length(song_popularity[45:56])
min(song_popularity[45:56])
max(song_popularity[45:56])
sum(song_popularity[45:56])


# Question 3
song_popularity <- c(87, 96, 85, 89, 81, 86, 59, 67, 85, 75, 72, 95, 87, 90, 96, 85, 76, 92, 83, 89, 71, 80, 74, 90, 91, 82, 74, 33, 75, 89, 90, 85, 92, 67, 92, 95, 74, 75, 93, 92, 92, 70, 63, 83, 83, 68, 83, 74, 85, 76, 88, 91, 83, 70, 96, 76, 96, 73, 87, 100, 67, 94, 88, 96)
sum(song_popularity) / 8
sum(song_popularity) * 10
sum(song_popularity - 4) 
sum(song_popularity + 2)


# Question 4
song_length <- c(254181, 157890, 193279, 186173, 2e+05, 153190, 187943, 176146, 141805, 207065, 221693, 173381, 96825, 153000, 168873, 175163, 193506, 186538, 160239, 226088, 278440, 224694, 203807, 224773, 195013, 263288, 189560, 164818, 165760, 227527, 216120, 136266, 173549, 160656, 193346, 143901, 184893, 215281, 136760, 185422, 185600, 187111, 198324, 162680, 197442, 205946, 261818, 186677, 202735, 231832, 174000, 212878, 161266, 152137, 214416, 231041, 212000, 225148, 191013, 213493, 213718, 175344, 185680)
(((sum(song_length) / 1000) / 60) / 60) |> round(2)


# Question 5
song_title <- c("When I’m Gone (with Katy Perry)", "Heart On Fire", "If I Was a Cowboy", "Freaky Deaky", "Nail Tech", "Boyfriend", "THATS WHAT I WANT", "What Else Can I Do?", "The Motto", "love nwantiti (ah ah ah)", "P power (feat. Drake)", "City of Gods", "The Joker And The Queen (feat. Taylor Swift)", "Beautiful Lies", "Waiting On A Miracle", "Bussin", "Banking On Me", "Still D.R.E.", "Sacrifice", "MAMIII", "To Be Loved By You", "Peru", "Levitating", "Never Wanted To Be That Girl", "Meet Me At Our Spot", "Enemy (with JID) - from the series Arcane League of Legends", "Oh My God")
charCounts <- nchar(song_title)
min(charCounts)
charCounts[22]
sum(charCounts)
max(charCounts)


# Question 6
# This is based in canvas


# Question 7
song_title <- c("Smokin Out The Window", "Meet Me At Our Spot", "Boyfriend", "I Hate YoungBoy", "Pressure", "Broadway Girls (feat. Morgan Wallen)", "The Family Madrigal")
song_popularity <- c(85, 90, 94, 70, 73, 85, 90)
song_length <- c(197442, 162680, 153000, 261818, 193279, 185600, 257213)
tibble(song_title, song_popularity, song_length)


# Question 8
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS7R6DHE_92iP3XMxWScK4fuHfomugS3IKXz4SEDhPi_8kwhUyqJTKAKm1byjHCEKRVnh-Y2mTG9RkH/pub?gid=128990764&single=true&output=csv")
song_data %>% View()


# Question 9
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS7R6DHE_92iP3XMxWScK4fuHfomugS3IKXz4SEDhPi_8kwhUyqJTKAKm1byjHCEKRVnh-Y2mTG9RkH/pub?gid=1686121875&single=true&output=csv")
#song_data |> view()
#max(song_data[3])
max(song_data[,3])
song_data[2,1]; nchar(song_data[2,1])
sum(song_data[, 2]*200)
min(song_data[,2])
