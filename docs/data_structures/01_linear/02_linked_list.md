# Linked Lists

Linked lists are dynamic data structures consisting of nodes, where each node contains data and a pointer to the next node in the sequence.

## Overview

Linked lists provide an alternative to arrays when you need frequent insertions and deletions, or when the size of the data structure is unknown.

## Types of Linked Lists

### Singly Linked Lists

Each node points only to the next node.

**Characteristics:**

- Unidirectional traversal
- Memory efficient
- Simple implementation
- O(n) search time

### Doubly Linked Lists

Each node points to both the next and previous nodes.

**Characteristics:**

- Bidirectional traversal
- More memory usage
- Complex implementation
- O(n) search time

### Circular Linked Lists

The last node points back to the first node.

**Characteristics:**

- No null pointers
- Useful for round-robin scheduling
- Infinite traversal without null checks
- O(n) search time

## Implementation

### Basic Node Structure

```zig
pub fn Node(comptime T: type) type {
    return struct {
        data: T,
        next: ?*Node(T),
    };
}
```

### Singly Linked List

```zig
pub fn SinglyLinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        head: ?*Node(T) = null,
        len: usize = 0,

        pub fn append(self: *Self, allocator: std.mem.Allocator, data: T) !void {
            ...
        }

        pub fn remove(self: *Self, allocator: std.mem.Allocator, index: usize) !T {
            ...
        }
    };
}
```

## Performance Analysis

| Operation | Singly | Doubly | Circular |
|-----------|--------|--------|----------|
| Access | O(n) | O(n) | O(n) |
| Search | O(n) | O(n) | O(n) |
| Insert (head) | O(1) | O(1) | O(1) |
| Insert (tail) | O(n) | O(1) | O(1) |
| Delete (head) | O(1) | O(1) | O(1) |
| Delete (tail) | O(n) | O(1) | O(1) |
| Delete (middle) | O(n) | O(n) | O(n) |

## Common Operations

### Traversal

```zig
pub fn traverse(list: *SinglyLinkedList(T)) void {
    var current = list.head;
    while (current) |node| {
        std.debug.print("{}\n", .{node.data});
        current = node.next;
    }
}
```

### Search

```zig
pub fn find(list: *SinglyLinkedList(T), target: T) ?*Node(T) {
    var current = list.head;
    while (current) |node| {
        if (node.data == target) {
            return node;
        }
        current = node.next;
    }
    return null;
}
```

### Reversal

```zig
pub fn reverse(list: *SinglyLinkedList(T)) void {
    var prev: ?*Node(T) = null;
    var current = list.head;
    var next: ?*Node(T) = null;

    while (current) |node| {
        next = node.next;
        node.next = prev;
        prev = node;
        current = next;
    }

    list.head = prev;
}
```

## Use Cases

### When to Use Linked Lists

- **Dynamic sizing** - When size is unknown or variable
- **Frequent insertions/deletions** - Especially at ends
- **Memory constraints** - When you can't allocate large contiguous blocks
- **Implementation of other structures** - Stacks, queues, graphs

### When to Avoid Linked Lists

- **Random access needed** - Arrays are better for O(1) access
- **Cache performance critical** - Arrays have better locality
- **Memory overhead concern** - Linked lists have pointer overhead
- **Simple data storage** - Arrays are simpler for basic storage

## Zig-Specific Advantages

### Memory Safety

- **Explicit allocation** - Clear control over memory management
- **Optional pointers** - Safe handling of null references
- **Bounds checking** - Runtime safety in debug builds

### Performance

- **Zero-cost abstractions** - No runtime overhead for generics
- **Comptime features** - Compile-time optimization opportunities
- **Inline functions** - Potential for function inlining

### Type Safety

- **Strong typing** - Compile-time type checking
- **Generic programming** - Type-safe implementations
- **Error handling** - Explicit error propagation

## Advanced Topics

### Skip Lists

Probabilistic data structure that provides O(log n) search time while maintaining linked list simplicity.

### Memory Pools

Custom allocators for efficient node allocation and deallocation.

### Lock-Free Implementations

Concurrent linked lists using atomic operations for thread safety.

## Best Practices

- **Always initialize pointers** - Use null for empty lists
- **Proper memory management** - Free all allocated nodes
- **Handle edge cases** - Empty list, single node, etc.
- **Use appropriate list type** - Choose based on requirements
- **Consider cache performance** - For large datasets

## Running the Examples

```bash
zig run data_structures/01_linear/02_linked_list.zig
```

This will demonstrate all linked list types with practical examples showing:

- Node creation and linking
- Traversal patterns
- Search operations
- Memory management
- Performance characteristics
