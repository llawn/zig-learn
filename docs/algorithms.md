# Algorithms

This section covers the implementation of fundamental algorithms in Zig, organized by category and complexity.

## Overview

Algorithms are step-by-step procedures for solving problems and performing computations. In this repository, we implement various algorithms to understand their behavior, performance characteristics, and practical applications.

## Algorithm Categories

### Sorting Algorithms

Sorting algorithms arrange elements in a specific order (typically ascending or descending).

#### Comparison Sorts

- **Bubble Sort** - O(n²) educational algorithm
- **Insertion Sort** - Efficient for nearly sorted data
- **Selection Sort** - Simple but inefficient
- **Merge Sort** - Stable O(n log n) divide-and-conquer
- **Quick Sort** - In-place O(n log n) average case
- **Heap Sort** - O(n log n) worst case

#### Non-comparison Sorts

- **Counting Sort** - Linear time for bounded integers
- **Radix Sort** - Digit-based sorting
- **Bucket Sort** - Uniform distribution assumption

### Searching Algorithms

Searching algorithms find specific elements within data structures.

#### Linear Search

- **Sequential Search** - O(n) simple iteration
- **Jump Search** - Step-optimized linear search
- **Interpolation Search** - Value-based estimation

#### Binary Search

- **Classic Binary Search** - O(log n) on sorted arrays
- **Lower/Upper Bound** - Range finding
- **Exponential Search** - Unknown size arrays

### Graph Algorithms

Graph algorithms operate on graph data structures for various problems.

#### Traversal

- **Depth-First Search (DFS)** - Stack-based exploration
- **Breadth-First Search (BFS)** - Queue-based exploration
- **Bidirectional Search** - Meet-in-the-middle approach

#### Shortest Path

- **Dijkstra's Algorithm** - Non-negative weights
- **Bellman-Ford** - Handles negative weights
- **Floyd-Warshall** - All pairs shortest paths
- **A* Search*\* - Heuristic-guided pathfinding

#### Minimum Spanning Tree

- **Kruskal's Algorithm** - Edge-based greedy approach
- **Prim's Algorithm** - Vertex-based greedy approach

### Dynamic Programming

Dynamic programming solves complex problems by breaking them into simpler subproblems.

#### Classic DP Problems

- **Fibonacci Sequence** - Optimal substructure example
- **Knapsack Problem** - Resource allocation optimization
- **Longest Common Subsequence** - Sequence alignment
- **Edit Distance** - String transformation cost

#### Advanced DP

- **Coin Change** - Combinatorial counting
- **Subset Sum** - Partition problems
- **Matrix Chain Multiplication** - Optimal parenthesization

### Greedy Algorithms

Greedy algorithms make locally optimal choices at each step.

#### Optimization Problems

- **Activity Selection** - Interval scheduling
- **Huffman Coding** - Prefix-free compression
- **Fractional Knapsack** - Divisible items optimization
- **Dijkstra's Algorithm** - Shortest path greedy approach

## Performance Analysis

### Time Complexity

| Algorithm | Best | Average | Worst | Space |
|-----------|------|---------|-------|-------|
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) |
| Binary Search | O(1) | O(log n) | O(log n) | O(1) |
| Dijkstra's | O(E + V log V) | O(E + V log V) | O(E + V log V) | O(V) |

### Space Complexity

- **In-place algorithms** - O(1) extra space
- **Recursive algorithms** - O(log n) to O(n) call stack
- **Dynamic programming** - O(n) to O(n²) for memoization

## Resources

### Books

- "Introduction to Algorithms" - CLRS
- "The Art of Computer Programming" - Donald Knuth
- "Algorithms" - Robert Sedgewick

### Online

- [Zig Algorithm Examples](https://github.com/ziglang/zig/tree/master/test/standalone)
- [Algorithm Visualizations](https://visualgo.net/)
- [Competitive Programming](https://codeforces.com/)
