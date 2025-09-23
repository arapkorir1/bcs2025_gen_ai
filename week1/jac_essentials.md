# Jac Essentials Cheat Sheet

## 1. Basic Concepts
- **Node**: Data entity (like a class/object).
- **Edge**: Connection between nodes.
- **Graph**: Container for nodes and edges.
- **Walker**: Mobile agent that traverses the graph and performs actions.
- **Ability**: Function attached to nodes or walkers.

## 2. Syntax Overview

### Node Definition
```jac
node trend {
    has title: str;
    has description: str;
}
```

### Graph Definition
```jac
graph trends_graph {
    has anchor root_trend;
    spawn {
        root_trend = spawn here node::trend(title="Root", description="...");
    }
}
```

### Edge Creation
```jac
node1 <--> node2; // Bidirectional edge
node1 --> node2;  // Unidirectional edge
```

### Walker Definition
```jac
walker summarize {
    has summary: str = "";
    root {
        take -->;
    }
    trend {
        summary += title + ": " + description + "\n";
        report summary;
        take --> else disengage;
    }
}
```

### Abilities (Functions)
```jac
can greet() {
    report "Hello from node!";
}
```

### Spawning Nodes/Edges
```jac
new_node = spawn here node::trend(title="AI", description="...");
```

## 3. Common Keywords
- `node`, `graph`, `walker`, `has`, `spawn`, `take`, `report`, `can`, `else`, `disengage`, `here`, `root`, `anchor`

## 4. Running Jac
- From terminal: `jac run your_file.jac`
- From Python: Use Jaseci's Python API

## 5. Example: Minimal Jac Program
```jac
node hello_node {
    has msg: str;
}
walker hello {
    root {
        report "Hello, Jac!";
    }
}
```

## 6. Tips
- Use comments with `//`.
- Indentation is important (like Python).
- Walkers can traverse edges using `take`.
- Use `report` to output data.

---
This cheat sheet covers the essentials of Jac. For more, see the [Jaseci Docs](https://docs.jaseci.org/).
