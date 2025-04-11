# Uncomment and run if you need to install keras for the first time:
# install.packages("keras")
# library(keras)
# install_keras()  # This installs TensorFlow (CPU-only version by default)

# Load necessary libraries
library(tidyverse)   # For data manipulation
library(keras)       # For building neural networks (updated package, replaces keras3)
library(tensorflow)  # Backend for Keras
library(datasets)    # Provides sample datasets

# Load Iris dataset
data(iris)

# Convert class labels to numeric format (0, 1, 2)
iris[, 5] <- as.numeric(iris[, 5]) - 1

# Convert iris dataframe to a matrix and remove dimension names
iris <- as.matrix(iris)
dimnames(iris) <- NULL

# Determine sample size and split the dataset into training and test sets
ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.67, 0.33))
iris.training <- iris[ind == 1, 1:4]  # Training features
iris.test <- iris[ind == 2, 1:4]      # Test features

# Split the class attribute for training and test sets
iris.trainingtarget <- iris[ind == 1, 5]  # Training labels
iris.testtarget <- iris[ind == 2, 5]      # Test labels

# One hot encode target values:
# Convert the class labels into one-hot encoded format.
iris.trainLabels <- to_categorical(iris.trainingtarget)
iris.testLabels <- to_categorical(iris.testtarget)

# Print out the one-hot encoded test labels to verify the result
print(iris.testLabels)

#--------------------------------------- model 1 ----------------------------------------
## Constructing Model 1

# Initialize a sequential model
model <- keras_model_sequential() 

# Build the model by adding layers
model %>% 
  layer_dense(units = 8, activation = 'relu', input_shape = c(4)) %>% 
  layer_dense(units = 3, activation = 'softmax')

# Display summary of the model architecture
summary(model)

# Retrieve model configuration and layers (optional inspections)
get_config(model)
get_layer(model, index = 1)
print(model$layers)  
print(model$inputs)  
print(model$outputs)

# Compile the model
model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam',
  metrics = 'accuracy'
)

# Fit the model and store the training history
history <- model %>% fit(
  iris.training,
  iris.trainLabels,
  epochs = 200,
  batch_size = 5,
  validation_split = 0.2
)

# Plot the training history using the built-in plot function
plot(history)

#---------------------------------- Plot Training Curves --------------------------
# Plot training and validation loss
plot(history$metrics$loss, main = "Model Loss", xlab = "Epoch", ylab = "Loss", col = "blue", type = "l")
lines(history$metrics$val_loss, col = "green")
legend("topright", legend = c("Train", "Validation"), col = c("blue", "green"), lty = 1)

# Plot training and validation accuracy
plot(history$metrics$accuracy, main = "Model Accuracy", xlab = "Epoch", ylab = "Accuracy", col = "blue", type = "l")
lines(history$metrics$val_accuracy, col = "green")
legend("bottomright", legend = c("Train", "Validation"), col = c("blue", "green"), lty = 1)

# Evaluate the model on test data
score <- model %>% evaluate(iris.test, iris.testLabels, batch_size = 128)
print(score)

#--------------------------------------- model 2 ----------------------------------------
## Constructing Model 2: Adding layers for fine-tuning

model2 <- keras_model_sequential() 

model2 %>% 
  layer_dense(units = 8, activation = 'relu', input_shape = c(4)) %>% 
  layer_dense(units = 5, activation = 'relu') %>% 
  layer_dense(units = 3, activation = 'softmax')

# Compile model2
model2 %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam',
  metrics = 'accuracy'
)

# Fit model2 to the training data
model2 %>% fit(
  iris.training, iris.trainLabels, 
  epochs = 200, batch_size = 5, 
  validation_split = 0.2
)

# Evaluate model2 on test data and print the result
score2 <- model2 %>% evaluate(iris.test, iris.testLabels, batch_size = 128)
print(score2)

#--------------------------------------- model 3 ----------------------------------------
## Constructing Model 3: Using a higher number of hidden units

model3 <- keras_model_sequential() 

model3 %>% 
  layer_dense(units = 28, activation = 'relu', input_shape = c(4)) %>% 
  layer_dense(units = 3, activation = 'softmax')

# Compile model3
model3 %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam',
  metrics = 'accuracy'
)

# Fit model3 to the training data
model3 %>% fit(
  iris.training, iris.trainLabels, 
  epochs = 200, batch_size = 5, 
  validation_split = 0.2
)

# Evaluate model3 on test data and print the result
score3 <- model3 %>% evaluate(iris.test, iris.testLabels, batch_size = 128)
print(score3)

