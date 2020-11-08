//
//  iOSViewControllerFactoryTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 03/11/2020.
//

import XCTest
@testable import MathQuizGame

class iOSViewControllerFactoryTests: XCTestCase {
    
    let questionOne = Question(value: "Q1")
    let answerOne = "A1"
    let answerTwo = "A2"
    
    func test_questionViewController_createsQuestionViewControllerWithTitle() {
        let questionPresenter = QuestionPresenter(
            questions: [questionOne],
            question: questionOne
        )
        let (_, questionVC) = makeSUT(
            questions: [questionOne],
            question: questionOne,
            options: [answerOne, answerTwo]
        )
        
        XCTAssertEqual(questionVC.title, questionPresenter.title)
    }

    func test_questionViewController_createsQuestionViewControllerWithCorrectQuestionAndOptions() {
        let (_, questionVC) = makeSUT(
            questions: [questionOne],
            question: questionOne,
            options: [answerOne, answerTwo]
        )
        
        XCTAssertEqual(questionVC.question, questionOne.value)
        XCTAssertEqual(questionVC.options, [answerOne, answerTwo])
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(
        questions: [Question<String>],
        question: Question<String>,
        options: [String]
    ) -> (iOSViewControllerFactory, QuestionViewController) {
        
        let sut = iOSViewControllerFactory(questions: questions, options: [questionOne: options])
        let questionVC = sut.questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
        return (sut, questionVC)
    }
    
}
