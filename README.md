# Analyzing Data of Animes From Studio SHAFT & Building a Model to Try predict User Ratings/Scores

I analyzed data of 130 animes from studio SHAFT scraped from [Myanimelist.net](https://myanimelist.net) and built a linear
model to try and predict user ratings/scores of future SHAFT animes.

## Resources Used
**R packages:**
- core tidyverse
- gridExtra
- rvest

**Data Source:** https://myanimelist.net/anime/producer/44/Shaft

## Dataset Descriptions
**processed_data.csv**
columns:
- Title (Anime title)
- Eps (Number of Episodes)
- Src (Original Source of Anime)
- Genres (Genres, Separated by Comma)
- Members (Number of People with The Anime in Their MAL List)
- Score (User Rating from MAL Users)

## Findings
Here are some results of the exploratory data analysis. The full analysis can be seen [here].

## Model Building
Because of the moderate positive correlation between the number of members and the user score, I tried a linear
regression model. I also split the data into training and testing set with a 80:20 ratio. I tried 2 models, 1 with a 
log-transformed Members variable and 1 without. Here are the performances of the models:

