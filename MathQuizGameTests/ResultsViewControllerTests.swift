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
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer(), makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configureCorrectAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1",answer: "A1", isCorrect: true)])
        
        let cell = sut.tableView.cell(for: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(isCorrect: false)])

        let cell = sut.tableView.cell(for: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWrongAnswer_configureWrongAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1",answer: "A1", isCorrect: false)])
        
        let cell = sut.tableView.cell(for: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    private func makeDummyAnswer() -> PresentableAnswer {
        return makeAnswer(isCorrect: [false, true].randomElement()!)
    }
    
    private func makeAnswer(question: String = "", answer: String = "", isCorrect: Bool) -> PresentableAnswer {
        return PresentableAnswer(
            question: question,
            answer: answer,
            isCorrect: isCorrect
        )
    }

}
