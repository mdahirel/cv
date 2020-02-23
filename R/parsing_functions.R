# Take a position dataframe and the section id desired
# and prints the section to markdown. 
print_section <- function(position_data, section_id){
  position_data %>% 
    mutate(end=as_vector(as.character(end))) %>%  ###to allow both numbers and characters to be in end (to set end = "present" for current job)
    filter(section == section_id) %>% 
    arrange(desc(end)) %>% 
    mutate(id = 1:n()) %>% 
    pivot_longer(
      starts_with('description'),
      names_to = 'description_num',
      values_to = 'description'
    ) %>% 
    filter(!is.na(description) | description_num == 'description_1') %>%
    group_by(id) %>% 
    mutate(
      descriptions = list(description),
      no_descriptions = is.na(first(description))
    ) %>% 
    ungroup() %>% 
    filter(description_num == 'description_1') %>% 
    mutate(
      timeline = ifelse(
        is.na(start) | start == end,
        end,
        glue('{end} - {start}')
      ),
      description_bullets = ifelse(
        no_descriptions,
        ' ',
        map_chr(descriptions, ~paste('-', ., collapse = '\n'))
      )
    ) %>% 
    #strip_links_from_cols(c('title', 'description_bullets')) %>% 
    mutate_all(~ifelse(is.na(.), 'N/A', .)) %>% 
    glue_data(
      "### {title}",
      "\n\n",
      "{loc}",
      "\n\n",
      "{institution}",
      "\n\n",
      "{timeline}", 
      "\n\n",
      "{description_bullets}",
      "\n\n\n",
    )
}

# Construct a bar chart of skills
build_skill_bars <- function(skills, out_of = 5){
  bar_color <- "#238b45"
  bar_background <- "#c4d6c1"     #d9d9d9
  skills %>% 
    mutate(width_percent = round(100*level/out_of)) %>% 
    glue_data(
      "<div class = 'skill-bar'",
      "style = \"background:linear-gradient(to right,",
      "{bar_color} {width_percent}%,",
      "{bar_background} {width_percent}% 100%)\" >",
      "{skill}",
      "</div>"
    )
}

# Prints out from text_blocks spreadsheet blocks of text for the intro and asides. 
print_text_block <- function(text_blocks, label){
  filter(text_blocks, loc == label)$text %>%
    cat()
}
