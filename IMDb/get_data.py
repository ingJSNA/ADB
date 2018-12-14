
# coding: utf-8

# Download the data from the page and load to Pandas DataFrame

# In[1]:

import csv
import math
import pandas as pd
import os
import requests

from tqdm.auto import tqdm


# In[15]:


data_folder = './imdb'

if not os.path.exists(data_folder):
    os.mkdir(data_folder)

def fetch_or_resume(url, filename):
    block_size = 1024
    wrote = 0

    # Connecto to server
    headers = {}
    response = requests.get(url, headers=headers, stream=True)
    total_size = int(response.headers.get('content-length'))

    if os.path.exists(filename):
        print("File {} already exists".format(filename))

        # Check file size
        filename_size = os.path.getsize(filename)
        print(filename_size, total_size)
        if filename_size == total_size:
            print("Warning, No downloading, the file {} has the required size.".format(filename))
            return

    # Download file
    with open(filename, 'wb') as file:
        for data in tqdm(iterable = response.iter_content(chunk_size = block_size),
                                  total = total_size//block_size,
                                  desc = os.path.basename(url),
                                  unit = 'KB'):
            wrote = wrote  + len(data)
            file.write(data)

        if total_size != 0 and wrote != total_size:
            print("ERROR, something went wrong")

def get_imdb_file_dataframe(url, download=False, low_memory=True):
    base = os.path.basename(url)
    filename = os.path.join(data_folder, base)
    if download:
        fetch_or_resume(url, filename)

    return pd.read_csv(filename, sep='\t', low_memory=low_memory,
                        na_values={'\\N'}, quoting=csv.QUOTE_NONE)


# In[26]:
def get_name_basics():
    return get_imdb_file_dataframe('https://datasets.imdbws.com/name.basics.tsv.gz')

def get_title_akas():
    return get_imdb_file_dataframe('https://datasets.imdbws.com/title.akas.tsv.gz')

def get_title_basics():
    return get_imdb_file_dataframe('https://datasets.imdbws.com/title.basics.tsv.gz')

def get_title_crew():
    return get_imdb_file_dataframe('https://datasets.imdbws.com/title.crew.tsv.gz')

def get_title_episode():
    return get_imdb_file_dataframe('https://datasets.imdbws.com/title.episode.tsv.gz')

def get_title_principals():
    return get_imdb_file_dataframe('https://datasets.imdbws.com/title.principals.tsv.gz')

def get_title_ratings():
    return get_imdb_file_dataframe('https://datasets.imdbws.com/title.ratings.tsv.gz')
