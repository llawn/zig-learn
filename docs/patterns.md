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

=== "🎭 Behavioral Patterns"
    
    !!! tip "Object Interaction & Communication"
        Behavioral patterns are concerned with algorithms and the assignment of responsibilities between objects.

#### Strategy Pattern

!!! card "🎯 Strategy"
    
    Defines a family of algorithms, encapsulates each one, and makes them interchangeable.
    
    **Use Cases:**
    
    - Sorting algorithms
    - Compression methods
    - Payment processing
    
    **Comptime Strategy Selection:**
    
    ```zig title "Sorting Strategy Pattern"
    const SortStrategy = enum {
        bubble,
        quick,
        merge,
        heap,
    };
    
    fn Sort(comptime T: type, comptime strategy: SortStrategy) type {
        return struct {
            const Self = @This();
            
            data: []T,
            
            pub fn sort(self: Self) void {
                switch (strategy) {
                    .bubble => self.bubbleSort(),
                    .quick => self.quickSort(0, self.data.len - 1),
                    .merge => self.mergeSort(0, self.data.len - 1),
                    .heap => self.heapSort(),
                }
            }
            
            fn bubbleSort(self: Self) void {
                for (0..self.data.len) |i| {
                    for (0..self.data.len - i - 1) |j| {
                        if (self.data[j] > self.data[j + 1]) {
                            std.mem.swap(T, &self.data[j], &self.data[j + 1]);
                        }
                    }
                }
            }
            
            fn quickSort(self: Self, left: usize, right: usize) void {
                // Implementation...
            }
        };
    }
    
    // Usage
    const numbers = [_]u32{ 5, 2, 8, 1, 9 };
    var sorter = Sort(u32, .quick){ .data = &numbers };
    sorter.sort();
    ```

#### Observer Pattern

!!! card "👁️ Observer"
    
    Defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.
    
    **Use Cases:**
    
    - Event systems
    - UI updates
    - Model-View-Controller
    
    **Type-Safe Implementation:**
    
    ```zig title="Event System Observer"
    const Event = union(enum) {
        data_updated: struct { id: u32, new_value: i32 },
        user_login: struct { username: []const u8, timestamp: i64 },
        error_occurred: struct { error_code: u16, message: []const u8 },
    };
    
    const Observer = struct {
        const Callback = *const fn (observer: *anyopaque, event: Event) void;
        
        ptr: *anyopaque,
        callback: Callback,
        
        pub fn notify(self: Observer, event: Event) void {
            self.callback(self.ptr, event);
        }
    };
    
    const Subject = struct {
        const Self = @This();
        
        observers: std.ArrayList(Observer),
        
        pub fn attach(self: *Self, observer: Observer) !void {
            try self.observers.append(observer);
        }
        
        pub fn detach(self: *Self, observer: Observer) void {
            for (self.observers.items, 0..) |obs, i| {
                if (obs.ptr == observer.ptr) {
                    _ = self.observers.orderedRemove(i);
                    break;
                }
            }
        }
        
        pub fn notify(self: Self, event: Event) void {
            for (self.observers.items) |observer| {
                observer.notify(event);
            }
        }
    };
    ```

#### Command Pattern

!!! card "📝 Command"
    
    Encapsulates a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.
    
    **Use Cases:**
    
    - Undo/redo systems
    - Macro recording
    - Transaction management
    
    **Undo/Redo Implementation:**
    
    ```zig title="Text Editor Command Pattern"
    const Command = struct {
        const Self = @This();
        const VTable = struct {
            executeFn: *const fn (*anyopaque) anyerror!void,
            undoFn: *const fn (*anyopaque) anyerror!void,
        };
        
        ptr: *anyopaque,
        vtable: *const VTable,
        
        pub fn execute(self: Self) !void {
            return self.vtable.executeFn(self.ptr);
        }
        
        pub fn undo(self: Self) !void {
            return self.vtable.undoFn(self.ptr);
        }
    };
    
    const InsertTextCommand = struct {
        editor: *TextEditor,
        position: usize,
        text: []const u8,
        
        fn execute(self: *@This()) !void {
            try self.editor.insert(self.position, self.text);
        }
        
        fn undo(self: *@This()) !void {
            self.editor.delete(self.position, self.text.len);
        }
    };
    
    const CommandHistory = struct {
        undo_stack: std.ArrayList(Command),
        redo_stack: std.ArrayList(Command),
        
        pub fn execute(self: *@This(), command: Command) !void {
            try command.execute();
            try self.undo_stack.append(command);
            self.redo_stack.clearAndFree();
        }
        
        pub fn undo(self: *@This()) !void {
            if (self.undo_stack.pop()) |command| {
                try command.undo();
                try self.redo_stack.append(command);
            }
        }
    };
    ```

