# Zig-Learn
!!! abstract "Master Computer Science with Zig"
    A comprehensive journey through fundamental computer science concepts using the Zig Programming Language. This repository serves as a personal laboratory for learning and exploring data structures, algorithms, and design patterns with modern, memory-safe implementations.

## Quick Start

!!! tip "Before You Begin"
    Ensure you have the following prerequisites installed:

    ```bash
    # Check Zig version (requires 0.15+)
    zig version
    
    # Verify Git is available
    git --version
    ```

=== "Clone & Run"

    ```bash
    git clone https://github.com/llawn/zig-learn.git
    cd zig-learn
    # Run any example
    zig run data_structures/01_linear/01_arrays.zig
    ```

=== "Build All"

    ```bash
    zig build
    # Run tests
    zig build test
    ```

## Learning Path

!!! success "Choose Your Journey"
    
    --8<-- "docs/learning-journey.md"

## Featured Content

!!! grid "2" 

    !!! card ""
        ### 📊 Data Structures
        From fundamental arrays to advanced graph structures. Master memory management and algorithmic thinking.
        
        [:material-play-arrow: Start Learning](data_structures/linear.md){ .md-button .md-button--primary }
    
    !!! card ""
        ### ⚡ Algorithms  
        Explore sorting, searching, and optimization algorithms with detailed complexity analysis.
        
        [:material-play-arrow: Explore Algorithms](algorithms.md){ .md-button .md-button--primary }
    
    !!! card ""
        ### 🏗️ Design Patterns
        Learn creational, structural, and behavioral patterns implemented in idiomatic Zig.
        
        [:material-play-arrow: View Patterns](patterns.md){ .md-button }
    
    !!! card ""
        ### 💻 Practice Projects
        Apply your knowledge with hands-on coding challenges and real-world implementations.
        
        [:material-play-arrow: Start Projects](projects.md){ .md-button }

## What Makes This Special

!!! quote "Why Zig for Learning?"
    
    Zig provides unique advantages for implementing computer science concepts:
    
    - **Memory Safety**: Compile-time bounds checking prevent common bugs
    - **Zero-cost Abstractions**: Generics without runtime overhead  
    - **Explicit Control**: Full understanding of memory allocation
    - **Comptime Magic**: Compile-time code generation and optimization

!!! info "Project Status"
    
    This is an ongoing learning project. Check the [README](https://github.com/llawn/zig-learn/blob/main/README.md) for the latest progress and implementation status.

!!! question "Need Help?"
    
    If you have questions or suggestions, please visit the [GitHub repository](https://github.com/llawn/zig-learn) and open an issue.
