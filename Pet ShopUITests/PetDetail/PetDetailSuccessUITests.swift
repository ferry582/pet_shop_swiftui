//
//  PetDetailSuccessUITests.swift
//  Pet ShopUITests
//
//  Created by Ferry Dwianta P on 29/04/24.
//

import XCTest

final class PetDetailSuccessUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-breeds-networking-success":"1",
            "-pets-networking-success":"1",
            "-add-favorite-networking-success":"1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_pet_detail_info_is_correct_when_item_is_tapped_screen_loads() {
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
        petGridItems.firstMatch.tap()
        
        XCTAssertTrue(app.buttons["addFavoriteButton"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Afghan Hound"].exists)
        XCTAssertTrue(app.staticTexts["Afghanistan, Iran, Pakistan"].exists)
        XCTAssertTrue(app.staticTexts["Details"].exists)
        XCTAssertTrue(app.staticTexts["Age"].exists)
        XCTAssertTrue(app.staticTexts["Width"].exists)
        XCTAssertTrue(app.staticTexts["Height"].exists)
        XCTAssertTrue(app.staticTexts["Temprament"].exists)
        XCTAssertTrue(app.staticTexts["Aloof, Clownish, Dignified, Independent, Happy"].exists)
        XCTAssertTrue(app.staticTexts["Breed For"].exists)
        XCTAssertTrue(app.staticTexts["Coursing and hunting"].exists)
    }
    
    func test_pet_detail_alert_is_shown_when_add_pet_to_favorite_is_successful() {
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
        petGridItems.firstMatch.tap()
        
        let addFavoriteButton = app.buttons["addFavoriteButton"]
        XCTAssertTrue(addFavoriteButton.waitForExistence(timeout: 5))
        addFavoriteButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3))
        XCTAssertTrue(alert.staticTexts["Added to your favorite"].exists)
        XCTAssertTrue(alert.buttons["OK"].exists)
    }
}
