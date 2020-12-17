//
//  ScoreTests.swift
//  
//
//  Created by Abdullah Althobetey on 17/12/2020.
//

import Foundation
import XCTest

class BasicScore {
    
    static func score(
        for answers: [String],
        comparingTo correctAnswers: [String]
    ) -> Int {
        var score = 0
        for (index, answer) in answers.enumerated() {
            let isCorrect = answer == correctAnswers[index]
            score += isCorrect ? 1 : 0
        }
        return score
    }
}

class ScoreTests: XCTestCase {
    
    func test_noAnswers_scoresZero() {
        let score = BasicScore.score(for: [], comparingTo: [])
        XCTAssertEqual(score, 0)
    }
    
    func test_oneWrongAnswer_scoresZero() {
        let score = BasicScore.score(for: ["wrong"], comparingTo: ["correct"])
        XCTAssertEqual(score, 0)
    }
    
    func test_oneCorrectAnswer_scoresOne() {
        let score = BasicScore.score(for: ["correct"], comparingTo: ["correct"])
        XCTAssertEqual(score, 1)
    }
    
    func test_oneCorrectOneWrongAnswers_scoresOne() {
        let score = BasicScore.score(for: ["correct 1", "wrong"], comparingTo: ["correct 1", "correct 2"])
        XCTAssertEqual(score, 1)
    }
}
