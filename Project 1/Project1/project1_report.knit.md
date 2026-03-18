---
title: "Creating images with R"
subtitle: "Git meme using the 'Disaster Girl' template"
author: "Marlo Thacker"
output: html_document
---




``` css
body {
    font-family: 'JetBrains Mono Nerd Font Mono', monospace;
    background-color: #EFD2B0;
    color: #3d3d3d;
    line-height: 1.4;
    font-size: 11pt;
}

p {
    margin-bottom: 1.5em;
}

h1 {
    font-family: 'JetBrains Mono Nerd Font Mono', monospace;
    text-align: center;
    text-decoration: underline;
}

h2 {
    font-family: 'JetBrains Mono Nerd Font Mono', monospace;
    font-size: 16pt;
    text-decoration: underline;
}

pre {
    background-color: #edd9c2;
    padding: 10px;
    border: 4px solid #444;
    border-radius: 10px;
}

img {
    border: 4px solid #444;
    border-radius: 10px;
}
```


<style type="text/css">
body {
    font-family: 'JetBrains Mono Nerd Font Mono', monospace;
    background-color: #EFD2B0;
    color: #3d3d3d;
    line-height: 1.4;
    font-size: 11pt;
}

p {
    margin-bottom: 1.5em;
}

h1 {
    font-family: 'JetBrains Mono Nerd Font Mono', monospace;
    text-align: center;
    text-decoration: underline;
}

h2 {
    font-family: 'JetBrains Mono Nerd Font Mono', monospace;
    font-size: 16pt;
    text-decoration: underline;
}

pre {
    background-color: #edd9c2;
    padding: 10px;
    border: 4px solid #444;
    border-radius: 10px;
}

img {
    border: 4px solid #444;
    border-radius: 10px;
}
</style>

## Project requirements


## Inspo meme
![](inspo.jpg)
I think the two main elements of this are definitely the expression on the girls face, and the background. I think that the expression on the girls face (regardless of what actually happened in the real image) portrays a sense of smugness, as though she is in part responsible for the chaos in the  background.

## My meme
![](my_meme.jpg)
For my static meme pretty much all I changed was the joke displayed on it. I simply changed the text on it to be a different joke, but I still wanted it to be within the same genre of joke. I put most of my effort into trying to be a technical and more creative on the gif rather than the meme since thats what I was more interested in.


## My animated meme 
![](my_animated_meme.gif)

## Creativity

I think that my project displays creativity through its multi-part animation sequence involving multiple differing possible styles of animation, rather than looping a static image with minor changes each time I chose to gradually control tints, fade ins, and image manipulation using values distributed across ranges and functional loops.

Additionally, I believe that as a part of my gradual control approach I had to come up with ideas on how to control this as much of my code to my knowledge doesn't have built in functionality for the type of control I was going for, I knew I would likely have to control opacity as I have done that trick before elsewhere but the implementation took some time and thinking to get right.

Moreover, during the creation of the gif, I sourced and composited two images over the original, using the `Screen` operator to blend them together. I also utilized a dynamic approach to controlling the dimensions of the fire overlay such that it responds to the base image dimensions, meaning that *hopefully* it will adjust it's width to match the base layer.

Overall I think that my code demonstrates creativity both through the technical aspect of making my ideas come to fruition but also through my approach to deciding what I wanted to happen on the gif, and while I don't think it's exactly the funniest meme or joke I've made I believe that my technical implementation should fulfil the creativity facet of this project.

## Learning reflection
<!--  
I think the learning for this project was kind of situational, I doubt I could apply most of what I learned to another project without thinking about it for some time first, I'm happy with what I've made here but I don't feel like the learning has been reinforced yet.

So far my eyes have been opened a little into how reproducible some of this stuff is, I don't think I ever really considered html as something that was this easy to create, style and embed text and images into, I had never really considered that something like R markdown would have this kind of capabilities.
-->

I think that the learning I've done for this project was very situational, I don't think that I learned with any particular depth about what I've used in this project. However, I do think that it served an important purpose for deep exposure into many of the functions and abilities of both R and the magick package, and I believe that it will definitely serve me well if I do anything in the future as I believe that all sorts of exposure help with some sorts greater than others but helping overall.

Probably what I've found most interesting right now is definitely the pipeline in R markdown. I like how I can create HTML with it that uses css for some styling, something I would've liked would be some experience using an external css document and linking that in here instead but I understand the idea of streamlining the project idea to simplify it.

