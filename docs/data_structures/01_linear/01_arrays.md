# Arrays

Arrays are the most fundamental data structure in computer science, providing fixed-size, contiguous memory allocation with constant-time access.

## Overview

In Zig, arrays can be categorized into several types:

- **Static Arrays** - Fixed-size arrays known at compile time
- **Dynamic Arrays** - Resizable arrays using ArrayList
- **Multi-dimensional Arrays** - Arrays of arrays (matrices, tensors)
- **Circular Arrays** - Ring buffers for fixed-size circular storage
- **Sparse Arrays** - Memory-efficient arrays for mostly empty data

## Implementation

### Static Arrays

Static arrays have their size determined at compile time:

```zig
const array = [5]i32{ 1, 2, 3, 4, 5 };
const slice = array[1..3];
const repeated = [_]u8{0} ** 10;
```

**Characteristics:**

- Size known at compile time
- Stack allocation
- No runtime overhead
- Bounds checking in safe modes

### Dynamic Arrays (ArrayList)

Dynamic arrays can grow and shrink at runtime:

```zig
var list = std.ArrayList(u8){};
defer list.deinit(allocator);

try list.append(allocator, 10);
try list.appendSlice(allocator, &[_]u8{ 20, 30, 40 });
```

**Characteristics:**

- Runtime resizing
- Heap allocation
- Amortized O(1) append
- Memory management required

### Multi-dimensional Arrays

Arrays of arrays for matrix and tensor operations:

```zig
const matrix = [2][3]u8{
    .{ 1, 2, 3 },
    .{ 4, 5, 6 },
};

const tensor3 = [2][2][3]u8{
    .{
        .{ 255, 0, 0 },
        .{ 0, 255, 0 },
    },
    .{
        .{ 0, 0, 255 },
        .{ 255, 255, 0 },
    },
};
```

### Circular Arrays (Ring Buffer)

Fixed-size circular buffer for efficient FIFO operations:

```zig
pub fn CircularBuffer(comptime T: type, comptime capacity: usize) type {
    return struct {
        data: [capacity]T = undefined,
        head: usize = 0,
        tail: usize = 0,
        count: usize = 0,

        pub fn push(self: *Self, item: T) !void {
            ...
        }

        pub fn pop(self: *Self) ?T {
            ...
        }
    };
}
```

### Sparse Arrays

Memory-efficient arrays for mostly empty data using hash maps:

```zig
var sparse = std.AutoHashMap(u32, i32).init(allocator);
defer sparse.deinit();

try sparse.put(99999, 777);
```

## Performance Analysis

| Array Type | Access | Insert | Delete | Memory | Use Case |
|------------|--------|--------|--------|---------|----------|
| Static | O(1) | N/A | N/A | O(n) | Fixed-size data |
| Dynamic | O(1) | O(1)\* | O(n) | O(n) | Variable data |
| Circular | O(1) | O(1) | O(1) | O(k) | Fixed buffer |
| Sparse | O(1) | O(1) | O(1) | O(m) | Sparse data |

\*Amortized for ArrayList append

## Common Operations

### Traversal

```zig
for (array) |item| {
    // Process item
}
```

### Search

```zig
for (array, 0..) |item, index| {
    if (item == target) {
        // Found at index
    }
}
```

### Modification

```zig
array[index] = new_value;
```

## Best Practices

- **Use static arrays** when size is known at compile time
- **Prefer ArrayList** for dynamic arrays with frequent appends
- **Consider circular buffers** for fixed-size FIFO queues
- **Use sparse arrays** for data with many empty slots
- **Always check bounds** in safe build modes

## Zig-Specific Advantages

- **Compile-time bounds checking** in safe modes
- **Zero-cost abstractions** for generic array types
- **Explicit memory management** for dynamic arrays
- **Comptime evaluation** for array initialization
- **Slice safety** with runtime bounds checking

## Running the Examples

```bash
zig run data_structures/01_linear/01_arrays.zig
```

This will demonstrate all array types with practical examples and output.
