//
//  GameResultPresenter.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 04/11/2020.
//

import Foundation
import GameEngine

struct GameResultPresenter {
    
    let questions: [Question<String>]
    let gameResult: GameResult<Question<String>, String>
    let correctAnswers: [Question<String>: String]
    
    var summary: String {
        "You got \(gameResult.score) of \(gameResult.answers.count) correct answers"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        questions.map { question in
            
            guard let userAnswer = gameResult.answers[question],
                  let correctAnswer = correctAnswers[question]
            else {
                fatalError("Couldn't find correct answer for: \(question)")
            }
            
            return PresentableAnswer(
                question: question.value,
                answer: correctAnswer,
                wrongAnswer: userAnswer == correctAnswer ? nil : userAnswer
            )
        }
    }
    
}
