//
//  Flow.swift
//  GameEngine
//
//  Created by Abdullah Althobetey on 17/10/2020.
//

import Foundation

protocol Router {
    func route(to question: String)
}

final class Flow {
    
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if !questions.isEmpty {
            router.route(to: questions.first!)
        }
    }
}
