Category,Keyword,Full Definition,Summary,Example
Archetype and Data Structure Keywords,obj,"Defines a standard object, similar to a Python class, for holding data and behaviors.",Used to create objects that hold data and behaviors like Python classes.,```jac
Archetype and Data Structure Keywords,node,"Represents a vertex or location in a graph, capable of storing data.",Used to define vertices or locations in a graph that can store data.,"jac<br>node city {<br>    has name: str;<br>}<br>with entry {<br>    root ++> city(name=""New York"");<br>}<br>
// Creates a graph node representing a city, connected to root."
Archetype and Data Structure Keywords,edge,"Defines a directed connection between two nodes, which can have its own attributes and logic.",Used to create directed connections between nodes with their own attributes and logic.,"jac<br>edge road {<br>    has distance: int;<br>}<br>node city { has name: str; }<br>with entry {<br>    c1 = root ++> city(name=""NY"");<br>    c2 = c1 ++[road(distance=200)]> city(name=""Boston"");<br>}<br>
// Defines an edge with a property, used to connect two nodes."
Archetype and Data Structure Keywords,walker,A mobile computational agent that traverses the graph of nodes and edges to process data.,Used to create agents that move through graphs to process data.,"jac<br>node place { has name: str; }<br>walker explorer {<br>    can visit_place with place entry {<br>        print(here.name);<br>        visit [-->];<br>    }<br>}<br>with entry {<br>    root ++> place(name=""Start"");<br>    root spawn explorer();<br>}<br>
// Walker traverses and prints node names."
Archetype and Data Structure Keywords,class,"Defines a standard Python-compatible class, allowing for seamless integration with the Python ecosystem.",Used to define classes compatible with Python for ecosystem integration.,"jac<br>class Calculator {<br>    def add(a: int, b: int) -> int {<br>        return a + b;<br>    }<br>}<br>with entry {<br>    print(Calculator.add(2, 3));<br>}<br>
// Output: 5 – Defines a Python-like class with a static method."
Archetype and Data Structure Keywords,enum,"Creates an enumeration, a set of named constants.",Used to define a set of named constants.,"jac<br>enum Color { RED, GREEN, BLUE }<br>with entry {<br>    print(Color.RED);<br>}<br>
// Output: Color.RED – Defines and uses an enum value."
Variable and State Declaration Keywords,has,"Declares an instance variable within an archetype, with mandatory type hints.",Used to declare instance variables in archetypes with type hints.,"jac<br>node item {<br>    has value: int = 42;<br>}<br>with entry {<br>    i = root ++> item();<br>    print(i.value);<br>}<br>
// Output: 42 – Declares a node property with default value."
Variable and State Declaration Keywords,let,Declares a module-level variable with lexical (module-level) scope.,Used to declare variables at the module level with lexical scope.,"jac<br>let counter: int = 0;<br>def increment() -> int {<br>    counter += 1;<br>    return counter;<br>}<br>with entry {<br>    print(increment());  // 1<br>}<br>
// Declares a module-level variable modified in a function."
Variable and State Declaration Keywords,glob,Declares a global variable accessible across all modules.,Used to declare variables accessible across all modules.,"jac<br>glob APP_NAME: str = ""MyApp"";<br>with entry {<br>    print(APP_NAME);<br>}<br>
// Output: ""MyApp"" – Declares a global constant usable anywhere."
Variable and State Declaration Keywords,global,Modifies a global variable from within a local scope.,Used to modify global variables from within a local scope.,"jac<br>glob count: int = 0;<br>def increase() {<br>    global count;<br>    count += 1;<br>}<br>with entry {<br>    increase();<br>    print(count);  // 1<br>}<br>
// Modifies a global from inside a function."
Variable and State Declaration Keywords,nonlocal,Modifies a variable from a nearby enclosing scope that isn't global.,Used to modify variables in a nearby enclosing scope that isn't global.,"jac<br>def outer() {<br>    let x: int = 10;<br>    def inner() {<br>        nonlocal x;<br>        x += 5;<br>    }<br>    inner();<br>    print(x);  // 15<br>}<br>with entry {<br>    outer();<br>}<br>
// Modifies an enclosing variable in a nested function."
Ability and Function Keywords,can,"Defines an ""ability"" (a method) for an archetype.",Used to define methods for archetypes.,"jac<br>node greeter {<br>    can say_hello {<br>        print(""Hello!"");<br>    }<br>}<br>with entry {<br>    g = root ++> greeter();<br>    g::say_hello;<br>}<br>
// Output: ""Hello!"" – Defines and calls a node method."
Ability and Function Keywords,def,Defines a standard function with mandatory type annotations.,Used to define functions with mandatory type annotations.,"jac<br>def multiply(a: int, b: int) -> int {<br>    return a * b;<br>}<br>with entry {<br>    print(multiply(4, 5));  // 20<br>}<br>
// Defines and uses a typed function."
Ability and Function Keywords,impl,Separates the implementation of a construct from its declaration.,Used to separate the implementation from the declaration of a construct.,"jac<br>node processor {<br>    can process;<br>}<br>impl processor {<br>    can process {<br>        print(""Processing..."");<br>    }<br>}<br>with entry {<br>    p = root ++> processor();<br>    p::process;<br>}<br>
// Output: ""Processing..."" – Declares and implements a method separately."
Ability and Function Keywords,yield,"Pauses a function, returns a value, and creates a generator.","Used to pause a function and return values, creating a generator.","jac<br>def count_up(n: int) {<br>    let i: int = 0;<br>    while i < n {<br>        yield i;<br>        i += 1;<br>    }<br>}<br>with entry {<br>    for num in count_up(3) {<br>        print(num);  // 0 1 2<br>    }<br>}<br>
// Creates a generator that yields values in a loop."
Control Flow and Logic Keywords,if / elif / else,Executes code blocks conditionally.,Used to execute code blocks based on conditions.,"jac<br>with entry {<br>    let age: int = 20;<br>    if age >= 18 {<br>        print(""Adult"");<br>    } elif age >= 13 {<br>        print(""Teen"");<br>    } else {<br>        print(""Child"");<br>    }<br>}<br>
// Output: ""Adult"" – Conditional branching."
Control Flow and Logic Keywords,for,Iterates over a sequence.,Used to iterate over a sequence.,"jac<br>with entry {<br>    for i in range(3) {<br>        print(i);  // 0 1 2<br>    }<br>}<br>
// Iterates over a range and prints values."
Control Flow and Logic Keywords,while,Creates a loop that executes as long as a condition is true.,Used to create loops that run while a condition is true.,"jac<br>with entry {<br>    let x: int = 0;<br>    while x < 3 {<br>        print(x);  // 0 1 2<br>        x += 1;<br>    }<br>}<br>
// Loops until condition is false."
Control Flow and Logic Keywords,match / case,Implements structural pattern matching.,Used to implement structural pattern matching.,"jac<br>with entry {<br>    let value: int = 2;<br>    match value {<br>        case 1: print(""One"");<br>        case 2: print(""Two"");<br>        case _: print(""Other"");<br>    }<br>}<br>
// Output: ""Two"" – Matches value and executes corresponding code."
Control Flow and Logic Keywords,try / except / finally,Handles exceptions.,Used to handle exceptions in code.,"jac<br>with entry {<br>    try {<br>        raise ValueError(""Error!"");<br>    } except ValueError as e {<br>        print(""Caught:"", e);<br>    } finally {<br>        print(""Cleanup"");<br>    }<br>}<br>
// Output: ""Caught: Error!"" then ""Cleanup"" – Handles and cleans up after an exception."
Control Flow and Logic Keywords,break,Exits the current loop.,Used to exit the current loop.,"jac<br>with entry {<br>    let i: int = 0;<br>    while True {<br>        if i == 2 { break; }<br>        print(i);  // 0 1<br>        i += 1;<br>    }<br>}<br>
// Exits the loop early."
Control Flow and Logic Keywords,continue,Proceeds to the next iteration of a loop.,Used to proceed to the next iteration of a loop.,"jac<br>with entry {<br>    for i in range(4) {<br>        if i == 1 { continue; }<br>        print(i);  // 0 2 3<br>    }<br>}<br>
// Skips an iteration."
Control Flow and Logic Keywords,raise,Triggers an exception.,Used to trigger an exception.,"jac<br>def check_positive(n: int) {<br>    if n < 0 { raise ValueError(""Negative!""); }<br>}<br>with entry {<br>    check_positive(-1);  // Raises error<br>}<br>
// Throws a custom exception."
Walker-Specific Control Keywords,visit,Directs a walker to traverse to a node or edge.,Used to direct walkers to traverse to nodes or edges.,"jac<br>node step { has num: int; }<br>walker mover {<br>    can go with step entry {<br>        print(here.num);<br>        visit [-->];<br>    }<br>}<br>with entry {<br>    root ++> step(num=1) ++> step(num=2);<br>    root spawn mover();  // Prints 1 then 2<br>}<br>
// Traverses forward edges."
Walker-Specific Control Keywords,spawn,Creates and starts a walker on a graph.,Used to create and start walkers on a graph.,"jac<br>walker hello {<br>    can greet with root entry { print(""Hi!""); }<br>}<br>with entry {<br>    root spawn hello();<br>}<br>
// Output: ""Hi!"" – Instantiates and runs a walker on root."
Walker-Specific Control Keywords,ignore,Excludes a node or edge from a walker's traversal.,Used to exclude nodes or edges from a walker's traversal.,"jac<br>node skip_me { has flag: bool = True; }<br>node keep_me {}<br>walker selector {<br>    can check with root entry {<br>        ignore [-->] where here.flag;<br>        visit [-->];<br>    }<br>    can print_keep with keep_me entry { print(""Kept!""); }<br>}<br>with entry {<br>    root ++> skip_me() ++> keep_me();<br>    root spawn selector();  // Output: ""Kept!""<br>}<br>
// Skips nodes matching a condition during traversal."
