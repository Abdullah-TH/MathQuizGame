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
        for answers: [Any],
        comparingTo correctAnswers: [String]
    ) -> Int {
        return 0
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
}
