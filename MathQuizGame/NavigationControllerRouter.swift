//
//  NavigationControllerRouter.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 25/10/2020.
//

import UIKit
import GameEngine

final class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func route(to question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }
    
    func route(to result: GameResult<String, String>) {
        
    }
}
 
