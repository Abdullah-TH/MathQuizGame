//
//  iOSViewControllerFactory.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 03/11/2020.
//

import UIKit
import MathQuizEngine
import MathQuizPresentation
import MathQuizRouter
import MathQuizUI_iOS

final class iOSViewControllerFactory: ViewControllerFactory {
    
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    private let correctAnswers: [Question<String> : String]
    
    init(
        questions: [Question<String>],
        options: [Question<String>: [String]],
        correctAnswers: [Question<String> : String]
    ) {
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let questionVC = QuestionViewController(
            question: question.value,
            options: options[question] ?? [],
            selection: answerCallback
        )
        questionVC.title = presenter.title
        return questionVC
    }
    
    func gameResultViewController(for result: GameResult<Question<String>, String>) -> UIViewController {
        let presenter = GameResultPresenter(
            questions: questions,
            gameResult: result,
            correctAnswers: correctAnswers)
        
        let gameResultVC = GameResultViewController(
            summary: presenter.summary,
            answers: presenter.presentableAnswers.map {
                Answer(
                    question: $0.question,
                    answer: $0.answer,
                    wrongAnswer: $0.wrongAnswer
                )
            }
        )
        
        return gameResultVC
    }
    
    
}
