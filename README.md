[![Zig](https://img.shields.io/badge/Zig-%23F7A41D.svg?style=for-the-badge&logo=zig&logoColor=white)](https://ziglang.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/llawn/zig-learn?style=for-the-badge&logo=github)](https://github.com/llawn/zig-learn)

# Zig-Learn

A comprehensive journey through the implementation of fundamental computer science concepts using the Zig Programming Language.
This repository serves as a personal laboratory.

## Table of Contents

- [Data Structures](#data-structures)
  - [Linear Structures](#linear-structures)
  - [Tree Structures](#tree-structures)
  - [Graph Structures](#graph-structures)
  - [Hash-based Structures](#hash-based-structures)
  - [Specialized Structures](#specialized-structures)
- [Algorithms](#algorithms)
  - [Sorting Algorithms](#sorting-algorithms)
  - [Searching Algorithms](#searching-algorithms)
  - [Graph Algorithms](#graph-algorithms)
  - [Dynamic Programming](#dynamic-programming)
  - [Greedy Algorithms](#greedy-algorithms)
  - [Divide and Conquer](#divide-and-conquer)
  - [String Algorithms](#string-algorithms)
  - [Mathematical Algorithms](#mathematical-algorithms)
- [Design Patterns](#design-patterns)
  - [Creational Patterns](#creational-patterns)
  - [Structural Patterns](#structural-patterns)
  - [Behavioral Patterns](#behavioral-patterns)
  - [Concurrency Patterns](#concurrency-patterns)

## Data Structures

### Linear Structures

#### 1. Arrays

- [x] **Static Arrays**: Fixed-size, contiguous memory
- [x] **Dynamic Arrays**: Resizable, memory management
- [x] **Multi-dimensional Arrays**: Matrices, tensors
- [x] **Circular Arrays**: Buffer implementations
- [x] **Sparse Arrays**: Memory-efficient for mostly empty data

#### 2. Linked Lists

- [ ] **Singly Linked Lists**: Basic pointer chain
- [ ] **Doubly Linked Lists**: Bidirectional traversal
- [ ] **Circular Linked Lists**: Loop termination detection
- [ ] **Skip Lists**: Probabilistic search structures
- [ ] **Self-organizing Lists**: Access frequency optimization

#### 3. Stacks

- [ ] **Array-based Stacks**: Fixed or dynamic capacity
- [ ] **Linked List Stacks**: Dynamic growth
- [ ] **Application**: Expression evaluation, function calls
- [ ] **Variants**: Monotonic stacks, span stacks

#### 4. Queues

- [ ] **Simple Queues**: FIFO operations
- [ ] **Circular Queues**: Fixed-size ring buffer
- [ ] **Priority Queues**: Heap-based ordering
- [ ] **Double-ended Queues**: Operations at both ends
- [ ] **Blocking Queues**: Thread synchronization

### Tree Structures

#### 1. Binary Trees

- [ ] **Binary Search Trees**: Ordered key-value pairs
- [ ] **AVL Trees**: Self-balancing with rotations
- [ ] **Red-Black Trees**: Color-based balancing
- [ ] **Splay Trees**: Access-frequency optimization
- [ ] **Treaps**: Randomized BST+Heap hybrid

#### 2. Multi-way Trees

- [ ] **B-Trees**: Disk-optimized storage
- [ ] **B+ Trees**: Efficient range queries
- [ ] **B* Trees*\*: Space-optimized B-trees
- [ ] **Tries**: Prefix-based string storage
- [ ] **Patricia Tries**: Space-efficient tries

#### 3. Specialized Trees

- [ ] **Segment Trees**: Range query optimization
- [ ] **Fenwick Trees**: Binary Indexed Trees
- [ ] **KD-Trees**: Multi-dimensional nearest neighbor
- [ ] **R-Trees**: Spatial data indexing
- [ ] **Huffman Trees**: Optimal prefix codes

#### 4. Heaps

- [ ] **Binary Heaps**: Complete tree property
- [ ] **Fibonacci Heaps**: Amortized efficiency
- [ ] **Binomial Heaps**: Merge-optimized
- [ ] **Pairing Heaps**: Practical performance
- [ ] **D-ary Heaps**: Multi-branch optimization

### Graph Structures

#### 1. Graph Representations

- [ ] **Adjacency Matrix**: O(- [ ] edge existence
- [ ] **Adjacency Lists**: Space-efficient sparse graphs
- [ ] **Edge Lists**: Simple iteration
- [ ] **Incidence Matrix**: Edge-vertex relationships
- [ ] **Compressed Sparse Row**: Memory efficiency

#### 2. Specialized Graphs

- [ ] **Directed Acyclic Graphs**: Topological ordering
- [ ] **Bipartite Graphs**: Two-colorable structures
- [ ] **Trees**: Connected acyclic graphs
- [ ] **Forests**: Disjoint trees
- [ ] **Planar Graphs**: 2D embeddable structures

#### 3. Graph Variants

- [ ] **Weighted Graphs**: Edge costs/distances
- [ ] **Multi-graphs**: Parallel edges
- [ ] **Hypergraphs**: Multi-vertex edges
- [ ] **Dynamic Graphs**: Incremental updates
- [ ] **Persistent Graphs**: Version control

### Hash-based Structures

#### - [ ] Hash Tables

- [ ] **Separate Chaining**: Linked list buckets
- [ ] **Open Addressing**: Linear probing
- [ ] **Quadratic Probing**: Reduced clustering
- [ ] **Double Hashing**: Multiple hash functions
- [ ] **Cuckoo Hashing**: Constant-time worst case

#### 2. Hash Variants

- [ ] **Bloom Filters**: Probabilistic membership
- [ ] **Count-Min Sketch**: Frequency estimation
- [ ] **HyperLogLog**: Cardinality estimation
- [ ] **Consistent Hashing**: Distributed systems
- [ ] **Locality-Sensitive Hashing**: Similarity search

### Specialized Structures

#### 1. Geometric Structures

- [ ] **Quad Trees**: 2D spatial partitioning
- [ ] **Oct Trees**: 3D spatial partitioning
- [ ] **Voronoi Diagrams**: Nearest neighbor regions
- [ ] **Delaunay Triangulation**: Optimal triangulation
- [ ] **Bounding Volume Hierarchies**: Collision detection

#### 2. String Structures

- [ ] **Suffix Arrays**: Linear time construction
- [ ] **Suffix Trees**: Full substring search
- [ ] **Rope Structures**: Efficient string editing
- [ ] **Ternary Search Trees**: Memory-efficient tries
- [ ] **Burrows-Wheeler Transform**: Compression preprocessing

#### 3. Memory Structures

- [ ] **Memory Pools**: Fixed-size allocation
- [ ] **Arena Allocators**: Bulk deallocation
- [ ] **Buddy Allocators**: Power-of-two blocks
- [ ] **Slab Allocators**: Object caching
- [ ] **Garbage Collected**: Automatic reclamation

## Algorithms

### Sorting Algorithms

#### 1. Comparison Sorts

- [ ] **Bubble Sort**: O(n²) educational
- [ ] **Insertion Sort**: Nearly sorted data
- [ ] **Selection Sort**: Minimization approach
- [ ] **Merge Sort**: Stable O(n log n)
- [ ] **Quick Sort**: In-place O(n log n) average
- [ ] **Heap Sort**: O(n log n) worst case
- [ ] **Tim Sort**: Hybrid optimization
- [ ] **Intro Sort**: Quick+Heap+Insertion hybrid

#### 2. Non-comparison Sorts

- [ ] **Counting Sort**: Integer range bounded
- [ ] **Radix Sort**: Digit-based sorting
- [ ] **Bucket Sort**: Uniform distribution
- [ ] **Pigeonhole Sort**: Small range integers
- [ ] **Flash Sort**: Approximate median pivot

#### 3. Specialized Sorts

- [ ] **External Sorts**: Disk-based sorting
- [ ] **Parallel Sorts**: Multi-threaded optimization
- [ ] **Network Sorts**: Distributed sorting
- [ ] **Stable Partitioning**: Group-based ordering
- [ ] **Adaptive Sorts**: Input-aware optimization

### Searching Algorithms

#### 1. Linear Search

- [ ] **Sequential Search**: O(n) complexity
- [ ] **Jump Search**: Step-optimized linear
- [ ] **Interpolation Search**: Value-based estimation
- [ ] **Exponential Search**: Unknown size arrays
- [ ] **Block Search**: Group-based optimization

#### 2. Binary Search

- [ ] **Classic Binary Search**: O(log n) complexity
- [ ] **Lower/Upper Bound**: Range finding
- [ ] **Binary Search Trees**: Dynamic search structure
- [ ] **Fibonacci Search**: Divide by golden ratio
- [ ] **Ternary Search**: Three-way partitioning

#### 3. Advanced Search

- [ ] **Ternary Search Trees**: Pattern matching
- [ ] **A* Search*\*: Heuristic pathfinding
- [ ] **IDA* Search*\*: Memory-efficient A\*
- [ ] **Monte Carlo Tree Search**: Game playing
- [ ] **Simulated Annealing**: Optimization search

### Graph Algorithms

#### 1. Traversal Algorithms

- [ ] **Depth-First Search**: Stack-based exploration
- [ ] **Breadth-First Search**: Queue-based exploration
- [ ] **Bidirectional Search**: Meet-in-the-middle
- [ ] **Iterative Deepening DFS**: Memory efficiency
- [ ] **Uniform Cost Search**: Weighted shortest path

#### 2. Shortest Path Algorithms

- [ ] **Dijkstra's Algorithm**: Non-negative weights
- [ ] **Bellman-Ford Algorithm**: Negative weights
- [ ] **Floyd-Warshall Algorithm**: All pairs shortest path
- [ ] **Johnson's Algorithm**: Sparse all-pairs
- [ ] **A* Algorithm*\*: Heuristic-guided search

#### 3. Minimum Spanning Tree

- [ ] **Kruskal's Algorithm**: Edge-based greedy
- [ ] **Prim's Algorithm**: Vertex-based greedy
- [ ] **Borůvka's Algorithm**: Parallel MST
- [ ] **Reverse-Delete Algorithm**: Complementary approach
- [ ] **Chu-Liu/Edmonds**: Directed MST

#### 4. Network Flow

- [ ] **Ford-Fulkerson**: Augmenting paths
- [ ] **Edmonds-Karp**: BFS augmenting paths
- [ ] **Dinic's Algorithm**: Level graph approach
- [ ] **Push-Relabel**: Vertex-based algorithm
- [ ] **Min-cost Max-flow**: Cost optimization

#### 5. Graph Connectivity

- [ ] **Strong Components**: Kosaraju/Tarjan
- [ ] **Biconnected Components**: Articulation points
- [ ] **Bridge Finding**: Critical edges
- [ ] **Tree Isomorphism**: Structure equality
- [ ] **Graph Coloring**: Vertex assignment

### Dynamic Programming

#### 1. Classic DP Problems

- [ ] **Fibonacci Sequence**: Optimal substructure
- [ ] **Knapsack Problem**: Resource allocation
- [ ] **Longest Common Subsequence**: Sequence alignment
- [ ] **Edit Distance**: String transformation
- [ ] **Matrix Chain Multiplication**: Parenthesization

#### 2. Advanced DP

- [ ] **Coin Change**: Combinatorial counting
- [ ] **Subset Sum**: Partition problems
- [ ] **Travelling Salesman**: Optimal tours
- [ ] **Longest Increasing Subsequence**: Monotonic subsequences
- [ ] **Box Stacking**: Multi-dimensional packing

#### 3. DP Techniques

- [ ] **Memoization**: Top-down caching
- [ ] **Tabulation**: Bottom-up iteration
- [ ] **Space Optimization**: Rolling arrays
- [ ] **Divide and Conquer DP**: Matrix multiplication
- [ ] **Bitmask DP**: Subset enumeration

### Greedy Algorithms

#### - [ ] Optimization Problems

- [ ] **Activity Selection**: Interval scheduling
- [ ] **Huffman Coding**: Prefix-free compression
- [ ] **Job Sequencing**: Deadline optimization
- [ ] **Fractional Knapsack**: Divisible items
- [ ] **Dijkstra's Algorithm**: Greedy shortest path

#### 2. Approximation Algorithms

- [ ] **Vertex Cover**: 2-approximation
- [ ] **Set Cover**: Logarithmic approximation
- [ ] **TSP Approximation**: Triangle inequality
- [ ] **Steiner Tree**: Network design
- [ ] **Maximum Independent Set**: Graph coloring

### Divide and Conquer

#### 1. Classic Algorithms

- [ ] **Merge Sort**: Divide-merge paradigm
- [ ] **Quick Sort**: Partitioning strategy
- [ ] **Binary Search**: Halving search space
- [ ] **Closest Pair**: Computational geometry
- [ ] **Convex Hull**: Geometric algorithms

#### 2. Advanced Applications

- [ ] **Strassen's Matrix**: Fast multiplication
- [ ] **Karatsuba Multiplication**: Large integer multiplication
- [ ] **Fast Fourier Transform**: Signal processing
- [ ] **Range Minimum Query**: Sparse tables
- [ ] **Order Statistics**: Selection algorithms

### String Algorithms

#### 1. Pattern Matching

- [ ] **Knuth-Morris-Pratt**: Prefix function
- [ ] **Boyer-Moore**: Reverse scanning
- [ ] **Rabin-Karp**: Rolling hash
- [ ] **Aho-Corasick**: Multi-pattern search
- [ ] **Suffix Arrays**: Efficient pattern matching

#### 2. String Processing

- [ ] **Longest Palindrome**: Manacher's algorithm
- [ ] **String Reversal**: In-place operations
- [ ] **Anagram Detection**: Character counting
- [ ] **String Compression**: Run-length encoding
- [ ] **Edit Operations**: Levenshtein distance

### Mathematical Algorithms

#### 1. Number Theory

- [ ] **GCD Algorithms**: Euclidean, extended
- [ ] **Prime Testing**: Miller-Rabin, deterministic
- [ ] **Prime Generation**: Sieve of Eratosthenes
- [ ] **Factorization**: Pollard's Rho
- [ ] **Modular Arithmetic**: Power, inverse

#### 2. Combinatorics

- [ ] **Permutations**: Heap's algorithm
- [ ] **Combinations**: Pascal's triangle
- [ ] **Gray Codes**: Binary sequence generation
- [ ] **N-Queens**: Backtracking solution
- [ ] **Sudoku**: Constraint satisfaction

#### 3. Numerical Algorithms

- [ ] **Square Root**: Newton's method
- [ ] **Exponentiation**: Fast powering
- [ ] **Matrix Operations**: Inverse, determinant
- [ ] **Interpolation**: Polynomial fitting
- [ ] **Numerical Integration**: Trapezoidal, Simpson

## Design Patterns

### Creational Patterns

#### 1. Singleton Pattern

- [ ] **Purpose**: Ensure single instance globally
- [ ] **Use Cases**: Configuration managers, connection pools
- [ ] **Zig Implementation**: Static variables, lazy initialization
- [ ] **Variants**: Thread-safe, eager/lazy loading

#### 2. Factory Method Pattern

- [ ] **Purpose**: Create objects without specifying exact class
- [ ] **Use Cases**: Plugin systems, configurable object creation
- [ ] **Zig Implementation**: Enum-based dispatch, function pointers
- [ ] **Variants**: Abstract factory, simple factory

#### 3. Builder Pattern

- [ ] **Purpose**: Construct complex objects step-by-step
- [ ] **Use Cases**: Configuration objects, SQL queries
- [ ] **Zig Implementation**: Struct chaining, optional fields
- [ ] **Variants**: Fluent interface, immutable builders

#### 4. Prototype Pattern

- [ ] **Purpose**: Create objects by copying existing ones
- [ ] **Use Cases**: Object cloning, performance optimization
- [ ] **Zig Implementation**: Deep copy functions, clone methods
- [ ] **Variants**: Shallow vs deep copying

#### 5. Abstract Factory Pattern

- [ ] **Purpose**: Create families of related objects
- [ ] **Use Cases**: UI toolkits, database connectors
- [ ] **Zig Implementation**: Interface structs, factory composition
- [ ] **Variants**: Platform-specific factories

### Structural Patterns

#### 1. Adapter Pattern

- [ ] **Purpose**: Make incompatible interfaces work together
- [ ] **Use Cases**: Legacy code integration, format conversion
- [ ] **Zig Implementation**: Wrapper structs, interface translation
- [ ] **Variants**: Object vs class adapters

#### 2. Decorator Pattern

- [ ] **Purpose**: Add responsibilities to objects dynamically
- [ ] **Use Cases**: UI components, stream processing
- [ ] **Zig Implementation**: Composition, method forwarding
- [ ] **Variants**: Stacked decorators, transparent decorators

#### 3. Proxy Pattern

- [ ] **Purpose**: Provide placeholder for another object
- [ ] **Use Cases**: Lazy loading, access control, caching
- [ ] **Zig Implementation**: Forwarding structs, smart pointers
- [ ] **Variants**: Virtual proxy, protection proxy, remote proxy

#### 4. Composite Pattern

- [ ] **Purpose**: Compose objects into tree structures
- [ ] **Use Cases**: UI hierarchies, file systems
- [ ] **Zig Implementation**: Recursive structs, unified interface
- [ ] **Variants**: Transparent vs safe composites

#### 5. Facade Pattern

- [ ] **Purpose**: Simplify interface to complex subsystem
- [ ] **Use Cases**: API design, library wrappers
- [ ] **Zig Implementation**: High-level functions, internal hiding
- [ ] **Variants**: Multiple facades, layered facades

#### 6. Flyweight Pattern

- [ ] **Purpose**: Minimize memory usage through sharing
- [ ] **Use Cases**: Text rendering, game objects
- [ ] **Zig Implementation**: Object pools, canonical instances
- [ ] **Variants**: Intrinsic vs extrinsic state

#### 7. Bridge Pattern

- [ ] **Purpose**: Decouple abstraction from implementation
- [ ] **Use Cases**: Platform independence, multiple implementations
- [ ] **Zig Implementation**: Interface structs, implementation separation
- [ ] **Variants**: Adaptive interfaces

### Behavioral Patterns

#### 1. Strategy Pattern

- [ ] **Purpose**: Define family of algorithms, make them interchangeable
- [ ] **Use Cases**: Sorting algorithms, compression methods
- [ ] **Zig Implementation**: Function pointers, enum-based selection
- [ ] **Variants**: Context-aware strategies

#### 2. Observer Pattern

- [ ] **Purpose**: Define one-to-many dependency
- [ ] **Use Cases**: Event systems, UI updates
- [ ] **Zig Implementation**: Callback registration, pub/sub systems
- [ ] **Variants**: Push vs pull models

#### 3. Command Pattern

- [ ] **Purpose**: Encapsulate request as object
- [ ] **Use Cases**: Undo/redo systems, macro recording
- [ ] **Zig Implementation**: Struct with execute method, command queue
- [ ] **Variants**: Composite commands, smart commands

#### 4. State Pattern

- [ ] **Purpose**: Allow object to change behavior when state changes
- [ ] **Use Cases**: Game characters, protocol implementations
- [ ] **Zig Implementation**: State machines, polymorphic behavior
- [ ] **Variants**: State tables, hierarchical states

#### 5. Template Method Pattern

- [ ] **Purpose**: Define skeleton of algorithm, let subclasses override
- [ ] **Use Cases**: Algorithms with variable steps, frameworks
- [ ] **Zig Implementation**: Function pointers, hook functions
- [ ] **Variants**: Hook methods, strategy-based templates

#### 6. Iterator Pattern

- [ ] **Purpose**: Access elements sequentially without exposing representation
- [ ] **Use Cases**: Collection traversal, database cursors
- [ ] **Zig Implementation**: Next() function, state management
- [ ] **Variants**: Internal vs external iterators

#### 7. Mediator Pattern

- [ ] **Purpose**: Define centralized communication between objects
- [ ] **Use Cases**: Chat systems, GUI components
- [ ] **Zig Implementation**: Central coordinator, message passing
- [ ] **Variants**: Colleague objects, broadcast mediators

#### 8. Chain of Responsibility

- [ ] **Purpose**: Pass request along chain of handlers
- [ ] **Use Cases**: Event handling, middleware pipelines
- [ ] **Zig Implementation**: Linked handlers, successor chaining
- [ ] **Variants**: Pure chains, composite handlers

#### 9. Visitor Pattern

- [ ] **Purpose**: Add new operations to object structure without modification
- [ ] **Use Cases**: Code generation, document processing
- [ ] **Zig Implementation**: Double dispatch, operation interfaces
- [ ] **Variants**: Visitable objects, composite visitors

### Concurrency Patterns

#### 1. Producer-Consumer Pattern

- [ ] **Purpose**: Coordinate production and consumption of data
- [ ] **Use Cases**: Task queues, data pipelines
- [ ] **Zig Implementation**: Channels, async/await, mutex/condition variables
- [ ] **Variants**: Bounded vs unbounded queues

#### 2. Thread Pool Pattern

- [ ] **Purpose**: Reuse threads for executing tasks
- [ ] **Use Cases**: Web servers, parallel processing
- [ ] **Zig Implementation**: Worker threads, task queue, synchronization
- [ ] **Variants**: Fixed vs dynamic pool sizes

#### 3. Read-Write Lock Pattern

- [ ] **Purpose**: Allow multiple readers, exclusive writers
- [ ] **Use Cases**: Caching systems, configuration management
- [ ] **Zig Implementation**: Atomic counters, condition variables
- [ ] **Variants**: Writer-preferring, reader-preferring

#### 4. Future/Promise Pattern

- [ ] **Purpose**: Handle asynchronous operations
- [ ] **Use Cases**: Network requests, computations
- [ ] **Zig Implementation**: Async functions, completion callbacks
- [ ] **Variants**: Futures, promises, deferred execution

#### 5. Actor Pattern

- [ ] **Purpose**: Concurrent computation through message passing
- [ ] **Use Cases**: Distributed systems, game engines
- [ ] **Zig Implementation**: Message queues, state isolation
- [ ] **Variants**: Supervised actors, actor hierarchies

## Practice Projects

- [ ] Simple calculator with stack-based evaluation
- [ ] Text editor with undo/redo functionality
- [ ] File compression utility using Huffman coding
- [ ] Pathfinding visualizer with multiple algorithms
- [ ] Mini database with B-tree indexing
- [ ] Multi-threaded web server with connection pooling
- [ ] Compiler front-end with parse tree generation
- [ ] Distributed key-value store with consistent hashing
