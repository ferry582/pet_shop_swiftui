//
//  BreedsScreenUITests.swift
//  Pet ShopUITests
//
//  Created by Ferry Dwianta P on 24/04/24.
//

import XCTest

final class BreedsSuccessUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-breeds-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_list_has_correct_number_of_items_when_screen_loads() {
        let list = app.otherElements["breedsVStack"]
        XCTAssertTrue(list.waitForExistence(timeout: 15), "Breeds LazyVStack should be visible")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let listItems = list.buttons.containing(predicate)
        XCTAssertGreaterThan(listItems.count, 0, "breeds data should exist at initial load")
        
        // test for first item
        XCTAssertTrue(listItems.staticTexts["Affenpinscher"].exists)
        XCTAssertTrue(listItems.staticTexts["Stubborn, Curious, Playful, Adventurous, Active, Fun-loving"].exists)
        XCTAssertTrue(listItems.staticTexts["6 - 13 lbs"].exists)
    }
}
