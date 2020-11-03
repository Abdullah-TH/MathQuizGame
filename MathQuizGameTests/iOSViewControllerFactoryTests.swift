//
//  iOSViewControllerFactoryTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 03/11/2020.
//

import XCTest
@testable import MathQuizGame

class iOSViewControllerFactoryTests: XCTestCase {

    func test_questionViewController_createsQuestionViewControllerWithCorrectQuestionAndOptions() {
        let question = Question(value: "Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(questionWithOptions: [question: options])
        
        let questionVC = sut.questionViewController(
            for: question,
            answerCallback: { _ in }
        ) as! QuestionViewController
        
        XCTAssertEqual(questionVC.question, question.value)
        XCTAssertEqual(questionVC.options, options)
    }

}
