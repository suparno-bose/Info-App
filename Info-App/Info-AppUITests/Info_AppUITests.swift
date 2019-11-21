//
//  Info_AppUITests.swift
//  Info-AppUITests
//
//  Created by Suparno on 20/11/2019.
//  Copyright © 2019 BT. All rights reserved.
//

import XCTest

class Info_AppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    /// Test case to check if number of cells in tableview is as expected.
    func testNumberOfItems() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let navigationTitleText = XCUIApplication().staticTexts.matching(identifier: AccessibilityIdentifiers.NavigationTitle.rawValue).element
        let existsPredicate = NSPredicate(format: "label != \"\"")
        expectation(for: existsPredicate, evaluatedWith: navigationTitleText, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        let tableView = XCUIApplication().tables[AccessibilityIdentifiers.FactTableView.rawValue]
        XCTAssertTrue(tableView.cells.count == 14)
    }
    
    /// Test case to check if title label of 2nd tableView cell is as expected.
    func test2ndTableCellTitle() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let navigationTitleText = XCUIApplication().staticTexts.matching(identifier: AccessibilityIdentifiers.NavigationTitle.rawValue).element
        let existsPredicate = NSPredicate(format: "label != \"\"")
        expectation(for: existsPredicate, evaluatedWith: navigationTitleText, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        let tableView = XCUIApplication().tables[AccessibilityIdentifiers.FactTableView.rawValue]
        let secondCell = tableView.cells[AccessibilityIdentifiers.FactCellTableViewCell.rawValue + String(1)]
        let titleLabel = secondCell.staticTexts.matching(identifier: AccessibilityIdentifiers.FactTitleLabel.rawValue).element
                
        XCTAssertTrue(titleLabel.label == "Flag")
    }
    
    /// Test case to check if title of navigation bar title is as expected.
    func testTitleName() {
        // UI tests must launch the application that they test.rb
        let app = XCUIApplication()
        app.launch()
        
        let navigationTitleText = XCUIApplication().staticTexts.matching(identifier: AccessibilityIdentifiers.NavigationTitle.rawValue).element
        let existsPredicate = NSPredicate(format: "label != \"\"")
        expectation(for: existsPredicate, evaluatedWith: navigationTitleText, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(navigationTitleText.exists)
        XCTAssertTrue(navigationTitleText.title == "About Canada")
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
