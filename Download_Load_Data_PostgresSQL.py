
# Performing extraction of the covid_19_dataset using the pandas, requests and StringIO dependices and libritires.
# The StringIO will convert the content of the downloaded CSV file (retrieved as a string from the web) into a file-like object 
# that Pandas' read_csv() function can read from directly. This allows you to work with the CSV data as if it were being 
# read from a file, even though it's in-memory.


import pandas as pd
import requests
from io import StringIO

url='https://drive.google.com/file/d/1SzmRIwlpL5PrFuaUe_1TAcMV0HYHMD_b/view'

file_id = url.split('/')[-2]
dwn_url='https://drive.google.com/uc?export=download&id=' + file_id
url2 = requests.get(dwn_url).text
csv_raw = StringIO(url2)
Covid19 = pd.read_csv(csv_raw)
#print(Covid19.head())


# SQLAlchemy library is used to create a PostgreSQL database engine connection and then attempting to write data from a Covid19
# object into a table named covid_19_data in the database.


from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:Mysong123@localhost:5432/covid_19_data')

Covid19.to_sql('covid_19_data', con=engine, schema='public', if_exists='replace')