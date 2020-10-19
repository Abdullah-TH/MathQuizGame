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
        let sut = ResultsViewController(summary: "a summary")
        _ = sut.view 
        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }

}
