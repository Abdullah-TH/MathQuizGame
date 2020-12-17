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
        guard !answers.isEmpty else { return 0 }
        return answers == correctAnswers ? 1 : 0
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
}
