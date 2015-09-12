"""
Merge function for 2048 game.
"""

def merge(line):
    """
    Function that merges a single row or column in 2048.
    """
    length = len(line)
    result = [0] * length
    first = 0  # the first number that might be matched
    index = 0  # the index of the result to put number in
    
    for current in range(0, length):
        if(line[current] != 0):
            if(line[current] == first):
                result[index] = first * 2
                index += 1
                first = 0
            else:
                if(first != 0):
                    result[index] = first
                    index += 1
                first = line[current]
    
    if(first != 0): 
        result[index] = first
    
    return result


           
             