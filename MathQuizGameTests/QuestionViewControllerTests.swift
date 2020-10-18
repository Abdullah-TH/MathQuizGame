//
//  QuestionViewControllerTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 18/10/2020.
//

import XCTest
@testable import MathQuizGame

class QuestionViewControllerTests: XCTestCase {

    func test_viewDidLoad_renderQuestionHeaderText() {
        let sut = QuestionViewController(question: "Q1")
        
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }

}
