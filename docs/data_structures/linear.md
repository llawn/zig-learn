# Linear Data Structures

!!! abstract "Sequential Organization"
    Linear data structures organize elements in a sequential manner, where each element has a direct successor and predecessor (except for the first and last elements).

## Overview

!!! info "Foundation of Computer Science"
    Linear structures form the backbone of most algorithms and applications. They include:

=== "Arrays"
    
    **Fixed-size, contiguous memory allocation**
    
    - O(1) random access
    - Cache-friendly performance
    - Memory efficient storage
    
=== "Linked Lists"  
    
    **Dynamic node-based structures**
    
    - Flexible sizing
    - Efficient insertions/deletions
    - Memory overhead per node
    
=== "Stacks"
    
    **LIFO (Last In, First Out) operations**
    
    - Function call management
    - Expression evaluation
    - Backtracking algorithms
    
=== "Queues"
    
    **FIFO (First In, First Out) operations**
    
    - Task scheduling
    - Breadth-first search
    - Resource management

## Detailed Implementations

=== "Arrays"
    
    !!! tip "Arrays provide O(1) access time and are the most fundamental data structure."
    
    **Key Features:**
    
    - Constant-time access by index: $T(1)$
    - Memory-efficient storage
    - Fixed size (static) or dynamic growth
    - Cache-friendly access patterns
    
    !!! example "Implementation Types"
        
        --8<-- "data_structures/01_linear/01_arrays.md"
    
    **When to Use:**
    
    !!! success "✓ Ideal for:"
        - Fast random access needed
        - Size known in advance
        - Memory usage critical
        - Cache performance matters
    
    !!! warning "✗ Avoid for:"
        - Frequent insertions/deletions
        - Unknown size requirements

=== "Linked Lists"
    
    !!! tip "Linked lists offer dynamic sizing and efficient insertions/deletions."
    
    **Types & Complexity:**
    
    | Type | Access | Insert | Delete | Space |
    |------|--------|--------|--------|-------|
    | Singly | O(n) | O(1) | O(1) | O(n) |
    | Doubly | O(n) | O(1) | O(1) | O(n) |
    | Circular | O(n) | O(1) | O(1) | O(n) |
    
    !!! example "Implementation Details"
        
        --8<-- "data_structures/01_linear/02_linked_list.md"
    
    **When to Use:**
    
    !!! success "✓ Ideal for:"
        - Frequent insertions/deletions
        - Unknown or variable size
        - Dynamic memory allocation needed
        - Implementing other data structures

=== "Stacks"
    
    !!! tip "Stacks follow LIFO principle and are essential for many algorithms."
    
    **Core Operations:**
    
    ```zig
    pub fn push(self: *Stack, value: T) !void
    pub fn pop(self: *Stack) ?T
    pub fn peek(self: *const Stack) ?T
    pub fn isEmpty(self: *const Stack) bool
    ```
    
    **Applications:**
    
    - Function call management
    - Expression evaluation  
    - Backtracking algorithms
    - Memory management

=== "Queues"
    
    !!! tip "Queues follow FIFO principle and are crucial for task scheduling."
    
    **Types & Use Cases:**
    
    | Type | Use Case | Complexity |
    |------|----------|------------|
    | Simple | Basic FIFO | O(1) |
    | Circular | Buffer management | O(1) |
    | Priority | Task scheduling | O(log n) |
    | Deque | Double-ended | O(1) |

## Performance Analysis

!!! comparison "Time & Space Complexity"

    | Structure | Access | Search | Insertion | Deletion | Space |
    |-----------|--------|--------|-----------|----------|-------|
    | Array | $O(1)$ | $O(n)$ | $O(n)$ | $O(n)$ | $O(n)$ |
    | Linked List | $O(n)$ | $O(n)$ | $O(1)$ | $O(1)$ | $O(n)$ |
    | Stack | $O(n)$ | $O(n)$ | $O(1)$ | $O(1)$ | $O(n)$ |
    | Queue | $O(n)$ | $O(n)$ | $O(1)$ | $O(1)$ | $O(n)$ |

## Decision Matrix

!!! grid "2"

    !!! card "📊 Arrays"
        ### When to Use:
        
        - Fast random access required
        - Size known in advance
        - Memory usage critical
        - Cache performance matters
        
        !!! warning "Trade-offs"
            - Inflexible size
            - Costly insertions/deletions

    !!! card "🔗 Linked Lists"  
        ### When to Use:
        
        - Frequent insertions/deletions
        - Unknown or variable size
        - Dynamic memory allocation needed
        - Building other data structures
        
        !!! warning "Trade-offs"
            - Slower random access
            - Extra memory overhead

    !!! card "📚 Stacks"
        ### When to Use:
        
        - LIFO behavior needed
        - Implementing recursion
        - Managing function calls
        - Backtracking algorithms
        
        !!! warning "Trade-offs"
            - Limited access patterns
            - Not suitable for random access

    !!! card "📋 Queues"
        ### When to Use:
        
        - FIFO behavior needed
        - Task scheduling
        - Breadth-first search
        - Resource management
        
        !!! warning "Trade-offs"
            - Limited access to middle elements
            - Memory overhead for some types

## Zig Advantages

!!! quote "Why Zig Excels for Data Structures"
    
    Zig provides several unique advantages for implementing linear data structures:
    
    !!! info "Memory Safety"
        Compile-time bounds checking prevents buffer overflows and ensures safe array access.
    
    !!! info "Zero-cost Abstractions"
        Generic programming without runtime overhead - your abstractions compile away to optimal code.
    
    !!! info "Explicit Memory Management"
        Full control over allocation patterns and the ability to implement custom allocators.
    
    !!! info "Comptime Magic"  
        Compile-time code generation and optimization enable type-specific optimizations.

!!! example "Zig in Action"

    ```zig title="Generic Stack Implementation"
    pub fn Stack(comptime T: type) type {
        return struct {
            const Self = @This();
            
            items: []T,
            capacity: usize,
            len: usize,
            allocator: std.mem.Allocator,
            
            pub fn push(self: *Self, item: T) !void {
                // Implementation with memory safety
                if (self.len >= self.capacity) {
                    try self.resize(self.capacity * 2);
                }
                self.items[self.len] = item;
                self.len += 1;
            }
        };
    }
    ```

<details>
<summary>📖 Mathematical Foundations</summary>

### Time Complexity Analysis

For arrays with $n$ elements:
- Access: $T(1)$ - direct memory addressing
- Search: $T(n) = \sum_{i=1}^{n} 1 = O(n)$ - linear scan
- Insert/Delete: $T(n) = \sum_{i=k}^{n} 1 = O(n-k) = O(n)$

For linked lists with $n$ nodes:
- Access/Search: $T(n) = \sum_{i=1}^{n} c = O(n)$ - traversing pointers
- Insert/Delete: $T(1)$ - pointer manipulation only

</details>
