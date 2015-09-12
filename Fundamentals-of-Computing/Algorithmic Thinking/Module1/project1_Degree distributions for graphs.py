"""
Project 1 - Degree distributions for graphs
Author: Xiangzhu Long
"""

# representing the given directed graphs
EX_GRAPH0 = {0: set([1, 2]), 1: set([]), 2: set([])}
EX_GRAPH1 = {0: set([1, 4, 5]), 1: set([2, 6]), 2: set([3]),
             3: set([0]), 4: set([1]), 5: set([2]), 6: set([])}
EX_GRAPH2 = {0: set([1, 4, 5]), 1: set([2, 6]), 2: set([3, 7]),
             3: set([7]), 4: set([1]), 5: set([2]),
             6: set([]), 7: set([3]), 8: set([1, 2]),
             9: set([0, 3, 4, 5, 6, 7])}


def make_complete_graph(num_nodes):
    """
    returns a dictionary corresponding to a complete directed graph 
    with the specified number of nodes. 
    """
    complete_graph = {}
    
    for node in range(num_nodes):
        node_set = set()
        for base_node in range(num_nodes):
            node_set.add(base_node)
        node_set.remove(node)
        complete_graph[node] = node_set
    
    return complete_graph


def compute_in_degrees(digraph):
    """
    computes the in-degrees for the nodes in the graph
    """
    in_degree = {}
    for key in digraph:
        in_degree[key] = 0
    
    for key in in_degree:
        for direct in digraph[key]:
            in_degree[direct] += 1
    
    return in_degree


def in_degree_distribution(digraph):
    """
    computes the unnormalized distribution of the in-degrees of 
    the graph. 
    """
    in_degree = compute_in_degrees(digraph)
    degree_distribution = {}
    
    for key in in_degree:
        length = in_degree[key]
        if length in degree_distribution:
            degree_distribution[length] += 1
        else:
            degree_distribution[length] = 1
    
    return degree_distribution
    
    
    
    
    