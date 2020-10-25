//
//  NavigationControllerRouterTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 25/10/2020.
//

import XCTest
@testable import MathQuizGame

class NavigationControllerRouterTests: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        NavigationControllerRouter(navigationController, factory: factory)
    }()
    
    func test_routeToQuestions_presentsTheCorrectQuestionViewControllers() {
        let questionOne = "Q1"
        let questionTwo = "Q2"
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: questionOne, with: viewController)
        factory.stub(question: questionTwo, with: secondViewController)
        
        sut.route(to: questionOne, answerCallback: { _ in })
        sut.route(to: questionTwo, answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_presentsQuestionViewControllerWithAnswerCallback() {
        let question = "Q1"
        factory.stub(question: question, with: UIViewController())
        
        var answerCallbackWasFired = false
        sut.route(to: question, answerCallback: { _ in answerCallbackWasFired = true })
        factory.answerCallbacks[question]!("anything")
        
        XCTAssertTrue(answerCallbackWasFired)
    }
    
    
    // MARK: - Helpers
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [String: UIViewController]()
        var answerCallbacks = [String: (String) -> Void]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func questionViewController(
            for question: String,
            answerCallback: @escaping (String) -> Void
        ) -> UIViewController? {
            
            answerCallbacks[question] = answerCallback
            return stubbedQuestions[question]
        }
    }

}
