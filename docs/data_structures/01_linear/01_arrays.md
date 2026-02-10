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

```zig title="Static Array Examples"
const array = [5]i32{ 1, 2, 3, 4, 5 };  // 5 integers
const slice = array[1..3];               // Slice of elements 1-2
const repeated = [_]u8{0} ** 10;          // 10 zero bytes
```

**Characteristics:**

- Size known at compile time
- Stack allocation
- No runtime overhead
- Bounds checking in safe modes

!!! info "Memory Layout"

  Static arrays are stored contiguously in memory with no indirection, making them cache-friendly and efficient.

### Dynamic Arrays (ArrayList)

Dynamic arrays can grow and shrink at runtime:

```zig title="Dynamic Array Operations"
var list = std.ArrayList(u8).init(allocator);  // Initialize
defer list.deinit();                           // Clean up automatically

try list.append(10);                           // Add single element
try list.appendSlice(&[_]u8{ 20, 30, 40 });    // Add multiple
list.clear();                                  // Remove all elements

// Access elements
const first = list.items[0];                    // Safe with bounds check
const length = list.items.len;                  // Current size
```

**Characteristics:**

- Runtime resizing
- Heap allocation
- Amortized $O(1)$ append
- Memory management required

!!! warning "Memory Management"

  Always call `deinit()` to prevent memory leaks. Use `defer` to ensure cleanup.

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

```zig title="Ring Buffer Implementation"
pub fn CircularBuffer(comptime T: type, comptime size: usize) type {
  return struct {
    data: [size]T = undefined,     // Storage
    head: usize = 0,               // Read position
    tail: usize = 0,               // Write position
    count: usize = 0,              // Current elements

    const Self = @This();

    // Write at tail
    pub fn append(self: *Self, item: T) !void {
      ...
    }

    // Read at head
    pub fn pop(self: *Self) ?T {
      if (self.count == 0) return null;

      const item = self.data[self.head];    // Read from head
      self.head = (self.head + 1) % capacity;   // Wrap around
      self.count -= 1;                 // Update count
      return item;
    }
  };
}
```

!!! tip "Use Cases"
Perfect for audio buffers, network packets, and producer-consumer patterns.

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

### Common Operations

!!! example "Traversal"

```zig title="Iterating Over Arrays"
// Simple iteration
for (array) |item| {
  std.debug.print("Item: {}\n", .{item});
}

  // With index
  for (array, 0..) |item, index| {
    std.debug.print("[{}] = {}\n", .{ index, item });
  }

  // Mutable iteration
  for (array) |*item| {
    item.* *= 2;  // Double each element
  }
```

!!! example "Search"

```zig title="Finding Elements"
const target = 42;
var found_index: ?usize = null;

// Linear search
for (array, 0..) |item, index| {
  if (item == target) {
    found_index = index;
    break;
  }
}

  // Using std.mem.indexOf
  if (std.mem.indexOfScalar(u32, &array, target)) |idx| {
    std.debug.print("Found at index {}\n", .{idx});
  }
```

!!! example "Modification"

```zig title="Array Operations"
// Direct assignment (bounds checked in safe mode)
array[0] = 100;

// Slice modification
const slice = array[1..4];
for (slice, 0..) |*item, i| {
  item.* = @intCast(i * 10);  // Safe cast
}

// Copy between arrays
var dest: [array.len]u32 = undefined;
@memcpy(&dest, &array);  // Built-in memory copy
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
