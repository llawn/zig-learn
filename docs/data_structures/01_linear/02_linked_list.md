# Linked Lists

## Linked Lists

Linked lists are dynamic data structures consisting of nodes, where each node contains data and a pointer to the next node in the sequence.
Linked lists provide an alternative to arrays when you need frequent insertions and deletions, or when the size of the data structure is unknown.

### Singly Linked Lists

Each node points only to the next node.

**Characteristics:**

- Unidirectional traversal
- Memory efficient
- Simple implementation
- $O(n)$ search time

### Doubly Linked Lists

Each node points to both the next and previous nodes.

**Characteristics:**

- Bidirectional traversal
- More memory usage
- Complex implementation
- $O(n)$ search complexity
- $O(1)$ deletion and insertion complexity

### Circular Linked Lists

The last node points back to the first node.

**Characteristics:**

- No null pointers
- Useful for round-robin scheduling
- Infinite traversal without null checks
- $O(n)$ search time

## Skip Lists

A **Skip List** is a probabilistic data structure that allows for fast search, insertion, and deletion within an **ordered sequence of elements**.
It consists of multiple layers of linked lists where each higher level acts as an "express lane" for the levels below it.

### Concept

While a standard linked list has  search time, a Skip List achieves  by skipping over large portions of the list.
It is essentially a sorted linked list with additional pointers that "skip" intermediate nodes.

**Characteristics:**

- **Layered Hierarchy:** Level 0 is a standard sorted linked list. Higher levels contain a subset of the nodes.
- **Probabilistic Balancing:** The height of a node is determined randomly (often using a coin-flip logic), avoiding the need for complex tree rebalancing.
- **Efficiency:** Offers the same average-case complexity as AVL or Red-Black trees but is much easier to implement.


## Self-Organizing Lists

A **Self-Organizing List** is a specialized linked list that rearranges its elements based on access patterns.
The goal is to move frequently accessed items closer to the head of the list to improve average search time from  toward .

### Heuristics (Strategies)

| Strategy | Logic | Best For... |
| --- | --- | --- |
| **Move-to-Front (MTF)** | Moves the accessed node immediately to the `head`. | Temporal locality (recently used items). |
| **Transpose** | Swaps the accessed node with its immediate predecessor. | Steady, long-term access frequencies. |
| **Frequency Count** | Maintains the list in descending order of `access_count`. | Statistical stability; ignores sudden bursts. |

### Performance Characteristics

While the **worst-case** search time remains , the **average-case** is significantly improved in environments where a small subset of data is accessed much more frequently than the rest (following the Pareto principle, depending of the pattern, the search can be on avg $<< O(n)$)

## Performance Matrix**

### Linked List Performance Matrix

This table covers the standard linear variants. Note that **Search** is always the bottleneck here because you have to walk through the nodes one by one.

| Operation | Singly Linked | Doubly Linked | Circular (Singly) |
| --- | --- | --- | --- |
| Access (k-th) | O(n) | O(n) | O(n) |
| Search | O(n) | O(n) | O(n) |
| Insert (k-th position) | O(n) | O(n) | O(n) |
| Insert (After Reference) | O(1) | O(1) | O(1) |
| Insert (Before Reference) | O(n) | O(1) | O(n) |
| Insert (Head) | O(1) | O(1) | O(1)* |
| Insert (Tail) | O(1)* | O(1)* | O(1)* |
| Delete (k-th position) | O(n) | O(n) | O(n) |
| Delete (Given Reference) | O(n)** | O(1) | O(n)** |
| Delete (Head) | O(1) | O(1) | O(1)* |
| Delete (Tail) | O(n) | O(1)* | O(n) |
| Space Complexity | O(n) | O(n) | O(n) |

1. *Assumes you maintain a pointer to the `tail` for access to both ends.*
2. *By copying the data from the next node into the current node and then delete the next node you can achieve $O(1)$ but references to that specific node are now broken.

- **The "Doubly" Advantage:** The main perk of a Doubly Linked List isn't search speed (still linear), but the ability to delete a node in  if you already have a reference to it.
- In Arrays, these operations are $O(n)$ because removing or adding an element requires shifting all subsequent elements to close the gap or make space.

### Skip List Performance Matrix

Since a Skip List uses multiple layers to "skip" over nodes, it behaves much more like a balanced Binary Search Tree than a typical list.

| Operation | Average Case |
| --- | --- |
| **Search** | O(logn) |
| **Insert** | O(logn) |
| **Delete** | O(logn) |
| **Space Complex | O(n) |

- **The Skip List Edge:** It’s essentially a "Linked List with shortcuts." While a regular list is stuck in  for searching, the Skip List gets you to  without the complex rebalancing logic required by AVL or Red-Black trees.

!!! info "Probabilistic Guarantees"

  While the worst-case performance is  (similar to a linked list if the random heights are all 1), the mathematical probability of this occurring is extremely low.
  In practice, Skip Lists perform as efficiently as balanced binary search trees.

## Implementation

### Linked List

#### Node Structure

The basic building block of the linked list is the generic Node struct.
It uses comptime to define the payload type at compile-time.

