/*
  ---------------------

  Configuration

  ---------------------
*/

//#import "@preview/cetz:0.4.2"
//#import "@preview/cetz-plot:0.1.3"
#import "Typst-Supporting-Docs/UoAHeader.typ": *

#show: setup.with(
  title: "STATS 210 - Assignment 1",
  sub-title: none,
  title-page: false,
  table-of-contents: false,
  logo: none,
)

//#let newquestion = [#pagebreak() #line(length: 100%, stroke: black + 1pt) ]
#let evaluated(expr, size: 100%) = $lr(#expr|, size: #size)$

#set math.mat(delim: "[")
#set math.vec(delim: "[")
#set par(leading: 1em, first-line-indent: 0em)

#set text(font: "New Computer Modern Math", size: 12pt)
#show math.equation: set text(font: "New Computer Modern Math")
#show table.cell.where(y: 0): set text(weight: "regular")
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 4pt,
  radius: 4pt,
)

#let vecrep(body) = [$limits(#text(weight: "bold")[#body])^harpoon$]

/*
  ---------------------

  Work

  ---------------------
*/

= Notes for Mid Semester

My note sheet for the mid-semester of STATS 220.

== Notes for Module 1 Part A:

=== Markdown

- \# for headers. Three levels.
- `**text**` will render as bold.
- `*text*` will render italics.
- \`text\` is inline `code block`.
- Numbered lists are just `1.` and `2.` on new line.
- Unordered lists are `\* text`
- Links are done with `[Presenting Name](Link to website, no quotes)`
- Images are `![Name of image](path to image, no quotes)`
- code fences, tripple backtick, \`\`\` to open and close essentially a multiline code block.

#pagebreak()
=== Magick and Magick functions
Use:

```
library(magick)
```
to load in Rstudio

- `image_read(path = "PathToImage")`
- `image_blank(width = 500, height = 500, color = "#000000"` creates 500x500 black box
- `image_annotate(image, text = "...", color = "#...", size = ..., font = "...")` usually the image is piped in using %>% or |>.
  - text = "...",
  - size = integer,
  - font = '...'
  - color = "\#...", some common colors work as = "red"
  - boxcolor = "\#...",
  - degrees = integer in degrees,
  - location = "+x+y",
  - gravity = "south", "southwest", "north" etc..
- `image_scale(image, pxWideToScaleTo)`, to be clear, the second argument is the desired output width in pixels
- `image_append(image_vector, stack = )` this function expects a vector of magick images as an argument.
  - stack = {FALSE, TRUE} false -> side-by-side, true -> on top of one another
example usage
```
image_A <- image_read(path = "...") |>
  image_scale(200)
image_B <- image_read(path = "...") |>
  image_scale(200) |>
    image_annotate(text = "Hello", gravity = "west")

images = c(image_A, image_B)

image_append(images)
```
== Notes for Module 1 Part B
