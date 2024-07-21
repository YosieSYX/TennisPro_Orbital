//
//  QuizView.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 19/7/24.
//

import SwiftUI
import FirebaseStorage
var score = 0
var num_questions = 0

struct QuizView: View {
    @Binding var currentShowingView: String
    @State private var questions: [TriviaQuestion] = []
    @State private var currentQuestionIndex = 0
    @State private var showCorrectMessage = false
    @State private var showIncorrectMessage = false

    var buttonColor = LinearGradient(
        colors: [.blue, .green],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundGradient
                VStack {
                    if !questions.isEmpty {
                        Text(questions[currentQuestionIndex].question)
                            .font(.title)
                            .padding()
                        
                        ForEach(questions[currentQuestionIndex].answers, id: \.self) { answer in
                            Button(action: {
                                checkAnswer(answer)
                            }) {
                                Text(answer)
                                    .padding()
                                    .background(buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.bottom, 5)
                            }
                        }
                        if showCorrectMessage {
                            Text("Correct!")
                                .font(.system(size: 20, weight: .light, design: .serif))
                                .foregroundColor(.green)
                                .transition(.opacity)
                        }
                        else if showIncorrectMessage {
                                            Text("Incorrect!")
                                                .font(.system(size: 20, weight: .light, design: .serif))
                                                .foregroundColor(.red)
                                                .transition(.opacity)
                                        }
                        Spacer()
                        Button(action: {
                            currentShowingView="endQuizView"
                        }, label: {
                            Text("Exit Quiz")
                                .font(.system(size: 20))
                        })
                        .frame(width: 200,height: 20)
                        .padding()
                        .background(greener)
                        .cornerRadius(10.0)
                        .foregroundColor(.white)
                        
                        
                        
                    } else {
                        Text("Loading questions...")
                            .onAppear {
                                loadQuestions()
                            }
                    }
                    
                }
            }
        
    }
        .ignoresSafeArea()
}
    func checkAnswer(_ answer: String) {
            if answer == questions[currentQuestionIndex].correctAnswer {
                showCorrectMessage = true
                score += 1
                num_questions += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showCorrectMessage = false
                    loadNextQuestion()
                }
            } else {
                showIncorrectMessage = true
                num_questions += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showIncorrectMessage = false
                    loadNextQuestion()
                }
            }
        }
    
    func loadNextQuestion() {
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
            } else {
                // Show final score or reset the quiz
                // For now, reset the quiz
                currentQuestionIndex = 0
            }
        }
        
        private func loadQuestions() {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let triviaRef = storageRef.child("Trivia/Questions.json")
            
            triviaRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error getting trivia questions: \(error)")
                } else {
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            questions = try decoder.decode([TriviaQuestion].self, from: data)
                        } catch {
                            print("Error decoding trivia questions: \(error)")
                        }
                    }
                }
            }
        }

    }

struct TriviaQuestion: Codable {
    var question: String
    var answers: [String]
    var correctAnswer: String
}
