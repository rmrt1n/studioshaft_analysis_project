# libraries
library(tidyr)
library(dplyr)
library(stringr)

# import data
df <- readr::read_csv("data/scraped_data.csv")
head(df, 10)

# titecase colnames
colnames(df) <- str_to_title(colnames(df))

# wrangling
df <- df %>%
  separate(Scormem, into = c("Members", "Score"), sep = "\\s\\s+") %>%
  mutate(
    Eps = as.numeric(str_replace_all(Eps, "[ eps]", "")),
    Genres = str_replace_all(Genres, "\\s\\s+", ","),
    Members = as.numeric(str_replace_all(Members, ",", "")),
    Score = as.numeric(Score)
  )
df

# write to csv
write.csv(df, "data/processed_data.csv", row.names = FALSE)

