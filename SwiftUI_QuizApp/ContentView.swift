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
            ProgressView(value: Double(currentQuestion),
                                 total: Double(questions.count))
                        .padding()
            
            Text(questions[currentQuestion].title)
                .padding()
            
            HStack {
                VStack {
                    Button {
                        didTapOption(1)
                    } label: {
                        Image(systemName: "triangle.fill")
                        Text(questions[currentQuestion].option1)
                    }.padding()
                    .background(Color.blue.opacity(0.5))
                    Button {
                        didTapOption(2)
                    } label: {
                        Image(systemName: "circle.fill")
                        Text(questions[currentQuestion].option2)
                    }.padding()
                    .background(Color.red.opacity(0.5))
                }
                .padding()
                VStack {
                    Button {
                        didTapOption(3)
                    } label: {
                        Image(systemName: "diamond.fill")
                        Text(questions[currentQuestion].option3)
                    }.padding()
                    .background(Color.yellow.opacity(0.5))
                    Button {
                        didTapOption(4)
                    } label: {
                        Image(systemName: "square.fill")
                        Text(questions[currentQuestion].option4)
                    }.padding()
                    .background(Color.green.opacity(0.5))
                }
                .padding()
            }
            .padding()
        }
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text(isCorrect ? "Well done!" : "Boooo wrong"),
                  message: Text(isCorrect ? "Congratulations 🎉" : "Try harder please 😔"),
                  dismissButton: .default(Text("OK")){
                    currentQuestion += 1
                    if currentQuestion == questions.count {
                        
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
