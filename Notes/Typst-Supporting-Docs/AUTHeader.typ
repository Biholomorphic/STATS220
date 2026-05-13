#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import fletcher.shapes

#import "@preview/cetz:0.3.4": canvas, draw, tree
#import draw: *

#import "@preview/callisto:0.2.2"

#let vars = json("vars.json")
#let setup(
  title: "",
  sub-title: none,
  title-page: false,
  name: vars.NAME,
  AUTID: vars.AUTID,
  AUTemail: vars.AUTEMAIL, 
  year: "2025",
  table-of-contents: false,
  logo: none,
  doc,
) = {
  set document(author: name, title: title)
  // Title Page
  let alpha = 60%
  let colourDegree = 140deg
  let saturationChange = 10
  let LuminanceChange = 10
  let backColourA = rgb("#A0B2A6")
  let backColourB = rgb("#CBBFBB")
  let backColourC = rgb("#61988E")

  let colourA = "#536271"
  let colourB = "#3E4C5E"
  let colourC = "#6A687A"

  let primary-colour = color.rgb(colourA)
  let secondary-colour = color.rgb(colourB+"CA")
  let tertiary-colour = color.rgb(colourC+"99")
  //let secondary-colour = color.mix(color.rgb(100%,100%,100%,alpha), primary-colour, space:rgb)
  if title-page == true {
    set page(
    paper: "a4",
    margin: (
      top: 5em,
      bottom: 3em,
      x: 4em,
    )
  )
    place(bottom+left, dx: -50%, dy: 40%,circle(radius: 300pt, fill:primary-colour))
    place(bottom + left, dx: 40%, dy: -5%, circle(radius: 150pt, fill:tertiary-colour))
    place(dx:-40%, circle(radius: 150pt, fill:tertiary-colour))
    place(right,dy:-40% , circle(radius: 300pt, fill: secondary-colour))

    v(2fr)
    align(center, text(4em, weight: 700, title))
    v(1.2em, weak: true)
    if sub-title != none {
      align(center, text(2em, weight: 700, sub-title))
    }
    align(center, text(2em, year))

    v(2fr)
    if logo != none {
      logo = image(width: 6cm ,logo)
      place(top+right, logo)
    }
    pagebreak()
    counter(page).update(1)

  }// end of title page
  //set text(fill: rgb(colourB))

  set page(
    paper: "a4",
    header: {
      [
      #title
      #h(1fr)
      Email: #AUTemail\
      ID: #AUTID
      #h(1fr)
      Name: #eval(name, mode: "markup")
      
      ]
      },
    numbering: "- 1 of 1 -",
    margin: (
      top: 5em,
      bottom: 3em,
      x: 4em,
    )
  )

if table-of-contents{
  outline(title: "Table of Contents")
  pagebreak()
}
set heading(numbering: "1.a")
show heading.where(level: 1): it => block(width:100%)[
  #set align(center)
  #set text(size:16pt,weight: "regular", fill: rgb(colourA))
  \~ #(smallcaps(it.body)) \~]
show heading.where(level: 2): it => [
  #set align(left)
  #set text(size:14pt, weight: "regular", fill: rgb(colourB))
  #set par(first-line-indent: 0em)
  #(it.body)
  #v(.65em, weak: true)
]
show heading.where(level: 3): it => [
  #set align(left)
  #set text(size:12.5pt, weight: "regular", fill: rgb(colourC))
  #set par(first-line-indent: 0em)
  #emph(it.body)
  #v(.65em, weak: true)
]
show outline.entry.where(
  level: 1
): set block(above: 1.2em)
set list(indent: 1em, marker: ([•],[∘]))
set enum(indent: 1em, numbering: "1.a.")
set par(
  justify: true,
  first-line-indent: 1em,
)
set terms(separator: [:#h(0.6em, weak:true)])
show math.equation: set text(font:"Cambria Math")
show table.cell.where(y:0): set text(style: "normal", weight: "bold")
doc
}