#### State Pattern

!!! card "🔄 State"
    
    Allows an object to alter its behavior when its internal state changes.
    
    **Use Cases:**
    
    - Game characters
    - Protocol implementations
    - Workflow systems
    
    **Game State Machine:**
    
    ```zig title="Game Character State Pattern"
    const CharacterState = enum {
        idle,
        walking,
        running,
        jumping,
        attacking,
    };
    
    const Character = struct {
        const Self = @This();
        
        state: CharacterState = .idle,
        position: [2]f32 = .{ 0, 0 },
        velocity: [2]f32 = .{ 0, 0 },
        
        pub fn update(self: *Self, dt: f32) void {
            switch (self.state) {
                .idle => self.updateIdle(dt),
                .walking => self.updateWalking(dt),
                .running => self.updateRunning(dt),
                .jumping => self.updateJumping(dt),
                .attacking => self.updateAttacking(dt),
            }
        }
        
        pub fn handleInput(self: *Self, input: Input) void {
            switch (self.state) {
                .idle => self.handleIdleInput(input),
                .walking => self.handleWalkingInput(input),
                .running => self.handleRunningInput(input),
                .jumping => self.handleJumpingInput(input),
                .attacking => self.handleAttackingInput(input),
            }
        }
        
        fn updateIdle(self: *Self, dt: f32) void {
            // Apply friction
            self.velocity[0] *= 0.9;
            self.velocity[1] *= 0.9;
            
            // Transition to walking if moving
            if (@fabs(self.velocity[0]) > 0.1 or @fabs(self.velocity[1]) > 0.1) {
                self.state = .walking;
            }
        }
    };
    ```

#### Iterator Pattern

!!! card "🔍 Iterator"
    
    Provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
    
    **Use Cases:**
    
    - Collection traversal
    - Database cursors
    - Stream processing
    
    **Generic Iterator:**
    
    ```zig title="Generic Iterator Pattern"
    fn Iterator(comptime T: type) type {
        return struct {
            const Self = @This();
            const VTable = struct {
                nextFn: *const fn (*anyopaque) ?T,
                resetFn: *const fn (*anyopaque) void,
            };
            
            ptr: *anyopaque,
            vtable: *const VTable,
            
            pub fn next(self: *Self) ?T {
                return self.vtable.nextFn(self.ptr);
            }
            
            pub fn reset(self: *Self) void {
                self.vtable.resetFn(self.ptr);
            }
        };
    }
    
    const ArrayIterator = struct {
        array: []const u32,
        index: usize = 0,
        
        fn next(self: *@This()) ?u32 {
            if (self.index >= self.array.len) return null;
            defer self.index += 1;
            return self.array[self.index];
        }
        
        fn reset(self: *@This()) void {
            self.index = 0;
        }
    };
    
    // Usage with any collection type
    fn createArrayIterator(array: []const u32) Iterator(u32) {
        const iter = try allocator.create(ArrayIterator);
        iter.* = .{ .array = array };
        
        const vtable = comptime VTable{
            .nextFn = (struct {
                fn fnImpl(ptr: *anyopaque) ?u32 {
                    return @as(*ArrayIterator, @ptrCast(ptr)).next();
                }
            }).fnImpl,
            .resetFn = (struct {
                fn fnImpl(ptr: *anyopaque) void {
                    @as(*ArrayIterator, @ptrCast(ptr)).reset();
                }
            }).fnImpl,
        };
        
        return .{ .ptr = iter, .vtable = &vtable };
    }
    ```

=== "🔀 Concurrency Patterns"
    
    !!! tip "Multi-threaded Programming"
        Concurrency patterns deal with multi-threaded programming and synchronization.

#### Producer-Consumer Pattern

