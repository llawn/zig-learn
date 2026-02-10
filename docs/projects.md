# Practice Projects

!!! abstract "Build Real-World Applications with Zig"
    This section contains hands-on coding projects that apply the data structures, algorithms, and design patterns learned throughout this repository. Each project bridges the gap between theoretical knowledge and practical application.

## Learning Journey

!!! info "Project Progression"
    
    ```mermaid
    timeline
        title Project Learning Path
        section Beginner
            Stack Calculator : Data Structures
            Sort Visualizer : Algorithms  
        section Intermediate
            Compression Utility : Advanced Data Structures
            Text Search Engine : String Algorithms
        section Advanced
            Text Editor : Design Patterns
            Web Server : Concurrency
        section Expert
            Compiler Front-end : Parsing & AST
            Distributed Store : Distributed Systems
    ```

!!! grid "3"

    !!! card ""
        ## 🟢 Beginner
        Projects for learning fundamentals
        
        - Stack-based calculator
        - Sorting visualizer
        - Basic data structures

    !!! card ""
        ## 🟡 Intermediate
        Apply multiple concepts together
        
        - Compression algorithms
        - Search engines
        - Pattern matching

    !!! card ""
        ## 🔴 Advanced
        Complex real-world applications
        
        - Text editors
        - Web servers
        - Compilers

## Project Categories

=== "🟢 Data Structure Projects"
    
    !!! tip "Fundamental Data Structure Implementations"
    
    --8<-- "projects/data-structures.md"

#### Simple Calculator with Stack-Based Evaluation

!!! card "📊 Stack-Based Calculator"
    
    **Difficulty:** 🟢 Beginner | **Time:** 4-6 hours
    
    **Concepts Applied:**
    
    - Stacks (LIFO operations)
    - Expression parsing  
    - Operator precedence
    
    **Features:**
    
    - Basic arithmetic operations (+, -, \*, /)
    - Parentheses support
    - Error handling for invalid expressions
    
    **Implementation:**
    
    ```zig title="Calculator Core"
    pub fn Calculator(comptime T: type) type {
        return struct {
            const Self = @This();
            
            values: std.ArrayList(T),      // Number stack
            operators: std.ArrayList(u8),   // Operator stack

            pub fn evaluate(expression: []const u8) !T {
                var self = Self.init(allocator);
                defer self.deinit();
                
                return self.parseAndEval(expression);
            }
            
            fn parseAndEval(self: *Self, expr: []const u8) !T {
                // Shunting-yard algorithm implementation
                // 1. Convert infix to postfix notation
                // 2. Evaluate postfix expression
            }
        };
    }
    ```

#### File Compression Utility

!!! card "🗜️ Huffman Compression"
    
    **Difficulty:** 🟡 Intermediate | **Time:** 8-12 hours
    
    **Concepts Applied:**
    
    - Huffman coding
    - Priority queues
    - Tree structures
    - Binary I/O
    
    **Features:**
    
    - Text file compression
    - Decompression  
    - Compression ratio reporting
    
    **Algorithm Flow:**
    
    ```mermaid
    graph TD
        A[Input Text] --> B[Count Frequencies]
        B --> C[Build Huffman Tree]
        C --> D[Generate Codes]
        D --> E[Encode Data]
        E --> F[Compressed File]
        
        G[Compressed File] --> H[Read Tree & Data]
        H --> I[Decode Using Tree]
        I --> J[Original Text]
    ```

#### Pathfinding Visualizer

!!! card "🗺️ Pathfinding Algorithms"
    
    **Difficulty:** 🟡 Intermediate | **Time:** 10-15 hours
    
    **Concepts Applied:**
    
    - Graph algorithms (A\*, Dijkstra, BFS, DFS)
    - Grid-based representation
    - Real-time visualization
    - Performance comparison

=== "🔧 Algorithm Projects"

    
    !!! tip "Algorithm Implementation & Analysis"
    
    --8<-- "projects/algorithms.md"

#### Sorting Algorithm Visualizer

!!! card "📊 Sorting Visualizer"
    
    **Difficulty:** 🟢 Beginner | **Time:** 6-8 hours
    
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
    
    **Performance Comparison:**
    
    | Algorithm | Time Complexity | Space | Stable | Best For |
    |-----------|----------------|-------|--------|----------|
    | Bubble | $O(n^2)$ | $O(1)$ | ✓ | Education |
    | Quick | $O(n \log n)$ | $O(\log n)$ | ✗ | General |
    | Merge | $O(n \log n)$ | $O(n)$ | ✓ | Large data |
    | Heap | $O(n \log n)$ | $O(1)$ | ✗ | In-place |

#### Text Search Engine

!!! card "🔍 Search Engine"
    
    **Difficulty:** 🟡 Intermediate | **Time:** 12-16 hours
    
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
    
    **Algorithm Selection:**
    
    ```zig title="Search Algorithm Strategy"
    const SearchStrategy = enum {
        naive,      // O(mn) - simple approach
        kmp,        // O(m+n) - pattern preprocessing  
        rabin_karp, // O(m+n) average - hashing
        boyer_moore, // O(m+n) best - skip ahead
        
        fn search(self: SearchStrategy, text: []const u8, pattern: []const u8) ?usize {
            return switch (self) {
                .naive => naiveSearch(text, pattern),
                .kmp => kmpSearch(text, pattern),
                .rabin_karp => rabinKarpSearch(text, pattern),
                .boyer_moore => boyerMooreSearch(text, pattern),
            };
        }
    };
    ```

