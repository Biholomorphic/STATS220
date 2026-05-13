# Project Three

### Part A Querying photos via the pexels website
- The search words I used were "Fresh Bread"
- Screenshot saved under assets
- Things I noticed:
    - The majority of images were framed horizontally, but featured aspect ratios more akin to 4:3 over a wider horizontal frame. 
    - Commonly, the images were paired with small tomatoes and cheese. 
    - I also observed wheat grain, herbs, and grapes all paired with the bread in the foreground. 
    - There was one photo set that popped up regularly with a basket of eggs in the background (photo shoot session?) and bread, with guest appearances from tomatoes and oats(? why...).
    - Commonly rustic-esque backgrounds (I don't know themes so idek if this is the correct word).
    - Most images don't have many likes, I checked about 30 images by hand and only 5 or so had above a 10 like count, a large portion was under 5 likes and a handful were in the 5 - 10 like range. 
    - Views for these hovered in the tens of thousands typically, usually less than 40 thousand. An outlier I spotted had ~300,000 views and 9 likes (how? It wasn't even good...)
    - A lot of wooden boards and bread baskets.

### Part B: Getting an API key from Pexels
- [x] API key: VZu2wlJiqRCAO6IdLIIlNwbvz9nyq9cvXXK1lYVJlrqL164qrwGgawQk

### Part C: Exploring and manipulating data from the Pexels API
- [x] Add in my API key from part B to to given code on canvas.
- [x] Change query to my search words from A.
- [x] Change it to return 80 images.
- [x] Create selected_photos data frame
	- [x] Demonstrate use of the `mutate()` function to create **three NEW variables**, of which one needs to be categorical with no more than four levels (i.e. two, three or four levels).
	- [x] Ensure that `selected_photos` has both numeric and character variables.
	- [x] Demonstrate use of the `filter()` function to select only around 20 of the photos, based on at least one condition.
	- [x] Write comments on whatever I add in
- [x] After you have created `selected_photos`, save the data frame `selected_photos`as a CSV file to your project folder, using `write_csv(selected_photos, "selected_photos.csv")`

### Part D: Summarising data about your selected photos 
 - [ ] Continue on the "exploration.R" script, but now focus on calculating **at least three** different summary values for different variables within your data frame, `selected_photos`.
	- You need to create named objects for each of these summary values e.g., `mean_likes <- selected_photos$likes |> mean(na.rm = True)` 
- [ ] Use the functions `group_by()` and `summarise()` to calculate summary values for one of your numeric variables that can be compared across different levels of your grouping (categorical) variable.
	- You need to create a named object for **at least one** of these summary values e.g., `mean_likes_kittens <- grouped_photo$mean_likes[1]`.
### Part E: Creativity
- [x] Continue working in your “exploration.R” script, but now focus on use your knowledge from Modules 1 and 2 to create an image (meme or animated GIF) with the photos in your `selected_photos` data frame, using the variable `small` (or one of the other variables that contains a direct URL to the photo).
	- Your final image (meme or animated GIF) needs to include text.
	- You need to save this image to your project folder with the name `creativity.png` OR `creativity.gif` (depending on whether you created a meme or an animated GIF) using the `image_write()` {magick} function.
	- You need to demonstrate more creativity than just copying the examples covered in the notes or lectures.
### Part F: Writing a project report
- [x] Create a new Rmd file within your _Project3_ folder called “project3_report.Rmd”.
- [x] Make the title “Project 3” and put your name as the author.
- [x] Edit the YAML of the project3_report.Rmd file so that:
	- the subtitle is “STATS 220 Semester One 2026”.
	- code is folded.
- [x] For the **r setup** chunk:
	- use the following settings `knitr::opts_chunk$set(echo=TRUE, message=FALSE, warning=FALSE, error=FALSE)`
	- load **ONLY** the tidyverse library using `library(tidyverse)`
	- read in the data stored in your `selected_photos.csv` file into a data frame named `selected_photos`
- [x] If you are using a CSS chunk:
	- Use `{css echo=FALSE}` to setup the CSS chunk.
	- Ensure that the CSS you use does not inhibit the readability of your project report.
- [ ] Structure the report (the project3_report.Rmd file) using second-level headings as follows:
	- Introduction
	- Key features of my selected photos
	- Creativity
	- Learning reflection
	- Appendix