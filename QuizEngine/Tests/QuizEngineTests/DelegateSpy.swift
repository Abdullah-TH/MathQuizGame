//
//  DelegateSpy.swift
//  GameEngineTests
//
//  Created by Abdullah Althobetey on 21/10/2020.
//

import Foundation
import QuizEngine

class DelegateSpy: Router, QuizDelegate {
    
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
    
    func route(to question: String, answerCallback: @escaping (String) -> Void) {
        handle(question: question, answerCallback: answerCallback)
    }
    
    func route(to result: GameResult<String, String>) {
        handle(result: result)
    }
}
