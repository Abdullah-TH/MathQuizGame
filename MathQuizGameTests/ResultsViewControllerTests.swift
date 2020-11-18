//
//  ResultsViewControllerTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 19/10/2020.
//

import XCTest
@testable import MathQuizGame

class ResultsViewControllerTests: XCTestCase {

    func test_viewDidLoad_rendersSummary() {
        let sut = makeSUT(summary: "a summary")
        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_createAnswerCells() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(answers: [makeAnswer(), makeAnswer()]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configureCorrectAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1",answer: "A1")])
        
        let cell = sut.tableView.cell(for: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configureWrongAnswerCell() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "A2")
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.tableView.cell(for: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "A2")
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> GameResultsViewController {
        let sut = GameResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeAnswer(
        question: String = "",
        answer: String = "",
        wrongAnswer: String? = nil
    ) -> PresentableAnswer {
        
        return PresentableAnswer(
            question: question,
            answer: answer,
            wrongAnswer: wrongAnswer
        )
    }

}
