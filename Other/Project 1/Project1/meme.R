# Standard stuff to clear stuff
rm(list = ls(all.names = TRUE)); gc(); if (!is.null(dev.list())) dev.off()

library(magick)

memeBase <- image_read("Disaster_Girl.jpg")
upperText = "Been working on main branch\n the whole time"; lowerText = "Who needs branches?"

# ----- Part D: Static Meme ----------------------------------

Meme <- memeBase %>%
  
  image_scale("250%") %>%                                   # Scaling because text appears really blurry without it
  
  image_annotate(
    text = upperText,
    gravity = "north",
    size = "60",
    font = "JetBrainsMono Nerd Font Mono",
    color = "white",
    strokecolor = "black",
    strokewidth = "1.5"                                    # Size of black outline for text
  ) %>%
  
  image_annotate(
    text = lowerText,
    gravity = "south",
    size = "60",
    font = "JetBrainsMono Nerd Font Mono",
    color = "white",
    strokecolor = "black",
    strokewidth = "1.5"
  )

Meme %>% image_write("my_meme.jpg")

# ----- Part E: Animated Meme --------------------------------

# Part 1: Static image with nothing displayed on it
# Part 2: Top text fades in
# Part 3: Bottom text now fades in
# Part 4: Orange tint on whole image
# Part 5: Ideally it would be cool to have a fire png overlay over and rise over the image, idk if thats feasable rn though - turns out this was actually not too hard
# Part 6: Big boom

gifBase <- memeBase %>% image_scale("250%")
framesPerSecond = 30

# ---------- PART ONE ---------- 

staticImg <- gifBase

# ---------- PART TWO ----------

alphaSteps <- toupper(sprintf("%02x", round(seq(0, 255, length.out = framesPerSecond))))

upperTextFadeIn <- lapply(alphaSteps, function(a) {
  gifBase %>%
    image_annotate(
      text = upperText,
      gravity = "north",
      size = "60",
      font = "JetBrainsMono Nerd Font Mono",
      color = paste0("#FFFFFF", a),                        # Faking fade in by controlling opacity
      strokecolor = paste0("#000000", a),                  # Border of text also fades in at same rate
      strokewidth = "1.5"
    )
})

# ---------- PART THREE ---------

lowerTextFadeIn <- lapply(alphaSteps, function(a) {
  gifBase %>%
    image_annotate(
      text = upperText,
      gravity = "north",
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = "white",
      strokecolor = "black",
      strokewidth = 1.5
    ) %>%
    image_annotate(
      text = lowerText,
      gravity = "south",
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = paste0("#FF0000", a),                        # Controls opacity in same manner as above
      strokecolor = paste0("#000000", a),
      strokewidth = 1.5
    )
})

# ---------- PART FOUR ----------

tintSteps <- seq(0, 40, length.out = framesPerSecond)

orangeTintFadeIn <- lapply(tintSteps, function(o) {
  gifBase %>%
    image_colorize(
      opacity = o,                                         # controls tint strength this time
      color = "#FFA500"
    ) %>%
    image_annotate(
      text = upperText,
      gravity = "north",
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = "white",
      strokecolor = "black",
      strokewidth = 1.5
    ) %>%
    image_annotate(
      text = lowerText,
      gravity = "south",
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = "red",
      strokecolor = "black",
      strokewidth = 1.5
    )
})

# ---------- PART FIVE ----------

fire <- image_read("Fire.png") %>% image_scale(paste0(image_info(gifBase)$width, "x"))       # Scale to match width otherwise would look very silly

riseSteps <- seq(image_info(gifBase)$height, 200, length.out = (framesPerSecond + framesPerSecond/2))                # For shifting the frame up

fireRiseUp <- lapply(riseSteps, function(yOffset) {
  gifBase %>%
    image_colorize(opacity = 40, color = "#FFA500") %>%
    
    image_composite(fire, operator = "Screen", offset = paste0("+0+", round(yOffset))) %>%
    
    image_annotate(
      text = upperText, 
      gravity = "north", 
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = "white", 
      strokecolor = "black", 
      strokewidth = 1.5
    ) %>%
      
    image_annotate(
        text = lowerText, 
        gravity = "south", 
        size = 60,
        font = "JetBrainsMono Nerd Font Mono",
        color = "red", 
        strokecolor = "black", 
        strokewidth = 1.5
    )
})

# ---------- PART SIX ----------

explosion <- image_read("explosion.png")

houseExplosion <- gifBase %>%
  image_composite(explosion, operator = "Screen", offset = "-400-170") %>%
  
  image_colorize(opacity = 40, color = "#FFA500") %>%
  
  image_composite(fire, operator = "Screen", offset = "+0+200") %>%
  
  image_annotate(
    text = upperText, 
    gravity = "north", 
    size = 60,
    font = "JetBrainsMono Nerd Font Mono",
    color = "white", 
    strokecolor = "black", 
    strokewidth = 1.5
  ) %>%
  
  image_annotate(
    text = lowerText, 
    gravity = "south", 
    size = 60,
    font = "JetBrainsMono Nerd Font Mono",
    color = "red", 
    strokecolor = "black", 
    strokewidth = 1.5
  )


# Combine frams
frames <- c(
  do.call(c, rep(list(staticImg), framesPerSecond)),       # Total frames = 5*framesPerSecond + framesPerSecond/2
  do.call(c, upperTextFadeIn),
  do.call(c, lowerTextFadeIn),
  do.call(c, orangeTintFadeIn),
  do.call(c, fireRiseUp),
  do.call(c, rep(list(houseExplosion), framesPerSecond))
)

# Animate at 25fps
animation <- frames %>%
  image_animate(fps = 25, loop = 0)

# Save the thing
animation %>% image_write("my_animated_meme.gif")

# Compile time for saving gif was ages so print done for my own convenience
print("Done")