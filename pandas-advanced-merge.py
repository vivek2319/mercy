import pandas as pd

def merge_dataframes(dataframes, key_column, how='outer'):
    """
    This function takes a list of dataframes, a key column name and a how parameter,
    and returns a single dataframe with the dataframes merged based on the specified key column, how parameter.
    :param dataframes: list of dataframes to be merged
    :type dataframes: list
    :param key_column: name of the key column on which the merge needs to take place
    :type key_column: str
    :param how: type of merge to be performed, options are 'inner' or 'outer'
    :type how: str
    :return: merged dataframe
    :rtype: pd.DataFrame
    """
    try:
        if len(dataframes) == 0 or key_column == '' or how == '':
            raise ValueError("Please provide the required parameters: list of dataframes, key column and type of merge(how)")
        merged_df = dataframes[0]
        for i in range(1, len(dataframes)):
            merged_df = pd.merge(merged_df, dataframes[i], on=key_column, how=how)
        return merged_df
    except ValueError as e:
        print(e)
        print("""
        Help: 
        dataframes - list of dataframes to be merged.
        key_column - name of the key column on which the merge needs to take place
        how - type of merge to be performed, options are 'inner' or 'outer'""")
