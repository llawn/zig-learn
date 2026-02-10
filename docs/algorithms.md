# Algorithms

!!! abstract "Algorithmic Thinking in Zig"
    This section covers the implementation of fundamental algorithms in Zig, organized by category and complexity. Each algorithm includes detailed analysis, performance characteristics, and practical applications.

## Overview

!!! info "What are Algorithms?"
    Algorithms are step-by-step procedures for solving problems and performing computations. In this repository, we implement various algorithms to understand their behavior, performance characteristics, and practical applications.

## Algorithm Categories

=== "Sorting Algorithms"
    
    !!! tip "Arranging elements in specific order"
    
    Sorting is fundamental to computer science and appears in countless applications.
    
    **Comparison Sorts:**
    
    | Algorithm | Best | Average | Worst | Space | Stable |
    |-----------|------|---------|-------|-------|--------|
    | Bubble | $O(n)$ | $O(n^2)$ | $O(n^2)$ | $O(1)$ | ✓ |
    | Insertion | $O(n)$ | $O(n^2)$ | $O(n^2)$ | $O(1)$ | ✓ |
    | Selection | $O(n^2)$ | $O(n^2)$ | $O(n^2)$ | $O(1)$ | ✗ |
    | Merge | $O(n \log n)$ | $O(n \log n)$ | $O(n \log n)$ | $O(n)$ | ✓ |
    | Quick | $O(n \log n)$ | $O(n \log n)$ | $O(n^2)$ | $O(\log n)$ | ✗ |
    | Heap | $O(n \log n)$ | $O(n \log n)$ | $O(n \log n)$ | $O(1)$ | ✗ |
    
    **Non-comparison Sorts:**
    
    - **Counting Sort** - $O(n + k)$ for bounded integers
    - **Radix Sort** - $O(d(n + k))$ digit-based sorting  
    - **Bucket Sort** - $O(n + k)$ for uniform distributions

=== "Searching Algorithms"
    
    !!! tip "Finding specific elements efficiently"
    
    **Linear Search Variants:**
    
    | Algorithm | Time | Space | Best For |
    |-----------|------|-------|----------|
    | Sequential | $O(n)$ | $O(1)$ | Small/unsorted arrays |
    | Jump Search | $O(\sqrt{n})$ | $O(1)$ | Sorted arrays |
    | Interpolation | $O(\log \log n)$ | $O(1)$ | Uniform distributions |
    
    **Binary Search Variants:**
    
    - **Classic Binary Search** - $O(\log n)$ on sorted arrays
    - **Lower/Upper Bound** - Range finding
    - **Exponential Search** - Unknown size arrays

=== "Graph Algorithms"
    
    !!! tip "Navigating connected data structures"
    
    **Traversal:**
    
    ```mermaid
    graph TD
        A[Start] --> B{Choose Strategy}
        B -->|Depth-First| C[Stack-based]
        B -->|Breadth-First| D[Queue-based]
        C --> E[Visit Deep First]
        D --> F[Visit Level by Level]
    ```
    
    **Shortest Path:**
    
    | Algorithm | Time | Space | Handles |
    |-----------|------|-------|---------|
    | Dijkstra's | $O(E + V \log V)$ | $O(V)$ | Non-negative weights |
    | Bellman-Ford | $O(VE)$ | $O(V)$ | Negative weights |
    | Floyd-Warshall | $O(V^3)$ | $O(V^2)$ | All pairs |
    | A* | $O(E)$ | $O(V)$ | Heuristic-guided |

=== "Dynamic Programming"
    
    !!! tip "Breaking problems into optimal subproblems"
    
    DP solves complex problems by identifying optimal substructure and overlapping subproblems.
    
    **Classic DP Problems:**
    
    | Problem | State | Recurrence | Time | Space |
    |---------|-------|------------|------|-------|
    | Fibonacci | $F(n)$ | $F(n) = F(n-1) + F(n-2)$ | $O(n)$ | $O(1)$ |
    | Knapsack | $dp[i][w]$ | $dp[i][w] = \max(dp[i-1][w], dp[i-1][w-w_i] + v_i)$ | $O(nW)$ | $O(nW)$ |
    | LCS | $dp[i][j]$ | $dp[i][j] = dp[i-1][j-1] + 1$ if match | $O(mn)$ | $O(mn)$ |
    
    **Advanced DP:**
    
    - **Coin Change** - $O(nS)$ combinatorial counting
    - **Subset Sum** - $O(nS)$ partition problems  
    - **Matrix Chain** - $O(n^3)$ optimal parenthesization

