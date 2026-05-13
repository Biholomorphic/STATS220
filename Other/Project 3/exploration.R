library(tidyverse)
library(httr)
library(magick)

# Actual API key is stored in my user level '.Renviron' file and stored
# in the 'MY_PEXELS_API' variable there. Done with the 'usethis' R pkg.
# I have done this because my repository for this class is public.
api_key <- Sys.getenv("MY_PEXELS_API")

url <- "https://api.pexels.com/v1/search?query=fresh%20bread&per_page=80"

response <- httr::GET(url, 
                      add_headers(Authorization = api_key))

data <- httr::content(response,
                      as = "parsed", 
                      type = "application/json")

photo_data <- tibble(photos = data$photos) %>%
  unnest_wider(photos) %>%
  unnest_wider(src)

# Added in so that I could view all the columns available
write_csv(photo_data, "photo_data.csv")


selected_photos <- photo_data |>
    mutate(
        # The code following this is designed to categorise the images into rough
        # portrait, landscape and square categories. Aspect ratio should give close
        # to a known ratio and I can select for that ratio if I want to.

        # Numeric
        aspect_ratio = width / height,

        # Categorical with three levels
        orientation = ifelse(aspect_ratio < 0.95, "portrait",
                             ifelse(aspect_ratio > 1.05, "landscape", "square")),

        # This is to find certain words mentioned in the descriptions of the images
        # the hope is that if a description mentions tomatoes the image will
        # contain tomatoes or tomato etc in the image itself.
        alt = tolower(alt),
        describes_bread = str_detect(alt, "crust|fresh|artisan|sourdough|homemade"),
        mentions_side = str_detect(alt, "cheese|tomato|grape|cracker|herb"),
        mentions_setting = str_detect(alt, "rustic|wood|basket|board|traditional"),

        # This will contain selection for the resolution of the image. 
        # Also numeric.
        resolution = height * width,
        

        ) |>
    filter(
        orientation == "portrait",
        describes_bread,
        # mentions_side, # Ends up being redundant as mentions of this have the mentions_setting in common
        mentions_setting
    )

dim(selected_photos)
write_csv(selected_photos, "selected_photos.csv")

# ── Part D ─────────────────────────────────────────────────────

# Bunch o' things
mean_resolution <- selected_photos$resolution |> mean(na.rm = TRUE)
median_aspect_ratio <- selected_photos$aspect_ratio |> median(na.rm = TRUE)
count_setting <- sum(selected_photos$mentions_setting)
mean_of_describes_bread <- mean(selected_photos$describes_bread)


# Grouping with the 'Bunch o' things'
grouped_photos <- selected_photos |>
  group_by(mentions_side) |>
  summarise(
    mean_resolution = mean(resolution, na.rm = TRUE),
    mean_aspect_ratio = mean(aspect_ratio, na.rm = TRUE),
    count = n()
  )

mean_res_with_side <- grouped_photos$mean_resolution[grouped_photos$mentions_side == TRUE]
mean_res_without_side <- grouped_photos$mean_resolution[grouped_photos$mentions_side == FALSE]




# ── Part E: Creativity ─────────────────────────────────────────────────────

# Creates an animated meme GIF comparing fresh bread to a key.
# Each frame cycles through a different bread photo on the left,
# with a static key image on the right, and ">" overlaid between them.
# The goal is to reference the bread > key meme that circulated some
# 1 - 1.5 years ago.

# Function to download a bread image from a URL and add a styled caption
make_frame <- function(url, caption) {
  image_read(url) |>
    image_resize("800x800^") |>
    image_crop("800x800+0+0") |>
    image_annotate(
      caption,
      gravity = "South",
      location = "+0+15",
      size = 22,
      font = "Georgia",
      color = "white",
      boxcolor = "#00000088",
      weight = 700
    )
}

# Function to combine a bread frame with the key image side by side
# and overlay the ">" symbol in the centre to create the meme format
make_meme_frame <- function(bread_frame) {
  combined <- image_append(c(bread_frame, key_frame), stack = FALSE)
  image_annotate(
    combined,
    ">",
    gravity = "West",
    location = "+760+0",  # 760px from left edge, centred on the boundary at x=800
    size = 80,
    color = "white",
    boxcolor = "#00000099",
    weight = 700,
    font = "Georgia"
  )
}

# Use 10 photos to keep the GIF file size reasonable
gif_photos <- selected_photos |>
  slice_head(n = 10)

# Truncate alt text to keep captions tidy within the frame
captions <- gif_photos$alt |>
  str_trunc(45, ellipsis = "...")

# Read and process the key image — narrower than bread to emphasise
# that bread takes up more visual space, reinforcing the "bread > key" message
key_frame <- image_read("key.jpg") |>
  image_resize("400x800^") |>
  image_crop("400x800+0+0") |>
  image_annotate(
    "key",
    gravity = "South",
    location = "+0+15",
    size = 22,
    font = "Georgia",
    color = "white",
    boxcolor = "#00000088",
    weight = 700
  )

# Build bread frames from the small image URLs and alt text captions
bread_frames <- map2(gif_photos$small, captions, make_frame)

# Combine each bread frame with the key image to create meme frames
meme_frames <- map(bread_frames, make_meme_frame)

# Animate at 2fps (factor of 100) and write to file
animation <- image_join(meme_frames) |>
  image_animate(fps = 2, optimize = TRUE)

image_write(animation, "creativity.gif")