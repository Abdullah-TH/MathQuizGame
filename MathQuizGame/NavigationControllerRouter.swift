//
//  NavigationControllerRouter.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 25/10/2020.
//

import UIKit
import GameEngine

protocol ViewControllerFactory {
    
    func questionViewController(
        for question: String,
        answerCallback: @escaping (String) -> Void
    ) -> UIViewController?
}

final class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func route(to question: String, answerCallback: @escaping (String) -> Void) {
        if let viewController = factory.questionViewController(for: question, answerCallback: answerCallback) {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func route(to result: GameResult<String, String>) {
        
    }
}
 
