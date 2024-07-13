//
//  PetListViewModelFailureTests.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 28/04/24.
//

import XCTest
@testable import Pet_Shop

final class PetListViewModelFailureTests: XCTestCase {
    
    private var serviceMock: APIService!
    private var viewModel: PetListViewModel!
    
    override func setUp() {
        serviceMock = APIServicePetsResponseFailureMock()
        viewModel = PetListViewModel(apiService: serviceMock)
    }
    
    override func tearDown() {
        serviceMock = nil
        viewModel = nil
    }
    
    func test_with_unsuccessful_response_error_is_handled() async {
        XCTAssertFalse(viewModel.isLoading, "View Model shouldn't load any data yet")
        defer {
            XCTAssertFalse(viewModel.isLoading, "View Model shouldn't be loading any data")
        }
        
        await viewModel.getPetsData(breedId: 2)
        
        XCTAssertTrue(viewModel.isAlertActive, "View Model should have an error")
        XCTAssertNotEqual(viewModel.alertMessage, "", "View Model should have an error message")
    }
}
