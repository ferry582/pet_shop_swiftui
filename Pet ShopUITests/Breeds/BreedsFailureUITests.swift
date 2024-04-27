//
//  BreedsFailureUITests.swift
//  Pet ShopUITests
//
//  Created by Ferry Dwianta P on 24/04/24.
//

import XCTest

final class BreedsFailureUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-breeds-networking-success":"0"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_alert_is_shown_when_screen_fails_to_loads() {
        let logInButton = app.buttons["logInButton"]
        XCTAssertTrue(logInButton.waitForExistence(timeout: 5))
        logInButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 15), "There should be an alert on the screen")
        XCTAssertTrue(alert.staticTexts["Network Error! Error Occured with status code 404"].exists)
        XCTAssertTrue(alert.buttons["OK"].exists)
        
        alert.buttons.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["No Data! \nRefresh by pulling down"].exists)
    }
}