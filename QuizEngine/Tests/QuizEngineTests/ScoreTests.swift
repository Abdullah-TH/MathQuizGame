//
//  ScoreTests.swift
//  
//
//  Created by Abdullah Althobetey on 17/12/2020.
//

import Foundation
import XCTest

class BasicScore {
    
    static func score(for answers: [Any]) -> Int {
        return 0
    }
}

class ScoreTests: XCTestCase {
    
    func test_noAnswers_scoresZero() {
        let score = BasicScore.score(for: [])
        XCTAssertEqual(score, 0)
    }
}
