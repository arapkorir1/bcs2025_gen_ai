
node trend {
    has title: str;
    has description: str;
}

# Define a graph to hold trends
graph trends_graph {
    has anchor root_trend;  // Starting point
    spawn {
        root_trend = spawn here node::trend(title="GenAI Root", description="Central hub for trends");
        // Spawn sample trends (in real project, populate dynamically)
        trend1 = spawn here --> node::trend(title="LLM Advancements", description="GPT-5 rumors and efficiency gains.");
        trend2 = spawn here --> node::trend(title="Ethical AI", description="Focus on bias mitigation in 2025.");
        // Connect them
        root_trend <--> trend1 <--> trend2;
    }
}

// Walker to traverse and summarize
walker summarize {
    has summary: str = "";
    root {
        take -->;  // Traverse to first child
    }
    trend {
        summary += title + ": " + description + "\n";
        report summary;  // Output
        take --> else disengage;  // Traverse next or stop
    }
}

// Entry point walker
walker init {
    root {
        spawn here graph::trends_graph;
        spawn here walker::summarize;
    }
}