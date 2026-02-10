# Practice Projects

This section contains hands-on coding projects that apply the data structures, algorithms, and design patterns learned throughout this repository.

## Overview

Practice projects bridge the gap between theoretical knowledge and practical application.
Each project is designed to reinforce specific concepts while building useful, real-world applications.

## Project Categories

### Data Structure Projects

#### Simple Calculator with Stack-Based Evaluation

**Concepts Applied:**

- Stacks (LIFO operations)
- Expression parsing
- Operator precedence

**Features:**

- Basic arithmetic operations (+, -, \*, /)
- Parentheses support
- Error handling for invalid expressions

**Implementation:**

```zig
pub fn Calculator(comptime T: type) type {
    return struct {
        values: std.ArrayList(T),
        operators: std.ArrayList(u8),

        pub fn evaluate(expression: []const u8) !T {
            // Parse and evaluate using stacks
        }
    };
}
```

#### File Compression Utility

**Concepts Applied:**

- Huffman coding
- Priority queues
- Tree structures
- Binary I/O

**Features:**

- Text file compression
- Decompression
- Compression ratio reporting

#### Pathfinding Visualizer

**Concepts Applied:**

- Graph algorithms (A\*, Dijkstra, BFS, DFS)
- Grid-based representation
- Real-time visualization
- Performance comparison

### Algorithm Projects

#### Sorting Algorithm Visualizer

**Concepts Applied:**

- Multiple sorting algorithms
- Performance comparison
- Visual representation
- Complexity analysis

**Features:**

- Animated sorting
- Step-by-step execution
- Performance metrics
- Algorithm comparison

#### Text Search Engine

**Concepts Applied:**

- String algorithms (KMP, Rabin-Karp, Boyer-Moore)
- Pattern matching
- Indexing structures
- Search optimization

**Features:**

- Multiple search algorithms
- Performance benchmarking
- Result highlighting
- Search statistics

#### Mini Database with B-tree Indexing

**Concepts Applied:**

- B-tree implementation
- File I/O operations
- Query optimization
- Transaction management

**Features:**

- CRUD operations
- B-tree indexing
- Query language (simple SQL-like)
- Persistence

### Design Pattern Projects

#### Text Editor with Undo/Redo

**Concepts Applied:**

- Command pattern
- Memento pattern
- Observer pattern
- Strategy pattern

**Features:**

- Text editing operations
- Undo/redo functionality
- Multiple file support
- Plugin architecture

#### Multi-threaded Web Server

**Concepts Applied:**

- Thread pool pattern
- Producer-consumer pattern
- Observer pattern
- Factory pattern

**Features:**

- HTTP request handling
- Connection pooling
- Static file serving
- Request logging

#### Plugin System

**Concepts Applied:**

- Abstract factory pattern
- Strategy pattern
- Observer pattern
- Dependency injection

**Features:**

- Dynamic plugin loading
- Plugin interface definition
- Plugin lifecycle management
- Configuration system

### Advanced Projects

#### Compiler Front-end

**Concepts Applied:**

- Parsing algorithms
- Abstract syntax trees
- Symbol tables
- Type systems

**Features:**

- Lexical analysis
- Syntax parsing
- Semantic analysis
- Error reporting

#### Distributed Key-Value Store

**Concepts Applied:**

- Consistent hashing
- Replication patterns
- Consensus algorithms
- Network programming

**Features:**

- Distributed storage
- Data replication
- Fault tolerance
- Client API

#### Game Engine Components

**Concepts Applied:**

- Entity-component system
- Spatial partitioning
- State machines
- Resource management

**Features:**

- Entity management
- Component systems
- Rendering pipeline
- Physics simulation

## Resources

### Learning Materials

- [Zig Documentation](https://ziglang.org/documentation/)
- [Algorithm Visualizations](https://visualgo.net/)
- [Design Patterns](https://refactoring.guru/design-patterns)

### Tools

- [Zig Build System](https://ziglang.org/documentation/master/#Build-System)
- [Testing Framework](https://ziglang.org/documentation/master/#Testing)
- [Profiler](https://ziglang.org/documentation/master/#Profiling)
