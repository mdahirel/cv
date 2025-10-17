# This CV uses google sheets to store the position info
library(googlesheets4)
#this is a public sheet so no authentication needed
gs4_deauth()
positions_sheet_loc <- "https://docs.google.com/spreadsheets/d/1jp1yqvxYUha9-qZaZo9paw5xSWYupKOTFZghIU39RsY"

position_data <- read_sheet(positions_sheet_loc, sheet = "positions_FR")
talks_and_posters <- read_sheet(positions_sheet_loc, sheet = "talks_and_posters")
references <- read_sheet(positions_sheet_loc, sheet = "references") |> 
  dplyr::mutate(
    institution=institution_FR,
    description_1 = description_FR
  )
funding <- read_sheet(positions_sheet_loc, sheet = "funding_FR")
articles <- read_sheet(positions_sheet_loc, sheet = "articles")
software <- read_sheet(positions_sheet_loc, sheet = "software")
coding <- read_sheet(positions_sheet_loc, sheet = "coding")
language_skills <- read_sheet(positions_sheet_loc, sheet = "language_skills_FR")

