library("tidyverse")

logged_data <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRHaMrOqii2tFpTH9s4SEv7Wv1PNuF7fwck5SOM9F2pXzyNibgYcm4KyM9qoM3O0jDUcoFIKnN7K4gF/pub?output=csv")
str(logged_data)

latest_data <- logged_data %>%                                        # Renaming the data frame variables in a new data frame.
  rename(
    timestamp = Timestamp,
    campus = UoA.or.AUT.Campus.,
    building_number = What.was.the.building.number.of.the.observation...Enter.answer.without.B..i.e...for.building.110N..don.t.use.B110N..use.110N..Link.to.map.for.convenience.,
    building_name = What.was.the.building.name.of.the.observation...Use.capitals..Link.to.map.for.convenience.,
    observation_date = What.was.the.date.of.the.observation.,
    observation_time = What.was.the.time.of.the.observation.,
    drink_brand = What.was.the.brand.of.the.drink.,
    quantity_seen = Quantity.of.same.brand.seen.in.the.location...e.g...2.at.one.table.
  )
str(latest_data)

# ---------- Quantity Seen Analysis ----------

max_quantity <- max(latest_data$quantity_seen, na.rm = TRUE)
min_quantity <- min(latest_data$quantity_seen, na.rm = TRUE)
mean_quantity <- mean(latest_data$quantity_seen, na.rm = TRUE)
median_quantity <- median(latest_data$quantity_seen, na.rm = TRUE)

summary_stats <- tibble(
  statistic = factor(c("Min", "Mean", "Median", "Max"), levels = c("Min", "Mean", "Median", "Max")),
  value = c(min_quantity, mean_quantity, median_quantity, max_quantity)
)

# Using the summary statistics to create a
# graph showing the combined number of drinks
# observed in an instance. Less relevant as
# it is not group irrelevant of brand.

ggplot(summary_stats, aes(x = statistic, y = value, fill = statistic)) +
  geom_col(width = 0.65, show.legend = FALSE) +
  geom_text(aes(label = round(value, 2)), vjust = -0.5, size = 4) +
  labs(
    title = "Summary Statistics of Recorded Quantities",
    x = "Statistic",
    y = "Quantity"
  ) +
  theme_minimal(
    base_size = 16
  ) +
  theme(
    axis.title.y = element_text(size = 16),
    axis.title.x = element_text(size = 16),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14)
  )



busiest_per_day <- latest_data %>%                                    # Daily peak based on single observations, not summed duplicates
  group_by(observation_date) %>%
  summarise(total_quantity = max(quantity_seen, na.rm = TRUE), .groups = "drop")

peak_date <- busiest_per_day$observation_date                        # PEAKS!!! For date and quantity
peak_quantity <- busiest_per_day$total_quantity

# Plotting the maximum seen in a given day
# so that it is irrelevant of the brand.
# using the busiest per day data frame

# Plotting the max vs day
ggplot(busiest_per_day, aes(x = observation_date, y = total_quantity)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Peak Energy Drink Count per Day in a given instance",
    x = "Date", y = "Peak Quantity at One Time"
  ) +
  theme_minimal(
    base_size = 16
  ) +
  theme(
    axis.title.y = element_text(size = 16),
    axis.title.x = element_text(size = 16),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14)
  )


# ---------- Brand Analysis ----------

brand_summary <- latest_data %>%
  group_by(drink_brand) %>%
  summarise(total_quantity = sum(quantity_seen, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_quantity))

# This is to create a graph for the totals
# observed of each brand, I don't think I
# quite got the most efficient way of seting
# the sizes. It uses the data frame grouped
# by the drink brand from above.

ggplot(brand_summary, aes(x = forcats::fct_reorder(drink_brand, total_quantity), y = total_quantity)) +
  geom_col(fill = "#2C7FB8") +
  geom_text(aes(label = total_quantity), vjust = -0.3, size = 5) +
  labs(
    title = "Total Quantity Seen by Brand",
    x = "Drink Brand",
    y = "Total Quantity Seen"
  ) +
  theme_minimal(
    base_size = 16
  ) +
  theme(
    axis.title.y = element_text(size = 16),
    axis.title.x = element_text(size = 16),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14)
  )

# ---------- Campus Based Analysis ----------

campus_summary <- latest_data %>%
  group_by(campus) %>%
  summarise(total_quantity = sum(quantity_seen, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_quantity))

