import random;

walker GuessGame {
    has correct_number: int = random.randint(1, 10);

    can start_game with root entry;
    can process_guess(guess: int);
}

node turn {
    can check with GuessGame entry;
}

with entry {
    spawn here walker::GuessGame;
}

impl GuessGame.start_game {
    end: node = here;
    for i = 0 to i < 10 by i += 1 {
        end ++> (end := node::turn);
    }
    visit end[-->];
}

impl GuessGame.process_guess(guess: int) {
    if guess > self.correct_number {
        std.out("Too high!");
    } elif guess < self.correct_number {
        std.out("Too low!");
    } else {
        std.out("Congratulations! You guessed correctly.");
        disengage;
    }
}

impl turn.check {
    guess = input("Guess a number between 1 and 10: ");
    if guess.isdigit() {
        visitor.process_guess(int(guess));
    } else {
        std.out("That's not a valid number! Try again.");
    }
    visit here[-->];
}
