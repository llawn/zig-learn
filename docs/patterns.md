# Design Patterns

!!! abstract "Software Architecture Patterns in Zig"
    Design patterns are reusable solutions to commonly occurring problems in software design. This section explores the implementation of various design patterns in Zig, leveraging its unique features for optimal solutions.

## Pattern Overview

!!! info "Why Design Patterns Matter"
    
    Design patterns provide tested, proven development paradigms that can speed up the development process. They represent best practices and can be adapted to fit specific needs.
    
    !!! example "Benefits in Zig"
        - **Memory Safety** - Patterns respect Zig's ownership model
        - **Performance** - Zero-cost abstractions maintain efficiency
        - **Expressiveness** - Comptime features enable elegant implementations

!!! chart "Pattern Selection Guide"

    ```mermaid
    flowchart TD
        A[Problem Type] --> B{Need to Create?}
        B -->|Yes| C{Need Flexibility?}
        B -->|No| D{Need Structure?}
        
        C -->|Simple| E[Factory Method]
        C -->|Complex| F[Abstract Factory]
        C -->|Step-by-step| G[Builder]
        C -->|Single Instance| H[Singleton]
        
        D -->|Yes| I{Need Composition?}
        D -->|No| J{Need Behavior?}
        
        I -->|Tree| K[Composite]
        I -->|Interface Change| L[Adapter]
        I -->|Add Features| M[Decorator]
        I -->|Control Access| N[Proxy]
        
        J -->|Algorithm Swap| O[Strategy]
        J -->|Event System| P[Observer]
        J -->|Undo/Redo| Q[Command]
        J -->|State Changes| R[State]
    ```

=== "🏗️ Creational Patterns"
    
    !!! tip "Object Creation Mechanisms"
        Creational patterns provide various object creation mechanisms, which increase flexibility and reuse of existing code.

#### Singleton Pattern

!!! card "🔄 Singleton"
    
    Ensures a class has only one instance and provides a global point of access to it.
    
    **Use Cases:**
    
    - Configuration managers
    - Connection pools
    - Logging systems
    
    **Zig Implementation:**
    
    ```zig title="Thread-Safe Singleton"
    pub fn Singleton(comptime T: type) type {
        return struct {
            const Self = @This();
            
            var instance: ?T = null;
            var mutex = std.Thread.Mutex{};
            var initialized = false;

            pub fn getInstance() *T {
                mutex.lock();
                defer mutex.unlock();
                
                if (!initialized) {
                    instance = T{};
                    initialized = true;
                }
                return &instance.?;
            }
            
            pub fn reset() void {
                mutex.lock();
                defer mutex.unlock();
                
                instance = null;
                initialized = false;
            }
        };
    }
    ```
    
    **Memory Safety Note:** Zig's compile-time guarantees ensure the singleton is properly initialized before use.

#### Factory Method Pattern

!!! card "🏭 Factory Method"
    
    Defines an interface for creating an object but lets subclasses decide which class to instantiate.
    
    **Use Cases:**
    
    - Plugin systems
    - Configurable object creation
    - Framework extensibility
    
    **Zig Implementation:**
    
    ```zig title="Generic Factory Method"
    const Product = union(enum) {
        widget: Widget,
        gadget: Gadget,
        doohickey: Doohickey,
    };
    
    const Factory = struct {
        fn createProduct(product_type: ProductType) !Product {
            return switch (product_type) {
                .widget => Product{ .widget = try Widget.init() },
                .gadget => Product{ .gadget = try Gadget.init() },
                .doohickey => Product{ .doohickey = try Doohickey.init() },
            };
        }
    };
    ```

#### Builder Pattern

!!! card "🔧 Builder Pattern"
    
    Separates the construction of a complex object from its representation.
    
    **Use Cases:**
    
    - Configuration objects
    - SQL query builders
    - Complex object construction
    
    **Fluent Interface:**
    
    ```zig title="SQL Query Builder"
    const QueryBuilder = struct {
        select_fields: []const []const u8 = &[_][]const u8{},
        from_table: ?[]const u8 = null,
        where_clauses: []const []const u8 = &[_][]const u8{},
        limit_count: ?usize = null,
        
        pub fn select(self: *QueryBuilder, fields: []const []const u8) *QueryBuilder {
            self.select_fields = fields;
            return self;
        }
        
        pub fn from(self: *QueryBuilder, table: []const u8) *QueryBuilder {
            self.from_table = table;
            return self;
        }
        
        pub fn where(self: *QueryBuilder, clause: []const u8) *QueryBuilder {
            self.where_clauses = self.where_clauses ++ [_][]const u8{clause};
            return self;
        }
        
        pub fn build(self: QueryBuilder) []const u8 {
            // Generate SQL string
        }
    };
    
    // Usage
    const query = QueryBuilder{}
        .select(&[_][]const u8{"name", "email"})
        .from("users")
        .where("age > 18")
        .where("status = 'active'")
        .build();
    ```

