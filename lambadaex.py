'''Use lambda expressions and the filter() function to filter out words from a list that don't start
with the letter 's'. For example:
seq = ['soup', 'dog', 'salad', 'cat', 'great']
should be filtered down to:
['soup', 'salad']
'''
seq = ['soup', 'dog', 'salad', 'cat', 'great']

list(filter(lambda word: word[0]=='s', seq))
