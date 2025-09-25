
# Jac Language Keywords Reference

_A comprehensive guide to Jac programming language keywords_


## Table of Contents
1. [Overview](#overview)
2. [Archetype and Data Structure Keywords](#archetype-and-data-structure-keywords)
3. [Variable and State Declaration Keywords](#variable-and-state-declaration-keywords)
4. [Ability and Function Keywords](#ability-and-function-keywords)
5. [Control Flow and Logic Keywords](#control-flow-and-logic-keywords)
6. [Walker-Specific Control Keywords](#walker-specific-control-keywords)
7. [Common Patterns and Use Cases](#common-patterns-and-use-cases)
8. [Error Handling Patterns](#error-handling-patterns)

---

## Overview

Jac is a graph programming language that combines Python-like syntax with graph computing capabilities. This reference covers all major keywords with practical examples and cross-references.

---

## Archetype and Data Structure Keywords

### `obj`

Full Definition: Defines a standard object, similar to a Python class, for holding data and behaviors.
Summary: Used to create objects that hold data and behaviors like Python classes.
Related Keywords: class, node, has
Common Use Cases: Data transfer objects, utility classes, Python integration
Example:


```jac
obj Person {
    has name: str;
    has age: int;

    can introduce {
        print(f"Hello, I'm {self.name}, age {self.age}");
    }
}

with entry {
    person = Person(name="Alice", age=30);
    person::introduce;  // Output: Hello, I'm Alice, age 30
}
```


### `node`
Full Definition: Represents a vertex or location in a graph, capable of storing data.
Summary: Used to define vertices or locations in a graph that can store data.
Related Keywords: edge, walker, visit, has
Common Use Cases: Graph vertices, data storage points, network nodes

Example:
```jac
node city {
    has name: str;
    has population: int;
}

with entry {
    root ++> city(name="New York", population=8419000);
    // Creates a graph node representing a city, connected to root
}
```


### `edge`
Full Definition: Defines a directed connection between two nodes, which can have its own attributes and logic.
Summary: Used to create directed connections between nodes with their own attributes and logic.
Related Keywords: node, visit, ignore, has
Common Use Cases: Relationships, dependencies, network connections

Example:
```jac
edge road {
    has distance: int;
    has highway: bool = false;
}

node city {
    has name: str;
}

with entry {
    ny = root ++> city(name="NY");
    boston = ny ++[road(distance=200, highway=true)]> city(name="Boston");
    // Defines an edge with properties connecting two nodes
}
```


### `walker`
Full Definition: A mobile computational agent that traverses the graph of nodes and edges to process data.
Summary: Used to create agents that move through graphs to process data.
Related Keywords: node, edge, visit, spawn, ignore
Common Use Cases: Graph traversal, data processing, workflow execution

Example:
```jac
node place {
    has name: str;
}

walker explorer {
    can visit_place with place entry {
        print(f"Visiting: {here.name}");
        visit [-->];  // Continue to next node
    }
}

with entry {
    // Create a simple graph
    start = root ++> place(name="Start");
    middle = start ++> place(name="Middle");
    end = middle ++> place(name="End");

    root spawn explorer();  // Traverses and prints all node names
}
// Output:
// Visiting: Start
// Visiting: Middle
// Visiting: End
```


### `class`
Full Definition: Defines a standard Python-compatible class, allowing for seamless integration with the Python ecosystem.
Summary: Used to define classes compatible with Python for ecosystem integration.
Related Keywords: obj, def, has
Common Use Cases: Python library integration, complex algorithms, external API wrappers

Example:
```jac
class Calculator {
    has precision: int = 2;

    def add(a: int, b: int) -> int {
        return a + b;
    }

    def divide(a: float, b: float) -> float {
        if b == 0 {
            raise ValueError("Division by zero");
        }
        return round(a / b, .precision);
    }
}

with entry {
    calc = Calculator(precision=3);
    print(calc.add(2, 3));        // Output: 5
    print(calc.divide(10, 3));    // Output: 3.333
}
```


### `enum`
Full Definition: Creates an enumeration, a set of named constants.
Summary: Used to define a set of named constants.
Related Keywords: match, case
Common Use Cases: State management, type safety, configuration options

Example:
```jac
enum Color { RED, GREEN, BLUE }
enum Status { PENDING, PROCESSING, COMPLETED, FAILED }

with entry {
    current_color = Color.RED;
    task_status = Status.PROCESSING;

    print(current_color);  // Output: Color.RED
    print(task_status);    // Output: Status.PROCESSING
}
```


---

## Variable and State Declaration Keywords


### `has`
Full Definition: Declares an instance variable within an archetype, with mandatory type hints.
Summary: Used to declare instance variables in archetypes with type hints.
Related Keywords: node, edge, obj, class
Common Use Cases: Object properties, node attributes, state storage

Example:
```jac
node product {
    has name: str;
    has price: float = 0.0;
    has in_stock: bool = true;
}

with entry {
    item = root ++> product(name="Laptop", price=999.99);
    print(f"{item.name}: ${item.price}");  // Output: Laptop: $999.99
}
```


### `let`
Full Definition: Declares a module-level variable with lexical (module-level) scope.
Summary: Used to declare variables at the module level with lexical scope.
Related Keywords: glob, nonlocal, def
Common Use Cases: Module constants, shared state within module, configuration

Example:
```jac
let MAX_USERS: int = 100;
let APP_VERSION: str = "1.0.0";

def create_user(username: str) -> bool {
    if users_count >= MAX_USERS {
        return false;
    }
    // User creation logic
    return true;
}

with entry {
    print(f"App {APP_VERSION} supports up to {MAX_USERS} users");
}
```


### `glob`
Full Definition: Declares a global variable accessible across all modules.
Summary: Used to declare variables accessible across all modules.
Related Keywords: global, let
Common Use Cases: Application configuration, shared resources, global state

Example:
```jac
glob DATABASE_URL: str = "postgresql://localhost:5432/mydb";
glob DEBUG_MODE: bool = true;

with entry {
    if DEBUG_MODE {
        print(f"Database: {DATABASE_URL}");
    }
}
```


### `global`
Full Definition: Modifies a global variable from within a local scope.
Summary: Used to modify global variables from within a local scope.
Related Keywords: glob, nonlocal
Common Use Cases: Global counters, application state updates, shared resources

Example:
```jac
glob request_count: int = 0;
glob active_users: set = set();

def handle_request(user_id: int) {
    global request_count, active_users;
    request_count += 1;
    active_users.add(user_id);
}

with entry {
    handle_request(123);
    handle_request(456);
    print(f"Total requests: {request_count}");  // Output: Total requests: 2
}
```


### `nonlocal`
Full Definition: Modifies a variable from a nearby enclosing scope that isn't global.
Summary: Used to modify variables in a nearby enclosing scope that isn't global.
Related Keywords: let, global
Common Use Cases: Closures, nested function state, decorators

Example:
```jac
def create_counter() {
    let count: int = 0;

    def increment() -> int {
        nonlocal count;
        count += 1;
        return count;
    }

    def get_count() -> int {
        return count;
    }

    return (increment, get_count);
}

with entry {
    (inc, get) = create_counter();
    print(inc());  // Output: 1
    print(inc());  // Output: 2
    print(get());  // Output: 2
}
```


---

## Ability and Function Keywords


### `can`
Full Definition: Defines an "ability" (a method) for an archetype.
Summary: Used to define methods for archetypes.
Related Keywords: node, edge, obj, impl
Common Use Cases: Object behaviors, node operations, reusable functionality

Example:
```jac
node bank_account {
    has balance: float = 0.0;
    has owner: str;

    can deposit(amount: float) -> float {
        .balance += amount;
        return .balance;
    }

    can withdraw(amount: float) -> float {
        if amount <= .balance {
            .balance -= amount;
            return .balance;
        } else {
            raise ValueError("Insufficient funds");
        }
    }
}

with entry {
    account = root ++> bank_account(owner="Alice", balance=100.0);
    account::deposit(50.0);
    print(account.balance);  // Output: 150.0
}
```


### `def`
Full Definition: Defines a standard function with mandatory type annotations.
Summary: Used to define functions with mandatory type annotations.
Related Keywords: can, yield, class
Common Use Cases: Utility functions, algorithms, business logic

Example:
```jac
def calculate_tax(income: float, rate: float = 0.2) -> float {
    if income < 0 {
        raise ValueError("Income cannot be negative");
    }
    return income * rate;
}

def fibonacci(n: int) -> list {
    let result: list = [];
    let a: int = 0, b: int = 1;

    for i in range(n) {
        result.append(a);
        a, b = b, a + b;
    }
    return result;
}

with entry {
    tax = calculate_tax(50000, 0.25);
    fib_sequence = fibonacci(10);
    print(f"Tax: ${tax}");  // Output: Tax: $12500.0
    print(fib_sequence);    // Output: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
}
```


### `impl`
Full Definition: Separates the implementation of a construct from its declaration.
Summary: Used to separate the implementation from the declaration of a construct.
Related Keywords: can, node, class
Common Use Cases: Large codebases, interface segregation, code organization

Example:
```jac
// Declaration
node data_processor {
    can process_data;
    can validate_input;
    can generate_report;
}

// Implementation
impl data_processor {
    can process_data {
        print("Processing data...");
        // Complex processing logic
        here::generate_report;
    }

    can validate_input {
        print("Validating input...");
        return true;
    }

    can generate_report {
        print("Generating report...");
    }
}

with entry {
    processor = root ++> data_processor();
    if processor::validate_input {
        processor::process_data;
    }
}
```


### `yield`
Full Definition: Pauses a function, returns a value, and creates a generator.
Summary: Used to pause a function and return values, creating a generator.
Related Keywords: def, for, while
Common Use Cases: Large datasets, streaming data, memory-efficient iteration

Example:
```jac
def read_large_file(filename: str) {
    // Simulate reading a large file line by line
    let lines: list = ["line1", "line2", "line3", "line4"];
    for line in lines {
        yield line;
    }
}

def countdown(n: int) {
    while n > 0 {
        yield n;
        n -= 1;
    }
    yield "Blastoff!";
}

with entry {
    // Process file efficiently
    for line in read_large_file("data.txt") {
        print(f"Processing: {line}");
    }

    // Countdown example
    for value in countdown(3) {
        print(value);  // Output: 3, 2, 1, Blastoff!
    }
}
```


---

## Control Flow and Logic Keywords


### `if` / `elif` / `else`

Full Definition: Executes code blocks conditionally.
Summary: Used to execute code blocks based on conditions.
Related Keywords: match, case, while
Common Use Cases: Conditional logic, decision making, validation

Example:
```jac
with entry {
    let score: int = 85;
    let grade: str;

    if score >= 90 {
        grade = "A";
    } elif score >= 80 {
        grade = "B";
    } elif score >= 70 {
        grade = "C";
    } else {
        grade = "F";
    }

    print(f"Score: {score}, Grade: {grade}");  // Output: Score: 85, Grade: B
}
```


### `for`
Full Definition: Iterates over a sequence.
Summary: Used to iterate over a sequence.
Related Keywords: while, break, continue, yield
Common Use Cases: Collection processing, batch operations, sequence generation

Example:
```jac
with entry {
    // Basic iteration
    for i in range(5) {
        print(i);  // Output: 0, 1, 2, 3, 4
    }

    // Iterating with index and value
    let fruits: list = ["apple", "banana", "cherry"];
    for index, fruit in enumerate(fruits) {
        print(f"{index}: {fruit}");
    }
    // Output:
    // 0: apple
    // 1: banana
    // 2: cherry
}
```


### `while`
Full Definition: Creates a loop that executes as long as a condition is true.
Summary: Used to create loops that run while a condition is true.
Related Keywords: for, break, continue
Common Use Cases: Unknown iteration counts, polling, game loops

Example:
```jac
with entry {
    // Simple counter
    let count: int = 0;
    while count < 5 {
        print(count);
        count += 1;
    }

    // Simulate game loop
    let game_running: bool = true;
    let player_health: int = 100;

    while game_running and player_health > 0 {
        // Game logic here
        player_health -= 10;
        print(f"Health: {player_health}");

        if player_health <= 0 {
            print("Game Over!");
            game_running = false;
        }
    }
}
```


### `match` / `case`
Full Definition: Implements structural pattern matching.
Summary: Used to implement structural pattern matching.
Related Keywords: if, elif, else, enum
Common Use Cases: Complex conditional logic, state machines, type checking

Example:
```jac
enum HttpStatus { OK, NOT_FOUND, ERROR }

def handle_response(status: HttpStatus, data: any) {
    match status {
        case HttpStatus.OK:
            print(f"Success: {data}");
        case HttpStatus.NOT_FOUND:
            print("Resource not found");
        case HttpStatus.ERROR:
            print(f"Error: {data}");
        case _:
            print("Unknown status");
    }
}

with entry {
    handle_response(HttpStatus.OK, "Data loaded");
    handle_response(HttpStatus.NOT_FOUND, null);

    // Pattern matching with values
    let value: any = [1, 2, 3];
    match value {
        case str as s:
            print(f"String: {s}");
        case list as l if len(l) > 0:
            print(f"Non-empty list: {l}");
        case list as l:
            print("Empty list");
        case _:
            print("Other type");
    }
    // Output: Non-empty list: [1, 2, 3]
}
```


### `try` / `except` / `finally`
Full Definition: Handles exceptions.
Summary: Used to handle exceptions in code.
Related Keywords: raise, def
Common Use Cases: Error handling, resource cleanup, fault tolerance

Example:
```jac
def divide_safe(a: float, b: float) -> float {
    try {
        if b == 0 {
            raise ValueError("Division by zero attempted");
        }
        return a / b;
    } except ValueError as e {
        print(f"Value error: {e}");
        return 0.0;
    } except Exception as e {
        print(f"Unexpected error: {e}");
        return 0.0;
    } finally {
        print("Division operation completed");
    }
}

with entry {
    result1 = divide_safe(10, 2);   // Output: Division operation completed
    result2 = divide_safe(10, 0);   // Output: Value error: Division by zero attempted
                                    //         Division operation completed
    print(f"Results: {result1}, {result2}");  // Output: Results: 5.0, 0.0
}
```


### `break`
Full Definition: Exits the current loop.
Summary: Used to exit the current loop.
Related Keywords: continue, for, while
Common Use Cases: Early termination, search algorithms, condition satisfaction

Example:
```jac
with entry {
    // Search for a specific value
    let numbers: list = [1, 3, 5, 7, 9, 2, 4, 6, 8];
    let found: bool = false;

    for num in numbers {
        if num % 2 == 0 {  // Find first even number
            print(f"Found even number: {num}");
            found = true;
            break;
        }
        print(f"Checking {num}");
    }

    if not found {
        print("No even numbers found");
    }
}
```


### `continue`
Full Definition: Proceeds to the next iteration of a loop.
Summary: Used to proceed to the next iteration of a loop.
Related Keywords: break, for, while
Common Use Cases: Skipping elements, filtering, conditional processing

Example:
```jac
with entry {
    // Process only even numbers
    for i in range(10) {
        if i % 2 != 0 {  // Skip odd numbers
            continue;
        }
        print(f"Processing even number: {i}");
    }

    // Output: Processing even number: 0, 2, 4, 6, 8
}
```


### `raise`
Full Definition: Triggers an exception.
Summary: Used to trigger an exception.
Related Keywords: try, except, def
Common Use Cases: Error conditions, validation failures, custom exceptions

Example:
```jac
class CustomError {
    has message: str;
}

def validate_age(age: int) -> bool {
    if age < 0 {
        raise ValueError("Age cannot be negative");
    }
    if age > 150 {
        raise CustomError(message="Age seems unrealistic");
    }
    if age < 18 {
        return false;
    }
    return true;
}

with entry {
    try {
        validate_age(200);
    } except CustomError as e:
        print(f"Custom error: {e.message}");
    } except ValueError as e:
        print(f"Value error: {e}");
    }
    // Output: Custom error: Age seems unrealistic
}
```


---

## Walker-Specific Control Keywords


### `visit`
Full Definition: Directs a walker to traverse to a node or edge.
Summary: Used to direct walkers to traverse to nodes or edges.
Related Keywords: walker, node, edge, ignore, spawn
Common Use Cases: Graph traversal, path finding, data collection

Example:
```jac
node step {
    has num: int;
    has visited: bool = false;
}

walker explorer {
    can traverse with step entry {
        here.visited = true;
        print(f"Step {here.num} visited");

        // Visit all outgoing connections
        visit [-->];
    }
}

with entry {
    // Create a path: root -> step1 -> step2 -> step3
    step1 = root ++> step(num=1);
    step2 = step1 ++> step(num=2);
    step3 = step2 ++> step(num=3);

    root spawn explorer();
    // Output: Step 1 visited, Step 2 visited, Step 3 visited
}
```

### `spawn`
Full Definition: Creates and starts a walker on a graph.
Summary: Used to create and start walkers on a graph.
Related Keywords: walker, visit, node
Common Use Cases: Parallel processing, multi-walker systems, task delegation

Example:
```jac
node task {
    has name: str;
    has completed: bool = false;
}

walker worker {
    has worker_id: int;

    can process with task entry {
        here.completed = true;
        print(f"Worker {.worker_id} completed task: {here.name}");
    }
}

with entry {
    // Create tasks
    task1 = root ++> task(name="Data Processing");
    task2 = root ++> task(name="Report Generation");
    task3 = root ++> task(name="Cleanup");

    // Spawn multiple workers
    root spawn worker(worker_id=1);
    root spawn worker(worker_id=2);
    // Workers will process tasks in parallel
}
```


### `ignore`
Full Definition: Excludes a node or edge from a walker's traversal.
Summary: Used to exclude nodes or edges from a walker's traversal.
Related Keywords: walker, visit, node, edge
Common Use Cases: Filtered traversal, conditional paths, access control

Example:
```jac
node content {
    has type: str;  // "public" or "private"
    has data: str;
}

walker reader {
    can browse with content entry {
        print(f"Reading: {here.data}");

        // Ignore private content and its connections
        ignore [-->] where here.type == "private";
        visit [-->];
    }
}

with entry {
    // Create content chain: public -> private -> public
    public1 = root ++> content(type="public", data="Public Info 1");
    private = public1 ++> content(type="private", data="Secret Data");
    public2 = private ++> content(type="public", data="Public Info 2");

    root spawn reader();
    // Output: Reading: Public Info 1
    //         (private content is ignored)
    //         Reading: Public Info 2
}
```
