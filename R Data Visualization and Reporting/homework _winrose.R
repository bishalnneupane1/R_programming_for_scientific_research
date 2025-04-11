# 1. Wind Rose Plot for the Period 2014 to 2023:
library(openair)
library(worldmet)
# Define the start and end years for the period
start_year <- 2014
end_year <- 2023

# Initialize an empty list to store data for all years
all_years_data <- data.frame()

# Loop through the years 2014 to 2023
for (year in start_year:end_year) {
  # Import NOAA data for the specific station and year
  met_data <- importNOAA(code = "037720-99999", year = year)
  
  # Append the data for the current year to the list
  all_years_data <- rbind(all_years_data, met_data)
}

# Create a wind rose plot for the aggregated data
windrose <- windRose(all_years_data)

# Print the wind rose plot
print(windrose)

# Save the wind rose plot as a PNG file with specified width and height (600x600 pixels)
png("wind_rose_plot_Erbil_2014_2023.png", width = 600, height = 600)
print(windrose)
dev.off()
##############