!!! card "📤 Producer-Consumer"
    
    Coordinates production and consumption of data using queues.
    
    **Use Cases:**
    
    - Task queues
    - Data pipelines
    - Message processing
    
    **Thread-Safe Implementation:**
    
    ```zig title="Producer-Consumer with Channels"
    const Channel = struct {
        const Self = @This();
        
        buffer: std.ArrayList(T),
        mutex: std.Thread.Mutex,
        condition: std.Thread.Condition,
        closed: bool = false,
        
        pub fn send(self: *Self, item: T) !void {
            self.mutex.lock();
            defer self.mutex.unlock();
            
            while (self.buffer.items.len >= capacity and !self.closed) {
                self.condition.wait(&self.mutex);
            }
            
            if (self.closed) return error.ChannelClosed;
            
            try self.buffer.append(item);
            self.condition.signal();
        }
        
        pub fn receive(self: *Self) ?T {
            self.mutex.lock();
            defer self.mutex.unlock();
            
            while (self.buffer.items.len == 0 and !self.closed) {
                self.condition.wait(&self.mutex);
            }
            
            if (self.buffer.items.len == 0) return null;
            
            const item = self.buffer.orderedRemove(0);
            self.condition.signal();
            return item;
        }
    };
    ```

#### Thread Pool Pattern

!!! card "🏊 Thread Pool"
    
    Reuses threads for executing tasks to improve performance.
    
    **Use Cases:**
    
    - Web servers
    - Parallel processing
    - Background jobs
    
    **Efficient Thread Pool:**
    
    ```zig title="Work-Stealing Thread Pool"
    const ThreadPool = struct {
        const Self = @This();
        const Task = struct {
            fn_ptr: *const fn (*anyopaque) void,
            context: *anyopaque,
        };
        
        workers: []Worker,
        work_queue: std.atomic.Queue(Task),
        shutdown: std.atomic.Value(bool) = std.atomic.Value(bool).init(false),
        
        const Worker = struct {
            thread: std.Thread,
            pool: *ThreadPool,
            
            fn run(worker: *Worker) void {
                while (!worker.pool.shutdown.load(.Acquire)) {
                    if (worker.pool.work_queue.pop()) |task| {
                        task.fn_ptr(task.context);
                    } else {
                        std.time.sleep(1_000_000); // 1ms
                    }
                }
            }
        };
        
        pub fn submit(self: *Self, task: Task) !void {
            try self.work_queue.push(task);
        }
    };
    ```

#### Future/Promise Pattern

!!! card "🔮 Future/Promise"
    
    Handles asynchronous operations and their results.
    
    **Use Cases:**
    
    - Network requests
    - Computations
    - I/O operations
    
    **Async Implementation:**
    
    ```zig title="Future/Promise Pattern"
    const Future = struct {
        const Self = @This();
        const State = union(enum) {
            pending,
            completed: T,
            failed: anyerror,
        };
        
        state: State = .pending,
        mutex: std.Thread.Mutex,
        condition: std.Thread.Condition,
        
        pub fn wait(self: *Self) !T {
            self.mutex.lock();
            defer self.mutex.unlock();
            
            while (self.state == .pending) {
                self.condition.wait(&self.mutex);
            }
            
            return switch (self.state) {
                .completed => |value| value,
                .failed => |err| err,
                .pending => unreachable,
            };
        }
        
        pub fn isReady(self: *Self) bool {
            self.mutex.lock();
            defer self.mutex.unlock();
            return self.state != .pending;
        }
    };
    
    const Promise = struct {
        future: *Future,
        
        pub fn complete(self: Promise, value: T) void {
            self.future.mutex.lock();
            defer self.future.mutex.unlock();
            
            self.future.state = .{ .completed = value };
            self.future.condition.broadcast();
        }
        
        pub fn fail(self: Promise, err: anyerror) void {
            self.future.mutex.lock();
            defer self.future.mutex.unlock();
            
            self.future.state = .{ .failed = err };
            self.future.condition.broadcast();
        }
    };
    ```

## Zig-Specific Implementation Considerations

!!! info "Leveraging Zig Features"

### Memory Management

