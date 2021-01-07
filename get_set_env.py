
import os
RAPIDS_DATASET_ROOT_DIR= "/datasets"


# Set environment variables
os.environ['API_USER'] = 'hi' 
os.environ['API_PASSWORD'] = 'secret'


USER = os.getenv('API_USERs')

#os.environ.pop("API_PASSWORD")

print(USER)