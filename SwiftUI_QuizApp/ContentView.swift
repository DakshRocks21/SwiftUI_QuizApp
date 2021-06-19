//
//  ContentView.swift
//  SwiftUI_QuizApp
//
//  Created by Daksh Thapar on 14/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAlertPresented = false
    @State private var isCorrect = false
    @State private var isSheetPresented = false
    @State private var currentQuestion = 0
    @State private var correctAnswers = 0
    
    var questions = [Question(title: "What day is it?",
                                  option1: "Monday",
                                  option2: "Friday",
                                  option3: "Wednesday",
                                  option4: "Saturday",
                                  correctOption: 4),
                         Question(title: "What framework are we using?",
                                  option1: "UIKit",
                                  option2: "SwiftUI",
                                  option3: "React Native",
                                  option4: "Flutter",
                                  correctOption: 2),
                         Question(title: "Which company created Swift?",
                                  option1: "Apple",
                                  option2: "Orange",
                                  option3: "Google",
                                  option4: "Tinkercademy",
                                  correctOption: 1)]
    
    var body: some View {
        VStack{
            
            Text(questions[currentQuestion].title)
                .padding()
            
            HStack {
                VStack{
                    Button(questions[currentQuestion].option1) { didTapOption(1) }
                    Button(questions[currentQuestion].option2) { didTapOption(2) }
                }
                VStack {
                    Button(questions[currentQuestion].option3) { didTapOption(3) }
                    Button(questions[currentQuestion].option4) { didTapOption(4) }
                }
            }
        }
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text(isCorrect ? "Well done!" : "Boooo wrong"),
                  message: Text(isCorrect ? "Congratulations 🎉" : "Try harder please 😔"),
                  dismissButton: .default(Text("OK")){
                    currentQuestion += 1
                    if currentQuestion == questions.count {
                        // We finished! Show the score sheet
                        currentQuestion = 0
                        isSheetPresented = true
                    }
            })
        }
        .sheet(isPresented: $isSheetPresented) {
            ScoreView(score: correctAnswers, totalScore: questions.count)
        }
    }
    
    func didTapOption(_ optionNumber: Int) {
        if optionNumber == questions[currentQuestion].correctOption {
            print("Correct!")
            isCorrect = true
            correctAnswers += 1
        } else {
            print("Wrong!")
            isCorrect = false
        }
        isAlertPresented = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
