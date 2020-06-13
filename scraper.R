library(rvest)
library(stringr)

parse <- function(url) {
  page <- html_session(url)

  title <- page %>%
    html_nodes(".title-text") %>%
    html_text() %>%
    trimws()

  eps <- page %>%
    html_nodes(".eps") %>%
    html_text() %>%
    trimws()

  src <- page %>%
    html_nodes(".source") %>%
    html_text()

  genres <- page %>%
    html_nodes(".genres.js-genre") %>%
    html_text() %>%
    str_replace_all("\n", "") %>%
    trimws()
    
  scormem <- page %>%
    html_nodes(".scormem") %>%
    html_text() %>%
    str_replace_all("\n", "") %>%
    trimws()

  return(cbind(title, eps, src, genres, scormem))
}

df1 <- parse("https://myanimelist.net/anime/producer/44/Shaft?page=1")
df2 <- parse("https://myanimelist.net/anime/producer/44/Shaft?page=2")

write.table( rbind(df1, df2), "data/scraped_data.csv",
  sep = ",",
  row.names = FALSE
)
