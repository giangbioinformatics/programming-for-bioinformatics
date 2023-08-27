# 1. Machine learning using R
```
library(caret)
library(preprocess)

# Load iris dataset
data(iris)

# Split the dataset into training (80%) and testing (20%) sets
set.seed(123)
indices <- createDataPartition(y = iris$Species, times = 1, p = 0.6, list = FALSE)
training_data <- iris[indices, ]
testing_data <- iris[-indices, ]

# Normalize the data using the preprocess library
scale <- preProcess(training_data[, 1:4], method = c("center", "scale"))
testing_data_normalized <- predict(scale, testing_data)
training_data_normalized<-predict(scale, training_data)
# Train the KNN model using the caret library
model <- train(Species ~ ., data = as.data.frame(training_data_normalized), method = "knn", tuneLength = 10)

# Prediction on test
# Make predictions on the testing data
predictions <- predict(model, as.data.frame(testing_data_normalized))
# Evaluate the accuracy of the model
accuracy <- mean(predictions == testing_data$Species)
print(paste("Accuracy:", accuracy))

# Prediction on train
# Make predictions on the testing data
predictions <- predict(model, as.data.frame(training_data_normalized))
# Evaluate the accuracy of the model
accuracy <- mean(predictions == training_data$Species)
print(paste("Accuracy:", accuracy))
```
