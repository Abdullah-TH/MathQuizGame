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
        let sut = makeSUT(question: "Q1")
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_createOptionCells() {
        XCTAssertEqual(
            makeSUT(options: []).tableView.numberOfRows(inSection: 0),
            0
        )
        XCTAssertEqual(
            makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0),
            1
        )
        XCTAssertEqual(
            makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0),
            2
        )
    }
    
    func test_viewDidLoad_rendersOptionTexts() {
        let sut = makeSUT(question: "Q1", options: ["A1", "A2", "A3"])
        
        XCTAssertEqual(sut.tableView.title(for: 0), "A1")
        XCTAssertEqual(sut.tableView.title(for: 1), "A2")
        XCTAssertEqual(sut.tableView.title(for: 2), "A3")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(question: String = "", options: [String] = []) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options)
        _ = sut.view // to load the view and trigger viewDidLoad method
        return sut
    }

}

private extension UITableView {
    
    func cell(for row: Int) -> UITableViewCell? {
        self.dataSource?.tableView(
            self,
            cellForRowAt: IndexPath(row: row, section: 0)
        )
    }
    
    func title(for row: Int) -> String? {
        cell(for: row)?.textLabel?.text
    }
}
