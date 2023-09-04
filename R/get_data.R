# This CV uses google sheets to store the position info
library(googlesheets4)
#this is a public sheet so no authentication needed
gs4_deauth()
positions_sheet_loc <- "https://docs.google.com/spreadsheets/d/1jp1yqvxYUha9-qZaZo9paw5xSWYupKOTFZghIU39RsY"

position_data <- read_sheet(positions_sheet_loc, sheet = "positions")
talks_and_posters <- read_sheet(positions_sheet_loc, sheet = "talks_and_posters")
education <- read_sheet(positions_sheet_loc, sheet = "education")
references <- read_sheet(positions_sheet_loc, sheet = "references")
funding <- read_sheet(positions_sheet_loc, sheet = "funding")
articles <- read_sheet(positions_sheet_loc, sheet = "articles")
software <- read_sheet(positions_sheet_loc, sheet = "software")
coding <- read_sheet(positions_sheet_loc, sheet = "coding")
language_skills <- read_sheet(positions_sheet_loc, sheet = "language_skills")

