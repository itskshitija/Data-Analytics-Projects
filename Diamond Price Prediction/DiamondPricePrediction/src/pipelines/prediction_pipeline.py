# Import necessary libraries and modules
import sys  # Provides access to system-specific parameters and functions
import os   # Used for interacting with the operating system
from src.exception import CustomException  # Custom exception class for handling errors
from src.logger import logging  # Custom logging module for logging information
from src.utils import load_object  # Utility function to load serialized objects (e.g., pickled files)
import pandas as pd  # Library for working with data in DataFrame format

# Class to handle the prediction pipeline
class PredictPipeline:
    def __init__(self):
        # Constructor method (currently not initializing anything)
        pass

    def predict(self, features):
        """
        Method to make predictions using a pre-trained model and preprocessor.
        
        Args:
            features (DataFrame or Array-like): Input data to predict on.
        
        Returns:
            pred (Array-like): Predictions from the model.
        """
        try:
            # Define file paths for the preprocessor and model artifacts
            preprocessor_path = os.path.join('artifacts', 'preprocessor.pkl')  # Path to the preprocessor file
            model_path = os.path.join('artifacts', 'model.pkl')  # Path to the model file

            # Load the preprocessor and model from the specified paths
            preprocessor = load_object(preprocessor_path)  # Deserialize the preprocessor
            model = load_object(model_path)  # Deserialize the model

            # Transform the input features using the preprocessor
            data_scaled = preprocessor.transform(features)

            # Make predictions using the model
            pred = model.predict(data_scaled)
            return pred  # Return the predictions

        except Exception as e:
            # Log the exception and raise a custom exception with additional context
            logging.info("Exception occurred in prediction")
            raise CustomException(e, sys)

# Class to handle custom data input for prediction
class CustomData:
    def __init__(self,
                 carat: float,  # Weight of the diamond
                 depth: float,  # Depth percentage
                 table: float,  # Width of the diamond's table
                 x: float,  # Length in mm
                 y: float,  # Width in mm
                 z: float,  # Height in mm
                 cut: str,  # Quality of the cut
                 color: str,  # Color grade
                 clarity: str):  # Clarity grade
        """
        Constructor to initialize the attributes for custom data.
        """
        # Assign the input parameters to instance variables
        self.carat = carat
        self.depth = depth
        self.table = table
        self.x = x
        self.y = y
        self.z = z
        self.cut = cut
        self.color = color
        self.clarity = clarity

    def get_data_as_dataframe(self):
        """
        Converts the custom data into a Pandas DataFrame format for model prediction.
        
        Returns:
            DataFrame: A DataFrame containing the input data.
        """
        try:
            # Create a dictionary to hold the input data
            custom_data_input_dict = {
                'carat': [self.carat],
                'depth': [self.depth],
                'table': [self.table],
                'x': [self.x],
                'y': [self.y],
                'z': [self.z],
                'cut': [self.cut],
                'color': [self.color],
                'clarity': [self.clarity]
            }
            # Convert the dictionary to a Pandas DataFrame
            df = pd.DataFrame(custom_data_input_dict)
            logging.info('Dataframe Gathered')  # Log that the DataFrame was created successfully
            return df  # Return the DataFrame

        except Exception as e:
            # Log the exception and raise a custom exception with additional context
            logging.info('Exception occurred in prediction pipeline')
            raise CustomException(e, sys)
