'''
Set of common transformations
'''

def nconst_to_float(df):
    '''
    Transform the nconst column to float.
    The type float64 support NaN values in Pandas.
    '''
    return df.str.replace('nm', '').astype(float)


def tconst_to_float(df):
    '''
    Transform the tconst column to float.
    The type float64 support NaN values in Pandas.
    '''
    return df.str.replace('tt', '').astype(float)