Something I enjoyed was learning the specific technical implementations of how to kind of loop to create a set of images that differed opacity or position (when using the image_composite() function). 

## Appendix

<mark>Do not change, edit, or remove the `R` chunk included below.</mark> 

If you are working within RStudio and within your Project1 RStudio project (check the top right-hand corner says "Project1"), then the code from the `meme.R` script will be displayed below.

This code needs to be visible for your project to be marked appropriately, as some of the criteria are based on this code being submitted.



``` r
# Standard stuff to clear stuff
rm(list = ls(all.names = TRUE)); gc(); if (!is.null(dev.list())) dev.off()

library(magick)

memeBase <- image_read("https://upload.wikimedia.org/wikipedia/en/1/11/Disaster_Girl.jpg")
upperText = "Been working on main branch\n the whole time"; lowerText = "Who needs branches?"

# ----- Part D: Static Meme ----------------------------------

Meme <- memeBase |>
  
  image_scale("250%") |>                                   # Scaling because text appears really blurry without it
  
  image_annotate(
    text = upperText,
    gravity = "north",
    size = "60",
    font = "JetBrainsMono Nerd Font Mono",
    color = "white",
    strokecolor = "black",
    strokewidth = "1.5"                                    # Size of black outline for text
  ) |>
  
  image_annotate(
    text = lowerText,
    gravity = "south",
    size = "60",
    font = "JetBrainsMono Nerd Font Mono",
    color = "white",
    strokecolor = "black",
    strokewidth = "1.5"
  )

Meme |> image_write("my_meme.jpg")

# ----- Part E: Animated Meme --------------------------------

# Part 1: Static image with nothing displayed on it
# Part 2: Top text fades in
# Part 3: Bottom text now fades in
# Part 4: Orange tint on whole image
# Part 5: Ideally it would be cool to have a fire png overlay over and rise over the image, idk if thats feasable rn though - turns out this was actually not too hard
# Part 6: Big boom

gifBase <- memeBase |> image_scale("250%")
framesPerSecond = 30

# ---------- PART ONE ---------- 

staticImg <- gifBase

# ---------- PART TWO ----------

alphaSteps <- toupper(sprintf("%02x", round(seq(0, 255, length.out = framesPerSecond))))

upperTextFadeIn <- lapply(alphaSteps, function(a) {
  gifBase |>
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
  gifBase |>
    image_annotate(
      text = upperText,
      gravity = "north",
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = "white",
      strokecolor = "black",
      strokewidth = 1.5
    ) |>
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
  gifBase |>
    image_colorize(
      opacity = o,                                         # controls tint strength this time
      color = "#FFA500"
    ) |>
    image_annotate(
      text = upperText,
      gravity = "north",
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = "white",
      strokecolor = "black",
      strokewidth = 1.5
    ) |>
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

fire <- image_read("Assets/Fire.png") |> image_scale(paste0(image_info(gifBase)$width, "x"))       # Scale to match width otherwise would look very silly

riseSteps <- seq(image_info(gifBase)$height, 200, length.out = (framesPerSecond + framesPerSecond/2))                # For shifting the frame up

fireRiseUp <- lapply(riseSteps, function(yOffset) {
  gifBase |>
    image_colorize(opacity = 40, color = "#FFA500") |>
    
    image_composite(fire, operator = "Screen", offset = paste0("+0+", round(yOffset))) |>
    
    image_annotate(
      text = upperText, 
      gravity = "north", 
      size = 60,
      font = "JetBrainsMono Nerd Font Mono",
      color = "white", 
      strokecolor = "black", 
      strokewidth = 1.5
    ) |>
      
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

explosion <- image_read("Assets/explosion.png")

houseExplosion <- gifBase |>
  image_composite(explosion, operator = "Screen", offset = "-400-170") |>
  
  image_colorize(opacity = 40, color = "#FFA500") |>
  
  image_composite(fire, operator = "Screen", offset = "+0+200") |>
  
  image_annotate(
    text = upperText, 
    gravity = "north", 
    size = 60,
    font = "JetBrainsMono Nerd Font Mono",
    color = "white", 
    strokecolor = "black", 
    strokewidth = 1.5
  ) |>
  
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
animation <- frames |>
  image_animate(fps = 25, loop = 0)

# Save the thing
animation |> image_write("my_animated_meme.gif")

# Compile time for saving gif was ages so print done for my own convenience
print("Done")
```

