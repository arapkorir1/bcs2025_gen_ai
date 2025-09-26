import random;

obj GuessGame {
    has correct_number: int,
        attempts: int = 0;

    def init() {
        self.correct_number = random.randint(1, 10);
    }

    def play {
        while self.attempts < 10 {
            guess = input("Guess a number between 1 and 10: ");
            if not guess.isdigit() {
                std.out("That's not a valid number! Try again.");
                continue;
            }
            guess = int(guess);
            self.attempts += 1;
            if guess > self.correct_number {
                std.out("Too high!");
            } elif guess < self.correct_number {
                std.out("Too low!");
            } else {
                std.out("Congratulations! You guessed correctly.");
                return;
            }
        }
        std.out("Sorry, you've used all your attempts.");
    }
}

with entry {
    game = GuessGame();
    game.play();
}
