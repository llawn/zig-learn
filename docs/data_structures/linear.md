# Linear Data Structures

Linear data structures organize elements in a sequential manner, where each element has a direct successor and predecessor (except for the first and last elements).

## Overview

Linear structures are the foundation of computer science and include:

- **Arrays** - Fixed-size, contiguous memory allocation
- **Linked Lists** - Dynamic node-based structures
- **Stacks** - LIFO (Last In, First Out) operations
- **Queues** - FIFO (First In, First Out) operations

## Implementations

### Arrays

Arrays provide O(1) access time and are the most fundamental data structure.

**Key Features:**

- Constant-time access by index
- Memory-efficient storage
- Fixed size (static arrays) or dynamic growth
- Cache-friendly access patterns

**Examples:**

- Static Arrays - Basic array operations
- Dynamic Arrays - Resizable array implementations
- Multi-dimensional Arrays - Matrices and tensors
- Circular Arrays - Ring buffers
- Sparse Arrays - Memory-efficient for mostly empty data

### Linked Lists

Linked lists offer dynamic sizing and efficient insertions/deletions.

**Types:**

- Singly Linked Lists
- Doubly Linked Lists
- Circular Linked Lists
- Skip Lists

### Stacks

Stacks follow LIFO principle and are essential for many algorithms.

**Applications:**

- Function call management
- Expression evaluation
- Backtracking algorithms
- Memory management

### Queues

Queues follow FIFO principle and are crucial for task scheduling.

**Types:**

- Simple Queues
- Circular Queues
- Priority Queues
- Double-ended Queues

## Performance Comparison

| Structure | Access | Search | Insertion | Deletion | Space |
|-----------|--------|--------|-----------|----------|-------|
| Array | O(1) | O(n) | O(n) | O(n) | O(n) |
| Linked List | O(n) | O(n) | O(1) | O(1) | O(n) |
| Stack | O(n) | O(n) | O(1) | O(1) | O(n) |
| Queue | O(n) | O(n) | O(1) | O(1) | O(n) |

## When to Use Each Structure

### Use Arrays when:

- You need fast random access
- The size is known in advance
- Memory usage is critical
- Cache performance matters

### Use Linked Lists when:

- You need frequent insertions/deletions
- The size is unknown or variable
- You need dynamic memory allocation
- You're implementing other data structures

### Use Stacks when:

- You need LIFO behavior
- Implementing recursion
- Managing function calls
- Backtracking algorithms

### Use Queues when:

- You need FIFO behavior
- Task scheduling
- Breadth-first search
- Resource management

## Zig-Specific Considerations

Zig provides several advantages for implementing linear data structures:

- **Memory Safety**: Compile-time bounds checking
- **Zero-cost Abstractions**: Generic programming without runtime overhead
- **Explicit Memory Management**: Full control over allocation
- **Comptime**: Compile-time code generation and optimization
