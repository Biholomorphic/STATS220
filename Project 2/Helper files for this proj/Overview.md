# Project 2 — STATS 220

**Due:** Wednesday 22:00 | **Points:** 10 | **Submit:** `.html` file

---

## Prep Work

- Install [R](https://www.r-project.org/) and [RStudio](https://posit.co/products/open-source/rstudio/) (or use [Posit Cloud](https://posit.cloud/))
- Have `{tidyverse}` installed from Project 1

---

## Recommended Timeline

- **After 2A lectures/lab:** Complete Parts A, B, C
- **After 2B lectures/lab:** Complete Parts D & E
- **After A–E:** Complete Part F

---

## Group Work (Optional)

- Max group size: **5**
- Parts A & B may be done as a group
- Parts C, D, E must be **individual**
- Final submission is **individual**

---

## Part A: Form Design

- [x] Choose an **observational logging focus** (something you can observe 20+ times over ~2 weeks)
- [x] Design a Google Form with **at least 3 questions**:
  - [x] Follows the 4 form design guidelines
  - [x] At least one **numeric** question (short answer + response validation)
  - [x] At least one **categorical** question (multiple choice)
  - [x] Appropriate text, visual, and structural elements
  - [x] Responses are **anonymous**
- [x] Change settings so form is **not restricted** to University of Auckland users

---

## Part B: Data Collection

- [x] Publish form — set responders to **"Anyone with the link"**
- [x] Generate and save the responder link (phone home screen or browser bookmark)
- [x] Collect at least **20 observations** over several days (ideally 1+ week)
- [x] Link form to a new **Google Sheet**
- [x] Publish Google Sheet as **CSV** and record the URL
- [x] Keep form **open** at submission (marker will fill it in)

---

## Part C: Importing Data into R

- [x] Create a new RStudio project/folder called `Project2` inside your `stats220` folder
- [x] Create a new R script called `exploration.R`
- [x] Load `{tidyverse}`
- [x] Use `read_csv()` to read data from the published CSV URL into a data frame called `logged_data`

---

## Part D: Exploring Data in R

- [x] Rename variables using `rename()` → save as `latest_data`
- [x] Identify at least **2 summary values** (min, max, mean, length, etc.)
- [x] Create at least **2 informative bar charts**
- [x] Show exploration of different options (not just final versions)
- [x] Use comments, indenting, and white space in code
- [x] End with a **commented section** containing final chosen code for the report

---

## Part E: Creating a Dynamic Report

- [x] Download `dynamic_report.Rmd` and save to `Project2` folder
  - Do **not** change the YAML
  - Output is `html_fragment` — do not change
- [x] Update the level 2 heading to describe what you're tracking
- [x] Add markdown text explaining your data and analysis
- [x] Copy relevant code from `exploration.R`
- [x] Include setup chunk:
````r
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo=FALSE, message=FALSE, warning=FALSE, error=FALSE)
```
````

- [ ] Report includes:
  - [x] At least **2 bar charts**
  - [x] **Dynamic comments** based on at least 2 summary values (use `paste()`, `paste0()`, or inline R)
- [x] Add any desired CSS
- [x] Knit to HTML to preview
- [x] Set up **GitHub Pages** for your `stats220` repo:
  - [x] Add `.nojekyll` file ⚠️ commonly missed
  - [x] Create `index.html` with the provided code (do not modify):
````html
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>Dynamic report</title>
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://cdn.opencpu.org/opencpu-0.4.js"></script>
<script src="https://stat.auckland.ac.nz/~fergusson/web_rmd/web_rmd.js"></script>
</head>
<body style='margin:0'>
<div id="output"></div>
</body>
</html>
````

- [x] Record your GitHub Pages URL (e.g. `https://username.github.io/stats220/`)
- [x] Test dynamic nature by submitting more form responses

---

## Part F: Project Report

- [x] Create `project2_report.Rmd` in your `Project2` folder
- [x] Title: `Project 2` | Author: your name
- [x] YAML: subtitle `"STATS 220 Semester One, 2026"`, code folded

### Sections

#### Introduction *(200+ words)*
- [x] Describe your data collection focus
- [x] Discuss one form design guideline and how you applied it
- [x] Explain what you can learn from analyzing the data
- [x] Include Markdown link to your Google Form
- [x] State group/solo work:
  - Group: *"Form design and data collection for this project were completed as a group. My group members were ..."*
  - Solo: *"Form design and data collection for this project were completed by me."*

#### Dynamic Report
- [x] Include Markdown link to your GitHub Pages dynamic report

#### Creativity
- [x] Describe and justify how your project demonstrates creativity (going beyond requirements in a way that improves the product)

#### Learning Reflection *(100+ words)*
- [x] Describe at least **one important idea** learned from Module 2
- [x] Discuss what data technologies you're curious to explore further
- [x] Comment on group work:
  - No group: describe one way you have/will develop group work skills (1–2 sentences)
  - Group: describe one thing learned about effective collaboration (1–2 sentences)

#### Appendix
- [x] Include exactly:
````R
```{r file='exploration.R', eval=FALSE, echo=TRUE}
```
```{r file='dynamic_report.Rmd', eval=FALSE, echo=TRUE}
```
````
- [x] Knit your _project2_report.Rmd_ file to create a self-contained _project2_report.html_ file.