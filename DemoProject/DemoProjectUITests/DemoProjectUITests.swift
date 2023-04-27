//
//  DemoProjectUITests.swift
//  DemoProjectUITests
//
//  Created by Bubna K on 27/4/23.
//

import XCTest
@testable import DemoProject

class DemoProjectUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        self.continueAfterFailure = true
        self.app.launchEnvironment = ["ENV": "TEST"]
        self.app.launch()
    }
    
    func testStubResponseTopQuestions() {
        let questionStubMock = QuestionStubTest()
        let e = expectation(description: "Movies list")
        questionStubMock.getTopQuestions { 
            let question = questionStubMock.questionsPresenter.first
            XCTAssertEqual("Captain Marvel", question?.title, "Title is wrong")
            e.fulfill()
           
        }
                
        self.waitForExpectations(timeout: 30.0) { (error: Error?) in
        print("Timeout Error: \(error.debugDescription)")
    }
}
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