| Field | Type | Description |
| --- | --- | --- |
| data | `T` | The generic payload stored in the node. |
| next | `?*Node(T)` | An optional pointer to the next node (null at the tail). |
| prev | `?*Node(T)` | *An optional pointer to the previous node (null at the head).* |

!!! info "Pointer Overhead"

  On a 64-bit system, each Node carries an 8-byte overhead for the next pointer.
  The total size of the struct is `sizeof(T)+8` bytes (plus potential padding for alignment).

!!! tip "Previous Field"

  `prev` field is used for doubly linked list.

#### LL Structure

| Property | Type | Description |
| --- | --- | --- |
| `head` | `?*Node` | Pointer to the first node (access). |
| `tail` | `?*Node` | Pointer to the last node (appends). |
| `len` | `usize` | The number of elements currently in the list. |
| `allocator` | `Allocator` | The allocator used for node lifecycle management. |

#### LL Methods (Examples)

| Method | Description |
| --- | --- |
| `init` | Creates a new list instance with a given allocator. |
| `deinit` | Frees all nodes and marks the list as `undefined`. |
| `append` | Inserts a new element at the end of the list. |
| `prepend` | Inserts a new element at the start of the list. |
| `find` | Searches for the first node containing the specified data. |
| `remove` | Deletes the first occurrence of data and repairs links. |
| `deleteAt` | Deletes the nodes at index position. |
| `deleteNode` | Deletes the specified node. |

!!! warning "Manual Memory Management"

  This structure allocates memory on the heap for every node.
  You **must** call `deinit()` to ensure all nodes are freed.
  The list state is set to `undefined` after deinit.

!!! info "Data Comparisons"

  This implementation uses `std.meta.eql(a, b)` for the `find` and `remove` methods.
  This means it supports complex types like `structs` and `unions` out of the box, provided their fields are comparable.

### Skip List

#### Node Structure

In a Skip List, a node doesn't have a single `next` pointer. Instead, it contains an array (or slice) of pointers, one for each level it participates in.

| Field | Type | Description |
| --- | --- | --- |
| data | `T` | The sorted payload. |
| forward | `[]?*Node` | An array of optional pointers to the next nodes at different levels. |

#### Skip List Structure

| Property | Type | Description |
| --- | --- | --- |
| `header` | `Node` | A sentinel node that serves as the starting point for all levels. |
| `level` | `usize` | The current maximum level reached in the list. |
| `len` | `usize` | The number of elements in the list. |
| `rng` | `f32` | The probability used to determine node height (usually 0.5). |
| `MAX_LEVEL` | `usize` | The hard limit for the number of levels. |

### Self-Organizing List

!!! example

  ```zig
  var list = SelfOrganizingList(u32, Heuristic.frequency_count).init(allocator);
  ```

#### Self-Organizing Node Structure

The node requires an additional field to track access frequency for the `frequency_count` strategy.

| Field | Type | Description |
| --- | --- | --- |
| `data` | `T` | The generic payload. |
| `next` | `?*Node` | Pointer to the next node. |
| `access_count` | `u32` | Counter incremented on every `find` call. |

#### The `find` Method (Heuristic Logic)

The implementation uses a `comptime` strategy to determine how the list reorganizes during a search.

!!! tip "Frequency Insertion"

  In the `frequency_count` strategy, after removing the node from its current position,
  it is re-inserted by walking from the `head` until a node with a lower or equal `access_count` is found.

## Use Cases

### When to Use Linked Lists

- **Dynamic sizing** - When size is unknown or variable
- **Frequent insertions/deletions** - Especially at ends
- **Memory constraints** - When you can't allocate large contiguous blocks
- **Implementation of other structures** - Stacks, queues, graphs

### When to Avoid Linked Lists

- **Random access needed** - Arrays are better for $O(1)$ access
- **Cache performance critical** - Arrays have better locality
- **Memory overhead concern** - Linked lists have pointer overhead
- **Simple data storage** - Arrays are simpler for basic storage

### When to Use Skip Lists

* **Concurrent Applications:** Skip Lists are easier to implement as lock-free structures than balanced trees.
* **In-Memory Databases:** Redis uses Skip Lists for its `Sorted Set` implementation because of their efficient range queries.
* **Simple Implementation:** When you need  performance but want to avoid the complexity of tree rotations.

### When to Avoid Skip Lists

* **Memory-Constrained Systems:** The multiple pointers per node create more overhead than a simple array or singly linked list.
* **Static Data:** If the data never changes, a sorted array with binary search is more memory-efficient and just as fast.

### When to Use Self-Organizing Lists

* **Cache Implementation:** MTF is excellent for Simple LRU-like (Least Recently Used) behavior.
* **Compilers:** Storing symbol tables where certain variables are accessed much more often than others.
* **Network Routing:** Keeping track of the most active IP addresses or routes.

### When to Avoid Self-Organizing Lists

* **Uniform Access:** If every element is accessed with equal probability, the overhead of re-linking pointers actually makes it slower than a standard Singly Linked List.
* **Large Datasets:** For massive amounts of data where  is required, use a **Skip List** or **Balanced BST**.

## Running the Example

```bash
zig run data_structures/01_linear/02_linked_list.zig
```