#### Mini Database with B-tree Indexing

!!! card "💾 Mini Database"
    
    **Difficulty:** 🔴 Advanced | **Time:** 20-30 hours
    
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

=== "🏗️ Design Pattern Projects"

    
    !!! tip "Software Architecture & Design"
    
    --8<-- "projects/design-patterns.md"

#### Text Editor with Undo/Redo

!!! card "📝 Text Editor"
    
    **Difficulty:** 🔴 Advanced | **Time:** 25-35 hours
    
    **Concepts Applied:**
    
    - Command pattern
    - Memento pattern
    - Observer pattern
    - Strategy pattern
    
    **Architecture:**
    
    ```mermaid
    graph TB
        A[Editor Core] --> B[Command Manager]
        B --> C[Undo Stack]
        B --> D[Redo Stack]
        A --> E[Document Model]
        E --> F[Observer Pattern]
        F --> G[UI Updates]
        A --> H[Plugin System]
    ```
    
    **Features:**
    
    - Text editing operations
    - Undo/redo functionality
    - Multiple file support
    - Plugin architecture

#### Multi-threaded Web Server

!!! card "🌐 Web Server"
    
    **Difficulty:** 🔴 Advanced | **Time:** 30-40 hours
    
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

!!! card "🔌 Plugin Architecture"
    
    **Difficulty:** 🔴 Advanced | **Time:** 20-25 hours
    
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

=== "🚀 Advanced Projects"
    
    !!! tip "Complex Real-World Applications"
    
    --8<-- "projects/advanced.md"

#### Compiler Front-end

!!! card "⚙️ Compiler Front-end"
    
    **Difficulty:** 🔴 Expert | **Time:** 40-60 hours
    
    **Concepts Applied:**
    
    - Parsing algorithms
    - Abstract syntax trees
    - Symbol tables
    - Type systems
    
    **Compilation Pipeline:**
    
    ```mermaid
    graph LR
        A[Source Code] --> B[Lexer]
        B --> C[Tokens]
        C --> D[Parser]
        D --> E[AST]
        E --> F[Semantic Analyzer]
        F --> G[Type Checker]
        G --> H[Code Generation]
    ```
    
    **Features:**
    
    - Lexical analysis
    - Syntax parsing
    - Semantic analysis
    - Error reporting

#### Distributed Key-Value Store

!!! card "🔗 Distributed System"
    
    **Difficulty:** 🔴 Expert | **Time:** 50-80 hours
    
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

!!! card "🎮 Game Engine"
    
    **Difficulty:** 🔴 Expert | **Time:** 60-100 hours
    
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

## Getting Started

!!! checklist "Project Setup"

    - [x] Install Zig 0.15+
    - [x] Set up development environment
    - [x] Clone this repository
    - [x] Review prerequisite concepts
    - [ ] Choose your first project
    - [ ] Implement step by step
    - [ ] Test and validate
    - [ ] Document your solutions

!!! tip "Learning Strategy"

    1. **Start with fundamentals** - Begin with data structure projects
    2. **Progress gradually** - Move to algorithms, then patterns
    3. **Focus on quality** - Well-documented code over quantity
    4. **Compare approaches** - Implement multiple solutions
    5. **Measure performance** - Use profiling tools

## Resources & Tools

!!! grid "2"

    !!! card "📚 Learning Materials"
        
        ### Essential Resources
        
        - [Zig Documentation](https://ziglang.org/documentation/)
        - [Algorithm Visualizations](https://visualgo.net/)
        - [Design Patterns](https://refactoring.guru/design-patterns)
        - [Competitive Programming Handbook](https://cp-algorithms.com/)
        
        ### Additional Reading
        
        - "The Zig Programming Language" - Andrew Kelley
        - "Introduction to Algorithms" - CLRS
        - "Clean Code" - Robert C. Martin

    !!! card "🛠️ Development Tools"
        
        ### Zig Ecosystem
        
        - [Zig Build System](https://ziglang.org/documentation/master/#Build-System)
        - [Testing Framework](https://ziglang.org/documentation/master/#Testing)
        - [Profiler](https://ziglang.org/documentation/master/#Profiling)
        - [Package Manager](https://github.com/ziglang/zig/wiki/Package-Manager)
        
        ### External Tools
        
        - VS Code with Zig extension
        - Ziglings interactive tutorial
        - Zig fmt for code formatting

!!! example "Project Template"

    ```zig title="Starter Project Structure"
    const std = @import("std");
    
    pub fn main() !void {
        const allocator = std.heap.page_allocator;
        
        // Your implementation here
        const result = try yourAlgorithm(allocator);
        std.debug.print("Result: {}\n", .{result});
    }
    
    test "basic functionality" {
        // Unit tests
        try std.testing.expect(1 + 1 == 2);
    }
    ```

!!! question "Need Help?"
    
    - Check the [GitHub Issues](https://github.com/llawn/zig-learn/issues)
    - Review similar implementations in the repository
    - Join the [Zig Discord](https://discord.gg/ziglang) community
    - Reference the [Zig Standards](https://ziglang.org/documentation/master/#Style-Guide)