#### Abstract Factory Pattern

!!! card "🏛️ Abstract Factory"
    
    Provides an interface for creating families of related objects without specifying their concrete classes.
    
    **Use Cases:**
    
    - UI toolkits
    - Database connectors
    - Platform-specific implementations
    
    **Type-Safe Implementation:**
    
    ```zig title="UI Component Factory"
    const UIFactory = struct {
        const ComponentType = enum {
            button,
            label,
            textbox,
        };
        
        fn createButton(self: UIFactory, text: []const u8) Button {
            return Button.init(text, self.style);
        }
        
        fn createLabel(self: UIFactory, text: []const u8) Label {
            return Label.init(text, self.style);
        }
    };
    
    const DarkUIFactory = UIFactory{
        .style = .dark,
    };
    
    const LightUIFactory = UIFactory{
        .style = .light,
    };
    ```

=== "🏢 Structural Patterns"
    
    !!! tip "Object Composition & Assembly"
        Structural patterns explain how to assemble objects and classes into larger structures while keeping these structures flexible and efficient.

#### Adapter Pattern

!!! card "🔌 Adapter"
    
    Allows the interface of an existing class to be used as another interface.
    
    **Use Cases:**
    
    - Legacy code integration
    - Format conversion
    - Interface compatibility
    
    **Implementation:**
    
    ```zig title="File System Adapter"
    const LegacyFileSystem = struct {
        fn readFile(path: []const u8) ![]u8 { /* Legacy implementation */ }
        fn writeFile(path: []const u8, data: []const u8) !void { /* Legacy implementation */ }
    };
    
    const ModernFileSystem = struct {
        const Self = @This();
        
        legacy: LegacyFileSystem,
        
        pub fn read(path: []const u8) ![]u8 {
            // Adapts modern interface to legacy implementation
            return self.legacy.readFile(path);
        }
        
        pub fn write(path: []const u8, contents: []const u8) !void {
            // Adapts modern interface to legacy implementation
            return self.legacy.writeFile(path, contents);
        }
    };
    ```

#### Decorator Pattern

!!! card "🎨 Decorator"
    
    Allows behavior to be added to an individual object, either statically or dynamically, without affecting the behavior of other objects from the same class.
    
    **Use Cases:**
    
    - UI components
    - Stream processing
    - Feature toggling
    
    **Stream Processing Example:**
    
    ```zig title="Data Stream Decorators"
    const Stream = struct {
        const Self = @This();
        const VTable = struct {
            readFn: *const fn (*Self, []u8) ?usize,
            writeFn: *const fn (*Self, []const u8) !usize,
        };
        
        ptr: *anyopaque,
        vtable: *const VTable,
        
        pub fn read(self: Self, buffer: []u8) ?usize {
            return self.vtable.readFn(self.ptr, buffer);
        }
        
        pub fn write(self: Self, data: []const u8) !usize {
            return self.vtable.writeFn(self.ptr, data);
        }
    };
    
    // Compression decorator
    const CompressedStream = struct {
        base: Stream,
        
        pub fn write(self: @This(), data: []const u8) !usize {
            const compressed = try compress(data);
            return self.base.write(compressed);
        }
    };
    
    // Encryption decorator  
    const EncryptedStream = struct {
        base: Stream,
        key: []const u8,
        
        pub fn write(self: @This(), data: []const u8) !usize {
            const encrypted = try encrypt(data, self.key);
            return self.base.write(encrypted);
        }
    };
    
    // Chaining decorators
    var file_stream = FileStream.init("data.bin");
    var compressed = CompressedStream{ .base = file_stream };
    var secure = EncryptedStream{ 
        .base = compressed.stream(), 
        .key = "secret123" 
    };
    ```

#### Proxy Pattern

!!! card "🛡️ Proxy"
    
    Provides a surrogate or placeholder for another object to control access to it.
    
    **Use Cases:**
    
    - Lazy loading
    - Access control
    - Caching mechanisms
    
    **Caching Proxy Example:**
    
    ```zig title="Database Connection Proxy"
    const DatabaseConnection = struct {
        const Self = @This();
        
        connection: ?std.net.Server.Connection = null,
        cache: std.StringHashMap([]const u8),
        
        pub fn query(self: *Self, sql: []const u8) ![]const u8 {
            // Check cache first
            if (self.cache.get(sql)) |cached_result| {
                return cached_result;
            }
            
            // Lazy initialization of connection
            if (self.connection == null) {
                self.connection = try self.connect();
            }
            
            // Execute query and cache result
            const result = try self.executeQuery(sql);
            try self.cache.put(sql, try allocator.dupe(u8, result));
            
            return result;
        }
        
        fn connect(self: *Self) !std.net.Server.Connection {
            // Expensive connection establishment
            return try DatabaseDriver.connect("localhost:5432");
        }
    };
    ```

