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
    questions=[{"q":"What is ML", "a":"A", "options": "A : Machine Learning , B : Machine Language"},{"q":"What is AI?", "a":"B", "options": "A : Automated Input , B : Artificial Intelligence "}];
    end: node = here;
    for q in questions {
        end ++> (end := spawn node::question(q=q["q"], options=q["options"], a=q["a"]));
    }
    visit end[-->];
    print("Score: " + str(self.score) + "/" + str(len(questions)));
}

impl QuizGame.process_answer(answer: str, correct: str) {
    if answer == correct {
        print("Correct!");
        self.score += 1;
    } else {
        print("Wrong! Hint: Think about automation.");
    }
}

impl question.ask {
    print(self.q);
    print(self.options);
    answer = input("Your answer (A/B): ").upper();
    visitor.process_answer(answer, self.a);
    visit here[-->];
}