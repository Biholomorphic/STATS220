# ------------------------------------------------------------
# STATS 220 – Project 4: Data Visualisation
# Energy Drink Observations across UoA and AUT Campus
# ------------------------------------------------------------

library(tidyverse)
library(lubridate)

# ── Load data ────────────────────────────────────────────────
logged_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRHaMrOqii2tFpTH9s4SEv7Wv1PNuF7fwck5SOM9F2pXzyNibgYcm4KyM9qoM3O0jDUcoFIKnN7K4gF/pub?output=csv")

# Rename columns to short, usable names
logged_data <- logged_data |>
  rename(
    timestamp        = 1,
    campus           = 2,
    building_number  = 3,
    building_name    = 4,
    obs_time         = 5,
    obs_date         = 6,
    quantity         = 7,
    brand            = 8
  )

# ── Colour palette (Color Brewer - https://colorbrewer2.org/?type=diverging&scheme=BrBG&n=9) ──
brand_colours <- c(
  "Monster"   = "#1B9E77",
  "Red Bull"  = "#D95F02",
  "V"         = "#7570B3",
  "Rockstar"  = "#E7298A",
  "Musashi"   = "#66A61E",
  "Live Plus" = "#E6AB02",
  "Celsius"   = "#A6761D"
)


campus_colours <- c("UoA" = "#1B9E77", "AUT" = "#D95F02") # Kinda Random

# ------------------------------------------------------------
# PLOT 1 – Bar chart: Total drinks observed per brand,
#          split by campus
# Data manipulation: group_by + summarise + mutate (reorder)
# ------------------------------------------------------------

brand_campus_summary <- logged_data |>
  group_by(brand, campus) |>
  summarise(total = sum(quantity), .groups = "drop") |>
  mutate(brand = fct_reorder(brand, total, .fun = sum))

plot1 <- ggplot(
  brand_campus_summary,
  aes(x = brand, y = total, fill = campus)
) +
  geom_col(position = "dodge", width = 0.7) +
  scale_fill_manual(
    values = campus_colours,
    name = "Campus"
  ) +
  coord_flip() +
  labs(
    title = "Total Energy Drinks Observed by Brand and Campus",
    subtitle = "Monster dominates at both UoA and AUT; V is popular at UoA",
    x = "Brand",
    y = "Total Drinks Observed",
    caption = "Data: Energy Drink Observations - UoA & AUT (March 2026)"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold"),
    plot.subtitle = element_text(colour = "grey40"),
    legend.position = "top"
  )

ggsave("plot1.png", plot = plot1, width = 8, height = 5, dpi = 150)

# ------------------------------------------------------------
# PLOT 2 – Lollipop chart: Proportion of observations where
#          quantity > 1, by brand (i.e., spotted in groups)
# Manipulation: filter, group_by, summarise, mutate, arrange
# ------------------------------------------------------------

brand_group_prop <- logged_data |>
  group_by(brand) |>
  summarise(
    n_obs      = n(),
    n_group    = sum(quantity > 1),
    prop_group = n_group / n_obs,
    .groups    = "drop"
  ) |>
  filter(n_obs >= 3) |> # keep brands with enough data
  arrange(desc(prop_group)) |>
  mutate(brand = fct_reorder(brand, prop_group))

plot2 <- ggplot(
  brand_group_prop,
  aes(x = prop_group, y = brand, colour = brand)
) +
  geom_segment(aes(x = 0, xend = prop_group, yend = brand),
    linewidth = 1.2, colour = "grey75"
  ) +
  geom_point(size = 5) +
  scale_colour_manual(values = brand_colours, guide = "none") +
  scale_x_continuous(
    labels = scales::percent_format(accuracy = 1),
    limits = c(0, 1)
  ) +
  labs(
    title    = "How Often Were Energy Drinks Spotted in Groups (Qty > 1)?",
    subtitle = "Proportion of observations where more than one drink of the same brand was seen",
    x        = "Proportion of Observations",
    y        = "Brand",
    caption  = "Brands with fewer than 3 observations excluded"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title    = element_text(face = "bold"),
    plot.subtitle = element_text(colour = "grey40")
  )

ggsave("plot2.png", plot = plot2, width = 8, height = 5, dpi = 150)

# ------------------------------------------------------------
# PLOT 3 – Histogram: Distribution of observation hour,
#          coloured by campus  (uses lubridate on user-inputted
#          obs_date + obs_time — data was recorded on notebooks
#          and entered into the form later, so the form timestamp
#          does not reflect when drinks were actually observed)
# Manipulation: mutate with paste, dmy_hms, hour
# ------------------------------------------------------------

time_data <- logged_data |>
  mutate(
    datetime = dmy_hms(paste(obs_date, obs_time)),
    hour     = hour(datetime)
  )

plot3 <- ggplot(time_data, aes(x = hour, fill = campus)) +
  geom_histogram(
    binwidth = 1, colour = "white", alpha = 0.85,
    position = "stack"
  ) +
  scale_fill_manual(values = campus_colours, name = "Campus") +
  scale_x_continuous(
    breaks = seq(8, 20, by = 2),
    labels = paste0(seq(8, 20, by = 2), ":00")
  ) +
  labs(
    title    = "When Were Energy Drinks Observed Throughout the Day?",
    subtitle = "Most sightings occur between 09:00–17:00; a lunchtime peak is visible",
    x        = "Hour of Day (form submission time)",
    y        = "Number of Observations",
    caption  = "Hour extracted from user-recorded observation time using {lubridate}"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold"),
    plot.subtitle = element_text(colour = "grey40"),
    legend.position = "top"
  )

ggsave("plot3.png", plot = plot3, width = 9, height = 5, dpi = 150)

# ------------------------------------------------------------
# PLOT 4 – Boxplot: Distribution of quantity observed,
#          by brand (only top-4 brands for clarity)
# Manipulation: filter with str_detect, mutate fct_reorder
# ------------------------------------------------------------

top_brands <- c("Monster", "Red Bull", "V")

quantity_data <- logged_data |>
  filter(str_detect(brand,
                    str_c(top_brands, collapse = "|"))) |>
  mutate(brand = fct_reorder(brand, quantity, .fun = median,
                             .desc = TRUE))

plot4 <- ggplot(quantity_data,
                aes(x = brand, y = quantity, fill = brand)) +
  geom_boxplot(alpha = 0.75, outlier.shape = 21,
               outlier.fill = "white", outlier.size = 2.5) +
  geom_jitter(width = 0.15, height = 0, alpha = 0.4, size = 1.8,
              colour = "grey30") +
  scale_fill_manual(values = brand_colours, guide = "none") +
  scale_y_continuous(breaks = 1:4) +
  labs(
    title    = "Distribution of Drinks Observed Per Sighting, by Brand",
    subtitle = "Top 3 brands shown; Monster and V tend to be seen in slightly larger groups",
    x        = "Brand",
    y        = "Quantity per Observation",
    caption  = "Jittered points show individual observations"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title    = element_text(face = "bold"),
    plot.subtitle = element_text(colour = "grey40")
  )


ggsave("plot4.png", plot = plot4, width = 8, height = 5, dpi = 150)