#### Composite Pattern

!!! card "🌳 Composite"
    
    Compose objects into tree structures to represent part-whole hierarchies.
    
    **Use Cases:**
    
    - UI hierarchies
    - File systems
    - Organization structures
    
    **File System Example:**
    
    ```zig title="File System Composite"
    const FileSystemNode = struct {
        const Self = @This();
        const VTable = struct {
            getNameFn: *const fn (*anyopaque) []const u8,
            getSizeFn: *const fn (*anyopaque) u64,
            addFn: *const fn (*anyopaque, *Self) anyerror!void,
            removeFn: *const fn (*anyopaque, *Self) anyerror!void,
            getChildrenFn: *const fn (*anyopaque) []const *Self,
        };
        
        ptr: *anyopaque,
        vtable: *const VTable,
        
        pub fn getName(self: Self) []const u8 {
            return self.vtable.getNameFn(self.ptr);
        }
        
        pub fn getSize(self: Self) u64 {
            return self.vtable.getSizeFn(self.ptr);
        }
    };
    
    const File = struct {
        name: []const u8,
        size: u64,
        
        fn getName(self: *anyopaque) []const u8 {
            return @as(*File, @ptrCast(self)).name;
        }
        
        fn getSize(self: *anyopaque) u64 {
            return @as(*File, @ptrCast(self)).size;
        }
    };
    
    const Directory = struct {
        name: []const u8,
        children: std.ArrayList(*FileSystemNode),
        
        fn getName(self: *anyopaque) []const u8 {
            return @as(*Directory, @ptrCast(self)).name;
        }
        
        fn getSize(self: *anyopaque) u64 {
            const dir = @as(*Directory, @ptrCast(self));
            var total_size: u64 = 0;
            for (dir.children.items) |child| {
                total_size += child.getSize();
            }
            return total_size;
        }
        
        fn add(self: *anyopaque, node: *FileSystemNode) !void {
            const dir = @as(*Directory, @ptrCast(self));
            try dir.children.append(node);
        }
    };
    ```

### Behavioral Patterns

Behavioral patterns are concerned with algorithms and the assignment of responsibilities between objects.

#### Strategy Pattern

Defines a family of algorithms, encapsulates each one, and makes them interchangeable.

**Use Cases:**

- Sorting algorithms
- Compression methods
- Payment processing

#### Observer Pattern

Defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.

**Use Cases:**

- Event systems
- UI updates
- Model-View-Controller

#### Command Pattern

Encapsulates a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.

**Use Cases:**

- Undo/redo systems
- Macro recording
- Transaction management

#### State Pattern

Allows an object to alter its behavior when its internal state changes.

**Use Cases:**

- Game characters
- Protocol implementations
- Workflow systems

#### Iterator Pattern

Provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation.

**Use Cases:**

- Collection traversal
- Database cursors
- Stream processing

### Concurrency Patterns

Concurrency patterns deal with multi-threaded programming and synchronization.

#### Producer-Consumer Pattern

Coordinates production and consumption of data using queues.

**Use Cases:**

- Task queues
- Data pipelines
- Message processing

#### Thread Pool Pattern

Reuses threads for executing tasks to improve performance.

**Use Cases:**

- Web servers
- Parallel processing
- Background jobs

#### Future/Promise Pattern

Handles asynchronous operations and their results.

**Use Cases:**

- Network requests
- Computations
- I/O operations

## Zig-Specific Implementation Considerations

### Memory Management

- **Explicit allocation** - Use allocators for pattern instances
- **Resource cleanup** - Implement proper deinit methods
- **Stack vs heap** - Choose appropriate storage

### Type System

- **Comptime generics** - Use comptime for type parameters
- **Tagged unions** - Implement state machines efficiently
- **Interfaces** - Use struct with function pointers

### Error Handling

- **Error unions** - Proper error propagation
- **Try/catch** - Handle errors appropriately
- **Optional types** - Handle nullable values safely

### Performance

- **Zero-cost abstractions** - Avoid runtime overhead
- **Inlining** - Use inline for small functions
- **Compile-time optimization** - Leverage comptime features

## Resources

### Books

- "Design Patterns: Elements of Reusable Object-Oriented Software" - GoF
- "Patterns of Enterprise Application Architecture" - Martin Fowler

### Online Resources

- [Zig Design Patterns](https://github.com/ziglang/zig/wiki/Design-Patterns)
- [Refactoring.guru](https://refactoring.guru/design-patterns)
