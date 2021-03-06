//
//  NavigationControllerRouter.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 25/10/2020.
//

import UIKit
import QuizEngine

public final class NavigationControllerRouter: QuizDelegate {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    public init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    public func handle(question: Question<String>, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    public func handle(result: GameResult<Question<String>, String>) {
        let viewController = factory.gameResultViewController(for: result)
        navigationController.pushViewController(viewController, animated: true)
    }
}
 
