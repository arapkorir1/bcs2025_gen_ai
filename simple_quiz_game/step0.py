import random

class QuizGame:
    def __init__(self):
        self.questions = [
            {"q": "What does AI stand for?", "a": "A", "options": "A: Artificial Intelligence, B: Automated Input"},
            {"q": "What is ML?", "a": "B", "options": "A: Machine Language, B: Machine Learning"}
        ]  # Add more up to 5
        random.shuffle(self.questions)
        self.score = 0

    def play(self):
        for q in self.questions:
            print(q["q"])
            print(q["options"])
            answer = input("Your answer (A/B): ").upper()
            if answer == q["a"]:
                print("Correct!")
                self.score += 1
            else:
                print("Wrong! Hint: Think about automation.")
        print(f"Score: {self.score}/{len(self.questions)}")

game = QuizGame()
game.play()
