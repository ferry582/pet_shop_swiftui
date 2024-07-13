//
//  PetListViewModelSuccessTests.swift
//  Pet ShopTests
//
//  Created by Ferry Dwianta P on 28/04/24.
//

import XCTest
@testable import Pet_Shop

final class PetListViewModelSuccessTests: XCTestCase {

    private var serviceMock: APIService!
    private var viewModel: PetListViewModel!
    
    override func setUp() {
        serviceMock = APIServicePetsResponseSuccessMock()
        viewModel = PetListViewModel(apiService: serviceMock)
    }
    
    override func tearDown() {
        serviceMock = nil
        viewModel = nil
    }
    
    func test_with_successful_response_pets_array_is_set() async throws {
        XCTAssertFalse(viewModel.isLoading, "View Model shouldn't load any data yet")
        defer {
            XCTAssertFalse(viewModel.isLoading, "View Model shouldn't be loading any data")
        }
        await viewModel.getPetsData(breedId: 2)
        XCTAssertEqual(viewModel.pets.count, 5, "There should be 5 pets data within pets array")
        XCTAssertGreaterThan(viewModel.totalData, 0, "There should be more than zero of total data")
    }

    func test_with_successful_paginated_response_pets_array_is_set() async throws {
        XCTAssertFalse(viewModel.isLoading, "View Model shouldn't load any data yet")
        defer {
            XCTAssertFalse(viewModel.isLoading, "View Model shouldn't be loading any data")
        }
        
        await viewModel.getPetsData(breedId: 2)
        XCTAssertEqual(viewModel.pets.count, 5, "There should be 5 pets data within pets array")
        XCTAssertGreaterThan(viewModel.totalData, 0, "There should be more than zero of total data")
        
        await viewModel.getNextPetsData(breedId: 2)
        XCTAssertEqual(viewModel.pets.count, 10, "There should be 10 pets data within pets array")
        XCTAssertEqual(viewModel.page, 1, "Page should be equal to 1")
    }
    
    func test_with_refresh_called_values_is_reset() async throws {
        XCTAssertFalse(viewModel.isLoading, "View Model shouldn't load any data yet")
        defer {
            XCTAssertFalse(viewModel.isLoading, "View Model shouldn't be loading any data")
        }
        
        await viewModel.getPetsData(breedId: 2)
        XCTAssertEqual(viewModel.pets.count, 5, "There should be 5 pets data within pets array")
        XCTAssertGreaterThan(viewModel.totalData, 0, "There should be more than zero of total data")
        
        await viewModel.getNextPetsData(breedId: 2)
        XCTAssertEqual(viewModel.pets.count, 10, "There should be 10 pets data within pets array")
        XCTAssertEqual(viewModel.page, 1, "Page should be equal to 1")
        
        viewModel.refreshedTriggered()
        XCTAssertEqual(viewModel.pets.count, 0, "There should be 0 pets data within breeds array")
        XCTAssertEqual(viewModel.page, 0, "Page should be equal to 0")
        XCTAssertEqual(viewModel.totalData, 0, "There should be more than zero of total pagination data")
    }
    
    func test_with_last_pet_func_return_true() async {
        await viewModel.getPetsData(breedId: 2)
        
        let pets = try! StaticJSONMapper.decode(file: "PetsDataPageOne", type: [Pet].self)
        
        let hasReachedEnd = viewModel.hasReachedEnd(of: pets.last!)
        
        XCTAssertTrue(hasReachedEnd, "Last pet data should match")
    }
}
