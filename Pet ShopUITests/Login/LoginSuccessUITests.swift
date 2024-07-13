//
//  LoginSuccessUITests.swift
//  Pet ShopUITests
//
//  Created by Ferry Dwianta P on 25/04/24.
//

import XCTest

final class LoginSuccessUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-breeds-networking-success":"1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_when_form_login_view_is_presented() {
        XCTAssertTrue(app.buttons["logInButton"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["haveAccountButton"].exists)
        XCTAssertTrue(app.textFields["emailTextField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordTextField"].exists)
    }
    
    func test_when_form_login_view_show_sign_up_is_presented() {
        let haveAccountButton = app.buttons["haveAccountButton"]
        XCTAssertTrue(haveAccountButton.waitForExistence(timeout: 5))
        
        haveAccountButton.tap()
        
        XCTAssertTrue(app.buttons["logInButton"].exists)
        XCTAssertTrue(app.textFields["emailTextField"].exists)
        XCTAssertTrue(app.secureTextFields["passwordTextField"].exists)
        XCTAssertTrue(app.secureTextFields["confirmPasswordTextField"].exists)
    }
}