=== "Greedy Algorithms"
    
    !!! tip "Making locally optimal choices"
    
    Greedy algorithms make the best choice at each step, hoping for a globally optimal solution.
    
    **Optimization Problems:**
    
    | Problem | Greedy Choice | Optimal | Complexity |
    |---------|---------------|---------|------------|
    | Activity Selection | Earliest finish | ✓ | $O(n \log n)$ |
    | Huffman Coding | Min frequency | ✓ | $O(n \log n)$ |
    | Fractional Knapsack | Max value/weight | ✓ | $O(n \log n)$ |
    | 0/1 Knapsack | Max value/weight | ✗ | $O(nW)$ (DP needed) |

## Performance Analysis

!!! chart "Algorithm Complexity Overview"

    ```mermaid
    xychart-beta
        title "Time Complexity Growth Rates"
        x-axis "Input Size (n)" [1, 10, 100, 1000, 10000]
        y-axis "Operations" [0, 100, 1000, 10000, 100000, 1000000]
        line "O(1)" [1, 1, 1, 1, 1]
        line "O(log n)" [0, 3.3, 6.6, 10, 13.3]
        line "O(n)" [1, 10, 100, 1000, 10000]
        line "O(n log n)" [0, 33, 660, 10000, 132000]
        line "O(n²)" [1, 100, 10000, 1000000, 100000000]
    ```

### Detailed Complexity Analysis

| Algorithm | Best | Average | Worst | Space | When to Use |
|-----------|------|---------|-------|-------|-------------|
| Quick Sort | $O(n \log n)$ | $O(n \log n)$ | $O(n^2)$ | $O(\log n)$ | General purpose, in-place |
| Merge Sort | $O(n \log n)$ | $O(n \log n)$ | $O(n \log n)$ | $O(n)$ | Stable sort needed |
| Binary Search | $O(1)$ | $O(\log n)$ | $O(\log n)$ | $O(1)$ | Sorted arrays |
| Dijkstra's | $O(E + V \log V)$ | $O(E + V \log V)$ | $O(E + V \log V)$ | $O(V)$ | Non-negative weights |

### Space Complexity Categories

!!! info "Memory Usage Patterns"

    - **In-place algorithms** - $O(1)$ extra space, modify input
    - **Recursive algorithms** - $O(\log n)$ to $O(n)$ call stack overhead
    - **Dynamic programming** - $O(n)$ to $O(n^2)$ for memoization tables
    - **Graph algorithms** - $O(V + E)$ for adjacency structures

## Implementation Patterns

!!! example "Zig Algorithm Template"

    ```zig title="Generic Binary Search"
    pub fn binarySearch(
        comptime T: type,
        items: []const T,
        key: T,
        compare: fn (a: T, b: T) std.math.Order,
    ) ?usize {
        var left: usize = 0;
        var right = items.len;
        
        while (left < right) {
            const mid = left + (right - left) / 2;
            switch (compare(items[mid], key)) {
                .lt => left = mid + 1,
                .gt => right = mid,
                .eq => return mid,
            }
        }
        
        return null;
    }
    ```

## Learning Resources

!!! grid "2"

    !!! card "📚 Essential Reading"
        
        ### Books
        
        - "Introduction to Algorithms" - CLRS
        - "The Art of Computer Programming" - Donald Knuth  
        - "Algorithms" - Robert Sedgewick
        - "Algorithm Design Manual" - Steven Skiena

    !!! card "🌐 Online Resources"
        
        ### Interactive Learning
        
        - [Zig Algorithm Examples](https://github.com/ziglang/zig/tree/master/test/standalone)
        - [Algorithm Visualizations](https://visualgo.net/)
        - [Competitive Programming](https://codeforces.com/)
        - [LeetCode](https://leetcode.com/)

!!! question "Practice Problems"
    
    Start with these classic problems to build your algorithmic thinking:
    
    1. **Two Sum** - Hash table practice
    2. **Valid Parentheses** - Stack applications  
    3. **Merge Intervals** - Sorting + greedy
    4. **Climbing Stairs** - DP fundamentals
    5. **Maximum Subarray** - Kadane's algorithm
