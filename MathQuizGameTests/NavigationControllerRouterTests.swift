//
//  NavigationControllerRouterTests.swift
//  MathQuizGameTests
//
//  Created by Abdullah Althobetey on 25/10/2020.
//

import XCTest
@testable import MathQuizGame
import GameEngine

class NavigationControllerRouterTests: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    let questionOne = Question(value: "Q1")
    let questionTwo = Question(value: "Q2")
    
    lazy var sut: NavigationControllerRouter = {
        NavigationControllerRouter(navigationController, factory: factory)
    }()
    
    func test_routeToQuestions_presentsTheCorrectQuestionViewControllers() {
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
        factory.stub(question: questionOne, with: UIViewController())
        
        var answerCallbackWasFired = false
        sut.route(to: questionOne, answerCallback: { _ in answerCallbackWasFired = true })
        factory.answerCallbacks[questionOne]!("anything")
        
        XCTAssertTrue(answerCallbackWasFired)
    }
    
    
    // MARK: - Helpers
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [Question<String>: UIViewController]()
        var answerCallbacks = [Question<String>: (String) -> Void]()
        
        func stub(
            question: Question<String>,
            with viewController: UIViewController
        ) {
            stubbedQuestions[question] = viewController
        }
        
        func questionViewController(
            for question: Question<String>,
            answerCallback: @escaping (String) -> Void
        ) -> UIViewController {
            
            answerCallbacks[question] = answerCallback
            return stubbedQuestions[question]!
        }
        
        func gameResultViewController(
            for result: GameResult<Question<String>, String>
        ) -> UIViewController {
            return UIViewController()
        }
    }

}
