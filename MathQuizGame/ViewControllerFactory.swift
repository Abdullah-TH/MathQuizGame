//
//  ViewControllerFactory.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 03/11/2020.
//

import UIKit
import GameEngine

protocol ViewControllerFactory {
    
    func questionViewController(
        for question: Question<String>,
        answerCallback: @escaping (String) -> Void
    ) -> UIViewController?
    
    func gameResultViewController(
        for result: GameResult<Question<String>, String>
    ) -> UIViewController?
}
