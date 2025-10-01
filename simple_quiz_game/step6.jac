import random;

walker QuizGame {
    has score: int = 0;

    can start_game with root entry;
    can process_answer(answer: str, correct: str);
}

node question {
    has q: str,
        options: str,
        a: str;

    can ask with QuizGame entry;
}

with entry {
    spawn here walker::QuizGame;
}

impl QuizGame.start_game {
    questions = [
        {"q": "What does AI stand for?", "options": "A: Artificial Intelligence, B: Automated Input", "a": "A"},
        {"q": "What is ML?", "options": "A: Machine Language, B: Machine Learning", "a": "B"}
    ];  # Add more up to 5
    random.shuffle(questions);
    end: node = here;
    for q in questions {
        end ++> (end := spawn node::question(q=q["q"], options=q["options"], a=q["a"]));
    }
    visit end[-->];
    std.out("Score: " + str(self.score) + "/" + str(len(questions)));
}

impl QuizGame.process_answer(answer: str, correct: str) {
    if answer == correct {
        std.out("Correct!");
        self.score += 1;
    } else {
        with byllm model="gpt-4o" {
            std.out("Generate a fun, educational hint for why the answer to '" + here.q + "' is wrong, relating to AI trends.");
        }
    }
}

impl question.ask {
    std.out(self.q);
    std.out(self.options);
    answer = input("Your answer (A/B): ").upper();
    visitor.process_answer(answer, self.a);
    visit here[-->];
}