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
        let sut = ResultsViewController(summary: "a summary", answers: [])
        _ = sut.view 
        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_withNoAnswers_doesNotCreateAnswerCells() {
        let sut = ResultsViewController(summary: "", answers: [])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneAnswers_createOneAnswerCell() {
        let sut = ResultsViewController(summary: "", answers: ["A1"])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

}
