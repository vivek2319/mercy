# tested and working
import re

def extract_hyperlink(s):
    """
    Extracts the first hyperlink from a string that contains square or round brackets.

    Args:
        s (str): The input string containing the hyperlink.

    Returns:
        str: The extracted hyperlink, or 'No hyperlink found.' if no hyperlink is found.

    Raises:
        TypeError: If the input argument is not a string.
        Exception: If an error occurs during the extraction process.
    """
    if not isinstance(s, str):
        raise TypeError('Input argument must be a string.')

    try:
        link_regex = r'[\[\(]+\s*([^()\[\]]+?)\s*[\]\)]+'
        match = re.search(link_regex, s)

        if match:
            hyperlink = match.group(1).strip()
            return hyperlink
        else:
            return 'No hyperlink found.'
    except Exception as e:
        raise e

s = '  !123[[https://confluence.marksandspencer.app/display/ADE/Synapse+LAB+ETL+Framework+for+data+movement+from+ADLS+%3E+SYNAPSE ]] & ))  '
#s = s = ' [[[https://confluence.marksandspencer.app/display/ADE/Synapse+[LAB+ETL+Framework+for+]data+movement+[from+ADLS+%3E+SYNAPSE]]] '
hyperlink = extract_hyperlink(s)

print(hyperlink)
