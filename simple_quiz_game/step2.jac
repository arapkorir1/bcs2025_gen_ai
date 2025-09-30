import random;

obj Quizgame{
    has questions: str;
    has score: int=0;

    def init(){
        self.questions=[{"q":"What is ML", "a":"A", "options": "A : Machine Learning , B : Machine Language"},{"q":"What is AI?", "a":"B", "options": "A : Automated Input , B : Artificial Intelligence "}];
        random.shuffle(self.questions);
        self.score;
    }

    def play(){
        for i in self.questions{
            print(i["q"]);
            print(i["options"]);
            answer=input('Give the full meaning choice:').upper();

            if answer==i['a']{
                self.score += 1;
                print('Correct!');
            } else{
                print('Oops! You got it wrong this time. Hint: Think of automation.');
            }
        }
        print('TOTAL SCORE:' + str(self.score) + '/' + str(len(self.questions)));
    }
}
with entry{
    game=Quizgame();
    game.play();
}