//
//  QuestionPresenter.swift
//  MathQuizGame
//
//  Created by Abdullah Althobetey on 08/11/2020.
//

import Foundation
import GameEngine

struct QuestionPresenter {
    
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }
        return "Question \(index + 1)"
    }
}
