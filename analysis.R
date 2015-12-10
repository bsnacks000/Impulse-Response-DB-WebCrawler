load("current_main.rda")    # load image from main.R

library(dplyr)
library(ggplot2)
library(stringr)

## Remove cols and filter Reverb times
reverb_df = large_df %>%
    select(-c(`Source Sound`, `Input`, `Generation Type`)) %>%
    filter(Response_type == "Reverberation Time RT60 T30 (seconds)")

# need to strip \n and whitespace for correct display
reverb_df[1:4] = lapply(reverb_df[1:4], function(i){
    str_replace_all(i, fixed(" "), "")
})       
reverb_df[1:4] = lapply(reverb_df[1:4], function(i){
    str_replace_all(i, "[\n]", "")
})       

# Reverb avg by space category
category_avg_df = reverb_df %>%
    group_by(`Space Category`)%>%
    summarise(avg_reverb = mean(Freq)) %>%
    arrange(desc(avg_reverb)) %>%
    na.omit()

# Reverb avg by source and space category
cat_source_avg_df = reverb_df %>%
    group_by(`Source Sound Category`, `Space Category`) %>%
    summarise(avg_reverb = mean(Freq)) %>%
    arrange(`Space Category`, `Source Sound Category`, desc(avg_reverb)) %>%
    na.omit()

# Reverb avg by location
location_avg_df = reverb_df %>%
    group_by(`Location`) %>%
    summarise(avg_reverb = mean(Freq)) %>%
    arrange(desc(avg_reverb))


## By category plot
ggplot(data=category_avg_df, 
       aes(x=reorder(`Space Category`,avg_reverb), y=avg_reverb)) +
    geom_bar(stat="identity") +
    coord_flip()

## By Location plot
ggplot(data=location_avg_df, 
       aes(x=reorder(Location,avg_reverb), y=avg_reverb)) +
    geom_bar(stat="identity") +
    coord_flip()

## By category and source input category plot
ggplot(
    data=cat_source_avg_df, 
    aes(x=reorder(`Space Category`,avg_reverb), 
        y=avg_reverb, fill= `Source Sound Category`))+
    
    geom_bar(stat="identity") +
    coord_flip()

## Hall - distribution of reverb over octave band
halls = c("Hall", "HallSportsHall", "ConcertHall")
hall_octaves = reverb_df %>%
    filter(`Space Category` %in% halls) %>%
    group_by(Octave_band) %>%
    summarise(avg_reverb = mean(Freq))

    ggplot(
        data=hall_octaves, 
        aes(x=Octave_band, y=avg_reverb)) +
    
    geom_bar(stat="identity") +
    coord_flip()

