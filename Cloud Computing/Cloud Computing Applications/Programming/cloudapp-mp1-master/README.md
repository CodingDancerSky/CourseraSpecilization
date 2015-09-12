# Programming Assignment 1: Java Programming Essentials #
## Selective Word Count ##

Goal: to implement an application to find the top 20 words used in Wikipedia titles. 

Input: a huge list of Wikipedia titles (one in each line). 
Output: the top 20 words that appear the most in a selection of titles. 

One possible procedure is the following:

1. Divide each sentence into a list of words using delimiters provided in the “delimiters” variable.

2. Make all the tokens lowercase and remove any tailing and leading spaces.

3. Ignore all common words provided in the “stopWordsArray” variable.

4. Keep track of word frequencies.

5. Sort the list by frequency in a descending order. 

If two words have the same number count, use the lexigraphy. For example, the following is a sorted list: {(Orange, 3), (Apple, 2), (Banana, 2)}

6. Return the top 20 items from the sorted list as a String Array.