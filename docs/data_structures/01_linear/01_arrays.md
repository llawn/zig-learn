# Arrays

Arrays are the most fundamental data structure in computer science, providing fixed-size, contiguous memory allocation with constant-time access.

## Overview

In Zig, arrays can be categorized into several types:

- **Static Arrays** - Fixed-size arrays known at compile time
- **Dynamic Arrays** - Resizable arrays using ArrayList
- **Multi-dimensional Arrays** - Arrays of arrays (matrices, tensors)
- **Circular Arrays** - Ring buffers for fixed-size circular storage

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

#### Structure Definition

| Property | Type | Description |
| --- | --- | --- |
| `data` | `size[T]` | The actual array. |
| `head` | `usize` | First element (access). |
| `tail` | `usize` | Last element (`append`). |
| `count` | `usize` | The number of elements currently in the array. |

#### Methods

| Method | Description |
| --- | --- |
| `pop` | Creates a new list instance with a given allocator. |
| `append` | Frees all nodes and marks the list as `undefined`. |
| `at` | Inserts a new element at the end of the list. |
| `format` | Inserts a new element at the start of the list. |


!!! tip "Use Cases"

  Perfect for audio buffers, network packets, and producer-consumer patterns.

## Performance Analysis

For arrays this are common complexity.

| Access | Insert | Delete | Search |
|--------|--------|--------|--------|
| $O(1)$ | $O(n)$ | $O(n)$ | $O(n)$ |

!!! note "Deletion and Insertion"

  Deletions and insertions operations can be performed in $O(n)$,
  because removing or adding an element requires shifting all subsequent elements
  to close the gap or make space.
  To be $O(1)$ we can leave a gap on deletion or delete/insert at the end with
  `pop()` and `append()` methods.

  For dynamic arrays, insertions is **Amortized $O(1)$** because it occasionally takes
  $O(n)$ time to resize the underlying before. While `size` is the number of elements
  currently in the array, `capacity` is the amount of physical memory space actually allocated.
  When the`size` reaches `capacity`, the dynamic array has no more contiguous "slots" to use
  (this is essential for $O(1)$ access time). The systems identifies a new element is being
  added to the full array. It asks the OS for a completely new larger block of memory (usually 1.5x - 2.0x former capacity).

## Common Operations

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
- **Use sparse arrays** for data with many empty slots
- **Always check bounds** in safe build modes

## Running the Example

```bash
zig run data_structures/01_linear/01_arrays.zig
```

