# =================================================================================
# This code uses google sheets to store the position info
library(googlesheets4)
  
  if(sheet_is_publicly_readable){
    # This tells google sheets to not try and authenticate. Note that this will only
    # work if your sheet has sharing set to "anyone with link can view"
    sheets_deauth()
  } else {
    # My info is in a public sheet so there's no need to do authentication but if you want
    # to use a private sheet, then this is the way you need to do it.
    # designate project-specific cache so we can render Rmd without problems
    options(gargle_oauth_cache = ".secrets")
    
    # Need to run this once before knitting to cache an authentication token
    # googlesheets4::sheets_auth()
  }
  
  
  position_data <- read_sheet(positions_sheet_loc, sheet = "positions")
  talks_and_posters <- read_sheet(positions_sheet_loc, sheet = "talks_and_posters")
  education <- read_sheet(positions_sheet_loc, sheet = "education")
  references <- read_sheet(positions_sheet_loc, sheet = "references")
  funding <- read_sheet(positions_sheet_loc, sheet = "funding")
  articles <- read_sheet(positions_sheet_loc, sheet = "articles")
  software <- read_sheet(positions_sheet_loc, sheet = "software")
  coding <- read_sheet(positions_sheet_loc, sheet = "coding")
  language_skills <- read_sheet(positions_sheet_loc, sheet = "language_skills")

