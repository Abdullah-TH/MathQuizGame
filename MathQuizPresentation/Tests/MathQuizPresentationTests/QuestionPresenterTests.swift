//
//  QuestionPresenterTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 08/11/2020.
//

import XCTest
import MathQuizPresentation
import MathQuizEngine

class QuestionPresenterTests: XCTestCase {
    
    let questionOne = Question(value: "Q1")
    let questionTwo = Question(value: "Q2")

    func test_title_forFirstQuestion() {
        let sut = QuestionPresenter(questions: [questionOne], question: questionOne)
        XCTAssertEqual(sut.title, "Question 1")
    }
    
    func test_title_forSecondQuestion() {
        let sut = QuestionPresenter(questions: [questionOne, questionTwo], question: questionTwo)
        XCTAssertEqual(sut.title, "Question 2")
    }
    
    func test_title_forUnExistentQuestion() {
        let sut = QuestionPresenter(questions: [], question: questionOne)
        XCTAssertEqual(sut.title, "")
    }

}
