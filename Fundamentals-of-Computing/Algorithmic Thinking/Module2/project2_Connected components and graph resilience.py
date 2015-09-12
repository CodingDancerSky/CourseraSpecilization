"""
Project 2 - Connected components and graph resilience
Author: Xiangzhu Long
Date: 21 June, 2015
"""

from collections import deque
import random

def bfs_visited(ugraph, start_node):
    """
    Input:
        an undiredted graph;
        a start node.
    Output:
        a set of BFS nodes starts at start_node
    """
    queue = deque()
    visited = set([start_node])
    queue.append(start_node)
    
    while len(queue) != 0:
        current = queue.popleft()
        for neighbor in ugraph[current]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
        
    return visited
        
        
def cc_visited(ugraph):
    """
    Input:
        an undiredted graph.
    Output:
        connected components
    """
    nodes = [node for node in ugraph.keys()]
    components = []
    
    while len(nodes) != 0:
        start_node = random.choice(nodes);
        visited = bfs_visited(ugraph, start_node)
        components.append(visited)
        
        for cc_node in visited:
            nodes.remove(cc_node)
        
    return components
        

def largest_cc_size(ugraph):
    """
    Input:
        an undiredted graph.
    Output:
        the size of the largest component in ugraph
    """
    components = cc_visited(ugraph)
    max_size = 0;
    
    for size in components:
        if max_size < len(size):
            max_size = len(size)
        
    return max_size 
        

def compute_resilience(ugraph, attack_order):
    """
    Input:
        an undiredted graph;
        a list of nodes that need to be removed
    Output:
        a list of components
    """
    components = []
    components.append(largest_cc_size(ugraph))
    
    for node in attack_order:
        if node in ugraph.keys():
            for edge in ugraph[node]:
                ugraph[edge].remove(node)
            ugraph.pop(node)
            components.append(largest_cc_size(ugraph))
    
    return components
   
    