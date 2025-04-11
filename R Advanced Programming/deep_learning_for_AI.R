# Install devtools
# install.packages("devtools")
# Install keras
# devtools::install_github("rstudio/keras")

# Load necessary libraries
library(tidyverse)   # For data manipulation
library(keras3)      # For building neural networks
# install_keras(method = "conda", tensorflow = "cpu")

library(tensorflow)  # Backend for Keras
library(datasets)    # Provides sample datasets


# Load Iris dataset
data(iris)


# Convert class labels to numeric format (0, 1, 2)
iris[,5] <- as.numeric(iris[,5]) - 1

# Convert iris dataframe to a matrix
iris <- as.matrix(iris)

# Set dimension names to NULL
dimnames(iris) <- NULL


# Determine sample size and split the dataset into training and test sets
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))

# Select rows for training set where ind is 1
iris.training <- iris[ind==1, 1:4]

# Select rows for test set where ind is 2
iris.test <- iris[ind==2, 1:4]

# Split the class attribute for training set
iris.trainingtarget <- iris[ind==1, 5]  # Select the class labels corresponding to the training set samples

# Split the class attribute for test set
iris.testtarget <- iris[ind==2, 5]  # Select the class labels corresponding to the test set samples


# One hot encode training target values:
# Convert the class labels of the training set into a one-hot encoded format.
# One-hot encoding transforms categorical labels into a binary matrix where each column represents a unique class, 
# and the column corresponding to the class label is marked as 1 while others are 0.
iris.trainLabels <- to_categorical(iris.trainingtarget)

# One hot encode test target values:
# Similar to the above, convert the class labels of the test set into a one-hot encoded format.
iris.testLabels <- to_categorical(iris.testtarget)


# Print out the one-hot encoded test labels to double-check the result
print(iris.testLabels)
#--------------------------------------- model 1 ----------------------------------------
## Constructing the Model
# Initialize a sequential model
model <- keras_model_sequential() 

# Add layers to the model
# Add a dense (fully connected) layer with 8 units/neurons, ReLU activation function, and input shape of (4,)
# The input shape (4,) corresponds to the number of features in the input data (4 features in Iris dataset)
# The ReLU activation function introduces non-linearity to the network
# The first layer requires specification of input shape since it's the first layer in the model
model %>% 
  layer_dense(units = 8, activation = 'relu', input_shape = c(4)) %>% 
  # Add another dense layer with 3 units/neurons, softmax activation function
  # Softmax activation is commonly used for multi-class classification tasks
  # It ensures that the output values are between 0 and 1 and sum up to 1, representing class probabilities
  layer_dense(units = 3, activation = 'softmax')

# Print a summary of the model architecture, including the number of layers, 
# the type of layers, and the number of parameters in each layer.
summary(model)


# Get model configuration
get_config(model)
# This line retrieves the configuration of the neural network model. 
# It provides details about the architecture, such as the number of layers, 
# the activation functions used, the number of units in each layer, etc.


# Get layer configuration
# Retrieve information about the first layer in the model
get_layer(model, index = 1)

# List the model's layers
model$layers  # This line lists all the layers in the model

# List the input tensors
model$inputs # This line retrieves the list of input tensors for the neural network model. 

# List the output tensors
model$outputs # This line retrieves the list of output tensors for the neural network model

# Compile And Fit The Model:
# Compile the model
model %>% compile(
  loss = 'categorical_crossentropy',  # Specify the loss function for categorical classification
  optimizer = 'adam',                  # Specify the optimizer algorithm (Adam)
  metrics = 'accuracy'                 # Specify the metric to evaluate model performance (accuracy)
)


# Store the fitting history in `history` 
history <- model %>% fit(
  iris.training,           # Training data features (input)
  iris.trainLabels,        # Training data labels (output)
  epochs = 200,            # Number of training epochs (iterations over the entire dataset)
  batch_size = 5,          # Number of samples per gradient update
  validation_split = 0.2   # Fraction of the training data to be used as validation data
)


# Plot the history
plot(history) # Plotting the training history provides visual insights into the model's performance over each epoch.

# Visualize The Model Training History:
# Plot the model loss of the training data
plot(history$metrics$loss, main="Model Loss", xlab = "epoch", ylab="loss", col="blue", type="l")
# This command creates a plot of the model's loss on the training data over epochs.

# Plot the model loss of the test data
lines(history$metrics$val_loss, col="green")

# Add legend
legend("topright", c("train","test"), col=c("blue", "green"), lty=c(1,1))

# Plot the accuracy of the training data 
plot(history$metrics$acc, main="Model Accuracy", xlab = "epoch", ylab="accuracy", col="blue", type="l")

# Plot the accuracy of the validation data
lines(history$metrics$val_acc, col="green")

# Add Legend
legend("bottomright", c("train","test"), col=c("blue", "green"), lty=c(1,1))

# Evaluate on test data and labels
score <- model %>% evaluate(iris.test, iris.testLabels, batch_size = 128)

# Print the score
print(score)
#------------------------------------ model 2 ----------------------------
# Fine-tuning Your Model:
# Adding Layers

# Initialize the sequential model
model2 <- keras_model_sequential() 


# Add layers to model2:
# Add a dense layer with 8 units and ReLU activation function.
# Input shape is specified as (4,), indicating the input features.
# This layer connects to the input layer implicitly.
# Initialize the sequential model

model2 %>% 
  # Add a dense layer with 8 units and ReLU activation function.
  # Input shape is specified as (4,), indicating the input features.
  # This layer connects to the input layer implicitly.
  layer_dense(units = 8, activation = 'relu', input_shape = c(4)) %>% 
  
  # Add another dense layer with 5 units and ReLU activation function.
  # This layer automatically receives input from the previous layer.
  layer_dense(units = 5, activation = 'relu') %>% 
  
  # Add the output layer with 3 units and softmax activation function.
  # This layer produces the final output probabilities for the three classes in the Iris dataset.
  layer_dense(units = 3, activation = 'softmax')



# Compile the model
model2 %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam',
  metrics = 'accuracy'
)


# Fit the model to the data
model2 %>% fit(
  iris.training, iris.trainLabels, 
  epochs = 200, batch_size = 5, 
  validation_split = 0.2
)

# Evaluate the model
score2 <- model2 %>% evaluate(iris.test, iris.testLabels, batch_size = 128)

# Print the score
print(score2)
#-------------------------------model 3 -------------------------------
# Hidden Units:
# Initialize a sequential model
model3 <- keras_model_sequential() 

# Add layers to the model
model3 %>% 
  # Add a dense layer with 28 units and ReLU activation function.
  layer_dense(units = 28, activation = 'relu', input_shape = c(4)) %>% 
  # Add another dense layer with 3 units (output classes) and softmax activation function.
  layer_dense(units = 3, activation = 'softmax')


# Compile the model
model3 %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam',
  metrics = 'accuracy'
)

# Fit the model to the data
model3 %>% fit(
  iris.training, iris.trainLabels, 
  epochs = 200, batch_size = 5, 
  validation_split = 0.2
)

# Evaluate the model
score3 <- model3 %>% evaluate(iris.test, iris.testLabels, batch_size = 128)

# Print the score
print(score3)