!!! tip "Explicit Allocation"
    
    - **Explicit allocation** - Use allocators for pattern instances
    - **Resource cleanup** - Implement proper deinit methods
    - **Stack vs heap** - Choose appropriate storage
    
    ```zig
    const Pattern = struct {
        allocator: std.mem.Allocator,
        
        pub fn init(allocator: std.mem.Allocator) Self {
            return Self{ .allocator = allocator };
        }
        
        pub fn deinit(self: *Self) void {
            // Clean up allocated resources
        }
    };
    ```

### Type System

!!! tip "Type Safety & Generics"
    
    - **Comptime generics** - Use comptime for type parameters
    - **Tagged unions** - Implement state machines efficiently
    - **Interfaces** - Use struct with function pointers
    
    ```zig
    // Comptime polymorphism
    fn Factory(comptime ProductType: type) type {
        return struct {
            pub fn create(config: Config) !ProductType {
                // Type-safe creation
            }
        };
    }
    
    // Tagged union for state
    const State = union(enum) {
        idle,
        running: struct { speed: f32 },
        error: struct { code: u32 },
    };
    ```

### Error Handling

!!! tip "Robust Error Management"
    
    - **Error unions** - Proper error propagation
    - **Try/catch** - Handle errors appropriately
    - **Optional types** - Handle nullable values safely
    
    ```zig
    pub fn execute(self: Self) !Result {
        const result = self.prepare() catch |err| {
            self.logError(err);
            return err;
        };
        
        return self.process(result) orelse error.NoData;
    }
    ```

### Performance

!!! tip "Zero-Cost Abstractions"
    
    - **Zero-cost abstractions** - Avoid runtime overhead
    - **Inlining** - Use inline for small functions
    - **Compile-time optimization** - Leverage comptime features
    
    ```zig
    // Compile-time strategy selection
    fn Algorithm(comptime strategy: Strategy) type {
        return struct {
            pub fn execute(self: Self, data: []T) void {
                if (comptime strategy == .optimized) {
                    // Optimized path
                } else {
                    // General path
                }
            }
        };
    }
    ```

## Pattern Selection Guide

!!! chart "Decision Tree"

    ```mermaid
    flowchart TD
        A[What's your problem?] --> B{Object Creation?}
        B -->|Yes| C[Creational Patterns]
        B -->|No| D{Structure Issues?}
        D -->|Yes| E[Structural Patterns]
        D -->|No| F[Behavioral Patterns]
        
        C --> G[Singleton/Factory/Builder]
        E --> H[Adapter/Decorator/Proxy]
        F --> I[Strategy/Observer/Command]
    ```

## Resources & Further Learning

!!! grid "2"

    !!! card "📚 Essential Reading"
        
        ### Books
        
        - "Design Patterns: Elements of Reusable Object-Oriented Software" - GoF
        - "Patterns of Enterprise Application Architecture" - Martin Fowler
        - "Clean Architecture" - Robert C. Martin
        - "Domain-Driven Design" - Eric Evans

    !!! card "🌐 Online Resources"
        
        ### Websites & Communities
        
        - [Zig Design Patterns](https://github.com/ziglang/zig/wiki/Design-Patterns)
        - [Refactoring.guru](https://refactoring.guru/design-patterns)
        - [Zig Discourse](https://discourse.ziglang.org/)
        - [Zig GitHub](https://github.com/ziglang/zig/issues)

!!! example "Pattern Implementation Template"

    ```zig title="Standard Pattern Template"
    const PatternName = struct {
        const Self = @This();
        
        // Configuration
        config: Config,
        allocator: std.mem.Allocator,
        
        // State
        state: State,
        
        pub fn init(config: Config, allocator: std.mem.Allocator) !Self {
            return Self{
                .config = config,
                .allocator = allocator,
                .state = try State.init(config),
            };
        }
        
        pub fn deinit(self: *Self) void {
            self.state.deinit();
        }
        
        // Core pattern operations
        pub fn execute(self: *Self) !Result {
            // Implementation
        }
    };
    ```

!!! question "Pattern Help?"
    
    Need help implementing a specific pattern in Zig?
    
    - Check the [examples in this repository](https://github.com/llawn/zig-learn)
    - Ask questions on [Zig Discord](https://discord.gg/ziglang)
    - Review [standard library implementations](https://github.com/ziglang/zig/tree/master/lib)