ggplot(campus_summary, aes(x = forcats::fct_reorder(campus, total_quantity), y = total_quantity)) +
  geom_col(fill = "#1B9E77") +
  geom_text(aes(label = total_quantity), vjust = -0.3, size = 5) +
  labs(
    title = "Total Quantity Seen by Campus",
    x = "Campus",
    y = "Total Quantity Seen"
  ) +
  theme_minimal(
    base_size = 16
  ) +
  theme(
    axis.title.y = element_text(size = 16),
    axis.title.x = element_text(size = 16),
    axis.text.y = element_text(size = 14),
    axis.text.x = element_text(size = 14)
  )







# -------------------------------------------------------------------
#                 Final Code for the Dynamic Report
# -------------------------------------------------------------------
#
# I chose these graphs as one of them shows the statistical summaries,
# and the other shows the totals by brand, I felt these were the most
# insightful as it can be compared to overall global or national tallies
# for each brand (Which to my understanding with no backing because of
# paywalls, is V in NZ - we found monster to be most popular contrarily)
# additionally, data showing the statistical quantities number of drinks 
# of a given brand  is useful.


# library("tidyverse")

# logged_data <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRHaMrOqii2tFpTH9s4SEv7Wv1PNuF7fwck5SOM9F2pXzyNibgYcm4KyM9qoM3O0jDUcoFIKnN7K4gF/pub?output=csv")

# latest_data <- logged_data %>%
#   rename(
#     timestamp = Timestamp,
#     campus = UoA.or.AUT.Campus.,
#     building_number = What.was.the.building.number.of.the.observation...Enter.answer.without.B..i.e...for.building.110N..don.t.use.B110N..use.110N..Link.to.map.for.convenience.,
#     building_name = What.was.the.building.name.of.the.observation...Use.capitals..Link.to.map.for.convenience.,
#     observation_date = What.was.the.date.of.the.observation.,
#     observation_time = What.was.the.time.of.the.observation.,
#     drink_brand = What.was.the.brand.of.the.drink.,
#     quantity_seen = Quantity.of.same.brand.seen.in.the.location...e.g...2.at.one.table.
#   )

# max_quantity <- max(latest_data$quantity_seen, na.rm = TRUE)
# min_quantity <- min(latest_data$quantity_seen, na.rm = TRUE)
# mean_quantity <- mean(latest_data$quantity_seen, na.rm = TRUE)
# median_quantity <- median(latest_data$quantity_seen, na.rm = TRUE)

# summary_stats <- tibble(
#   statistic = factor(c("Min", "Mean", "Median", "Max"), levels = c("Min", "Mean", "Median", "Max")),
#   value = c(min_quantity, mean_quantity, median_quantity, max_quantity)
# )

# ggplot(summary_stats, aes(x = statistic, y = value, fill = statistic)) +
#   geom_col(width = 0.65, show.legend = FALSE) +
#   geom_text(aes(label = round(value, 2)), vjust = -0.5, size = 4) +
#   scale_fill_manual(values = c("Min" = "#84a98c", "Mean" = "#52796f", "Median" = "#354f52", "Max" = "#b2452e")) +
#   labs(
#     title = "Summary Statistics of Recorded Quantities",
#     x = "Statistic",
#     y = "Quantity"
#   ) +
#   theme_minimal(base_size = 16) +
#   theme(
#     axis.title.y = element_text(size = 16),
#     axis.title.x = element_text(size = 16),
#     axis.text.y = element_text(size = 14),
#     axis.text.x = element_text(size = 14)
#   )

# brand_summary <- latest_data %>%
#   group_by(drink_brand) %>%
#   summarise(total_quantity = sum(quantity_seen, na.rm = TRUE), .groups = "drop") %>%
#   arrange(desc(total_quantity))

# ggplot(brand_summary, aes(x = forcats::fct_reorder(drink_brand, total_quantity), y = total_quantity)) +
#   geom_col(fill = "#2d6a4f") +
#   geom_text(aes(label = total_quantity), vjust = -0.3, size = 5) +
#   labs(
#     title = "Total Quantity Seen by Brand",
#     x = "Drink Brand",
#     y = "Total Quantity Seen"
#   ) +
#   theme_minimal(base_size = 16) +
#   theme(
#     axis.title.y = element_text(size = 16),
#     axis.title.x = element_text(size = 16),
#     axis.text.y = element_text(size = 14),
#     axis.text.x = element_text(size = 14)
#   )
