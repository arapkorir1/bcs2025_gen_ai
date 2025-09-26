import random

class GuessGame:
    def __init__(self):
        self.correct_number = random.randint(1, 10)
        self.attempts = 0

    def play(self):
        while self.attempts < 10:
            guess = input("Guess a number between 1 and 10: ")
            if not guess.isdigit():
                print("That's not a valid number! Try again.")
                continue
            guess = int(guess)
            self.attempts += 1
            if guess > self.correct_number:
                print("Too high!")
            elif guess < self.correct_number:
                print("Too low!")
            else:
                print("Congratulations! You guessed correctly.")
                return
        print("Sorry, you've used all your attempts.")

game = GuessGame()
game.play()
