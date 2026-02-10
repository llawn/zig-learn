# RAM (Random-Access-Memory)

It's the high-speed "short-term memory" where your computer stores data that
it's currently using. It vanishes on reboot.

# Stack vs Heap

Both are part of the computer RAM but they serve very different purposes in how
a programs runs.

## Stack

The stack is used for **static memory allocation**. It used LIFO principle.
When you call a function, a "frame" is added to the top; when the function ends,
that frame is "popped" off.

- Speed: Extremely Fast
- Management: Automatic (malloc and free)
- Size: Limited and fixed (that's why a recursive function can get a Stack Overflow error).
- Data: local variables and function call addresses

## Heap

The Heap is used for dynamic memory allocation.
It’s a large pool of memory that doesn't have a strict order.
You "rent" a chunk of it when you need it and (ideally) return it when you're done.
If you don't free memory after usage, it will take up space on your RAM (Memory Leak)

- Speed: Slower. Finding an empty block of memory and managing pointers takes time.
- Management: Manual (mostly)
- Size: Much larger than the Stack, limited only by your physical RAM.
- Data Type: Stores large objects, global variables, and data that needs to stay alive even after a function finishes

# Data segment

The **data segment** is a specific portion of a program's memory that contains the data used by the application.
While the **code segment** holds the instructions, the **data segment** holds the actual variables and values those instructions act upon.

## The Anatomy of the Data Segment

The data segment is typically divided into two main parts based on how the variables are initialized:

### 1. Initialized Data Segment

This area stores global and static variables that have been assigned a specific value by the programmer before the program runs.

- **Example:** `int count = 10;`
- **Characteristics:** It is part of the program's executable file because the computer needs to know what those starting values are.

### 2. Uninitialized Data Segment (BSS)

Often called the **BSS** (Block Started by Symbol).
This area holds global and static variables that are declared but not initialized to a specific value.

- **Example:** `int total;`
- **Characteristics:** It doesn't take up space in the executable file on your disk. Instead, the operating system simply allocates and zeros out this memory when the program starts.

## Where Does It Sit in Memory?

To visualize how a program lives in RAM, look at this simplified hierarchy:

| Segment | Purpose |
| --- | --- |
| **Stack** | Local variables and function call management. |
| **Heap** | Dynamic memory allocated at runtime (`malloc`). |
| **Data Segment** | **Global and static variables (Initialized & BSS).** |
| **Text Segment** | The actual machine code (instructions). |


## Key Characteristics

- **Fixed Size:** The size of the data segment is generally determined at "compile time," meaning it doesn't grow or shrink while the program is running (unlike the Stack or Heap).
- **Persistence:** Variables in the data segment stay in memory for the entire duration of the program's life.
- **Permissions:** Usually, this segment is **readable and writable**, but not executable.

> **Note:** Modern operating systems use a technique called "Virtual Memory" to ensure that one program's data segment doesn't accidentally overwrite another program's data.

# Life Cycle of a program

## Build Time

This is everything that happens on your computer **before** the program is ready to be shared.

- **Coding:** You write the source code.
- **Preprocessing:** The computer handles "housekeeping" (like including libraries or expanding macros).
- **Compilation:** This is the big one. A **Compiler** translates your human-readable code into **Machine Code** (binary).
- **Linking:** If your code uses external libraries (like a graphics library), the Linker stitches your code and those libraries together into a single executable file (`.exe`).

## Compile Time (The "Grammar Check")

Compile time is a subset of Build Time. It is the moment the compiler is actually analyzing your code.

- **Errors:** If you forget a semicolon or try to add a string to an integer, you get a **Compile-Time Error**.
- **Optimizations:** The compiler looks for ways to make your code faster (e.g., pre-calculating so the computer doesn't have to do it every time the program runs).
- **Static Typing:** In languages like C# or Java, the compiler checks that all your variables are used correctly here.

## Run Time (The "Showtime" Phase)

This is when the user actually double-clicks the icon and the program executes in the **RAM**.

- **Loading:** The OS takes the code from the Hard Drive and puts it into RAM.
- **Execution:** The CPU starts following the instructions one by one.
- **Dynamic Tasks:** Things that can't be known in advance happen here—like user input, network requests, or allocating memory on the Heap.
- **Errors:** If your code tries to divide by zero or access memory it doesn't own, you get a **Run-Time Error** (or a Crash).

### Comparison: Why does it matter?

| Feature | Compile Time | Run Time |
| --- | --- | --- |
| **When?** | While you are developing. | While the user is using it. |
| **Goal** | To translate and find bugs. | To perform the task. |
| **Speed** | Slow compilation is okay. | Must be fast for the user. |
| **Errors** | Syntax errors, Type mismatches. | Logic errors, Crashes, Memory leaks. |

## Just-In-Time (JIT)

Some modern languages (like **Java**, **JavaScript**, and **Python**) blur these lines.

Instead of compiling everything once at Build Time, they use a **JIT Compiler**. This means they compile "on the fly" while the program is running. It’s like a translator who waits to hear what you say before translating it into another language in real-time.
