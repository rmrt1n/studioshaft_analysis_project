# load libraries
library(dplyr)

# import data
df <- readr::read_csv("data/processed_data.csv")

# preparing data
df <- df %>% mutate(
    Src = if_else(
      Src %in% c("Music", "-"),
      "Other",
      if_else(Src == "Novel", "Light novel", Src)
    ),
    Lmembers = log10(Members),
    id = paste(1:nrow(df))
  ) %>%
  tidyr::drop_na(Score)

# seed for reproducibility
set.seed(8888)

# split data into train and test sets
train <- df %>% sample_frac(0.8)
test <- anti_join(df, train, by = "id")

# linear model to predict score from members
model1 <- lm(Score ~ Members, data = train)
summary(model1)

# lm with log transformed Members variable
model2 <- lm(Score ~ Lmembers, data = train)
summary(model2)

# predict model on test data
pred1 <- predict(model1, test)
pred2 <- predict(model2, test)

# compare prediction with actual values
df1 <- data.frame(cbind(id = c(1:25), actuals = test$Score, predicteds = pred1))
df2 <- data.frame(cbind(id = c(1:25), actuals = test$Score, predicteds = pred2))

# view comparison
head(df1, 10)
head(df2, 10)

# calculate MAPE
mape1 <- 100 * mean(abs((df1$actuals - df1$predicteds) / df1$predicteds))
print(paste("model1 MAPE: ", mape1))

mape2 <- 100 * mean(abs((df2$actuals - df2$predicteds) / df2$predicteds))
print(paste("model2 MAPE: ", mape2))

