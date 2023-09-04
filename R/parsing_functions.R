# These functions take a dataframe and the section id desired and prints the section as pre-formatted markdown. 

print_position <- function(position_data, section_id){
  position_data <- position_data  |>  
    mutate(end=as_vector(as.character(end)))  |>   ###to allow both numbers and characters to be in end (to set end = "present" for current job)
    filter(section == section_id)  |>  
    arrange(desc(end))  |>  
    mutate(id = 1:n()) |> 
    mutate(
      timeline = case_when(is.na(start) | start == end ~ end,
                           TRUE ~ glue('{start} - {end}')
                           )
    )
  
  if(section_id %in% c("current-job", "previous-positions")){
    glue_data(position_data,
      "| **[title]**  ",
      "\n\n",
      "|      \\small{{< fa calendar >}}"," [timeline] ","{{< fa globe >}}"," [location]\\normalsize",
      "\n\n",
      "|      [institution]",
      "\n\n",
      "|      [description_1]",
      "\n\n\n",
      .na="",
      .open="[",.close="]"  # change from default to avoid issues with fa icons
    )
  }else{
    glue_data(position_data,
      "| **[title]**  ",
      "\n\n",
      "|      \\small{{< fa calendar >}}"," [timeline] ","{{< fa globe >}}"," [location]\\normalsize",
      "\n\n",
      "|      [institution]",
      "\n\n\n",
      .na="",
      .open="[",.close="]"  # change from default to avoid issues with fa icons
    )
  }
    
}

print_funding <- function(funding_data, section_id){
  funding_data  |>  
    mutate(end=as_vector(as.character(end)))  |>   ###to allow both numbers and characters to be in end (to set end = "present" for current job)
    filter(section == section_id)  |>  
    arrange(desc(end))  |>  
    mutate(id = 1:n()) |> 
    mutate(
      timeline = case_when(is.na(start) | start == end ~ end,
                           TRUE ~ glue('{start} - {end}')
      )
    ) |>  
    glue_data(
      "| **[title]**  ",
      "\n\n",
      "|    {{< fa calendar >}}"," [timeline] | [amount] ",
      "\n\n",
      "|    [description_1]",
      "\n\n\n",
      .open="[",.close="]"  # change from default to avoid issues with fa icons
    )
}


print_references <- function(reference_data){
  reference_data |> 
    glue_data(
      "| **{name}**",
      "\n\n",
      "|    \\small {email} \\normalsize",
      "\n\n",
      "|    {institution}",
      "\n\n",
      "|    {description_1}",
      "\n\n\n"
    )
}

print_papers<-function(df){
  
  test=df |> 
    rowwise() |> 
    mutate(
      title = markdown_latex(paste0("**",title,"**")),
      authors = markdown_latex(authors)
    )|>
    ungroup() |> 
    group_by(year, section) |>   
    nest() |> 
    mutate(parsed = map(.x=data,
                        .f = ~.x |> 
                          glue_data(
                            "| {title}",
                            "\n",
                            "|     {publication}",
                            "\n\n",
                            "| \\small {authors} \\normalsize",
                            "\n\n\n\n",
                          )
    )
    ) |> 
    mutate(year_glued = case_when(section=="peer-reviewed"~glue("### {year} \n\n"),
                                  TRUE ~ glue(""))
           )|> 
    mutate(full = map2(.x=year_glued, .y = parsed,
                       .f = ~.x |> paste0(glue_collapse(.y)))) |> 
    unnest(full)
  
  glue_collapse(test$full)
  
}

print_meetings<-function(df){
  
  test=df |>  
    rowwise() |> 
    mutate(
      title = markdown_latex(paste0("**",title,"**")),
      authors = markdown_latex(authors)
    )|>
    ungroup() |> 
    group_by(year, section) |>
    nest() |> 
    mutate(parsed = map(.x=data,
                        .f = ~.x |> 
                          glue_data(
                            "| [title]  ",
                            "\n",
                            "|     \\small [meeting] | {{< fa globe >}} [location]\\normalsize",
                            "\n\n",
                            "| [authors]",
                            "\n\n\n\n",
                            .na="",
                            .open="[",.close="]"  # change from default to avoid issues with fa icons
                          )
    )
    ) |> 
    mutate(year_glued = glue("### {year} \n\n")
           )|> 
    mutate(full = map2(.x=year_glued, .y = parsed,
                       .f = ~.x |> paste0(glue_collapse(.y)))) |> 
    unnest(full)
  
  glue_collapse(test$full)
  
}


# This function is used to build bar charts of skill levels

build_skill_bars <- function(skills, 
                             out_of = 5,
                             bar_colour = "#238b45",
                             bar_background = "#c4d6c1"){
  ggplot(skills)+
    geom_col(aes(x=out_of,y=skill),fill=bar_background)+
    geom_col(aes(x=level,y=skill),fill=bar_colour)+
    geom_richtext(aes(x=0.1,y=skill,label=skill),
                  hjust=0,size=8,fill=NA,col=NA,text.colour="white")+
    theme_void()
}
