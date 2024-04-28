//
//  ListPetsUITests.swift
//  Pet ShopUITests
//
//  Created by Ferry Dwianta P on 24/04/24.
//

import XCTest

final class ListPetSuccessUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-breeds-networking-success":"1",
            "-pets-networking-success":"1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_list_has_correct_number_of_pet_items_when_screen_loads() {
        let logInButton = app.buttons["logInButton"]
        XCTAssertTrue(logInButton.waitForExistence(timeout: 5))
        logInButton.tap()
        
        let breedsList = app.otherElements["breedsVStack"]
        XCTAssertTrue(breedsList.waitForExistence(timeout: 5), "Breeds LazyVStack should be visible")
        
        let breedPredicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let listItems = breedsList.buttons.containing(breedPredicate)
        
        listItems.firstMatch.tap()
        
        let petsGrid = app.otherElements["petsGrid"]
        XCTAssertTrue(petsGrid.waitForExistence(timeout: 5), "Pets LazyVGrid should be visible")
        
        let petsPredicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let petGridItems = petsGrid.buttons.containing(petsPredicate)
        XCTAssertGreaterThan(petGridItems.count, 0, "pets data should exist at initial load")
    }
}
