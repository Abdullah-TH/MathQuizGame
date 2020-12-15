//
//  DelegateSpy.swift
//  QuizEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation
import QuizEngine

class DelegateSpy: QuizDelegate {
    
    var handledQuestions: [String] = []
    var handledResult: GameResult<String, String>? = nil
    var answerCallback: (String) -> Void = { _ in }
    
    func handle(question: String, answerCallback: @escaping (String) -> Void) {
        handledQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func handle(result: GameResult<String, String>) {
        handledResult = result
    }
}
