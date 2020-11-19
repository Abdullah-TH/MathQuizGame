//
//  GameResultPresenter.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 04/11/2020.
//

import Foundation
import MathQuizEngine

public struct GameResultPresenter {
    
    private let questions: [Question<String>]
    private let gameResult: GameResult<Question<String>, String>
    private let correctAnswers: [Question<String>: String]
    
    public init(
        questions: [Question<String>],
        gameResult: GameResult<Question<String>, String>,
        correctAnswers: [Question<String>: String]
    ) {
        self.questions = questions
        self.gameResult = gameResult
        self.correctAnswers = correctAnswers
    }
    
    public var summary: String {
        "You got \(gameResult.score) of \(gameResult.answers.count) correct answers"
    }
    
    public var presentableAnswers: [PresentableAnswer] {
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
