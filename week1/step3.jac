import random;

obj GuessGame {
    has correct_number: int;
    has attempts: int = 0;
}

with entry {
    game = GuessGame();
    game.init();
    game.play();
}

impl GuessGame.init {
    self.correct_number = random.randint(1, 10);
}

impl GuessGame.play {
    while self.attempts < 10 {
        guess = input("Guess a number between 1 and 10: ");
        if not guess.isdigit() {
            print("That's not a valid number! Try again.");
            continue;
        }
        guess = int(guess);
        self.attempts += 1;
        if guess > self.correct_number {
            print("Too high!");
        }
        else if guess < self.correct_number {
            print("Too low!");
        }
        else {
            print("Congratulations! You guessed correctly.");
            return;
        }
    }
    print("Sorry, you've used all your attempts.");
}
