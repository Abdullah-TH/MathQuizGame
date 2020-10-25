//
//  NavigationControllerRouterTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 25/10/2020.
//

import XCTest
@testable import MathQuizGame

class NavigationControllerRouterTests: XCTestCase {

    func test_routeToQuestion_presentsQuestionViewController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.route(to: "Q1", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func test_routeToTwoQuestions_presentsTwoQuestionViewControllers() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.route(to: "Q1", answerCallback: { _ in })
        sut.route(to: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }

}
