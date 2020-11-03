//
//  iOSViewControllerFactory.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 03/11/2020.
//

import UIKit
import GameEngine

final class iOSViewControllerFactory: ViewControllerFactory {
    
    private let questionWithOptions: [Question<String>: [String]]
    
    init(questionWithOptions: [Question<String>: [String]]) {
        self.questionWithOptions = questionWithOptions
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController? {
        return QuestionViewController(
            question: question.value,
            options: questionWithOptions[question] ?? [],
            selection: answerCallback
        )
    }
    
    func gameResultViewController(for result: GameResult<Question<String>, String>) -> UIViewController? {
        return UIViewController()
    }
    
    
}
