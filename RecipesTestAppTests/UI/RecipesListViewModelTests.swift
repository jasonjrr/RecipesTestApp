//
//  RecipesListViewModelTests.swift
//  RecipesTestAppTests
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import XCTest
@testable import RecipesTestApp

fileprivate class TestRecipesListViewModelDelegate: RecipesListViewModel.Delegate {}

class RecipesListViewModelTest: XCTestCase {
    var recipesService: MockRecipesService!
    var target: RecipesListViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        self.recipesService = MockRecipesService()
        
        configureMocks()
        
        self.target = RecipesListViewModel(recipesService: self.recipesService)
    }
    
    func configureMocks() {}
}

class RecipesListViewModel_when_initialized: RecipesListViewModelTest {
    override func configureMocks() {
        super.configureMocks()
    }
    
    func test_then_delegate_is_nil() {
        XCTAssertNil(self.target.delegate)
    }
    
    func test_then_recipes_success_and_is_empty() {
        switch self.target.recipes {
        case .success(let recipes):
            XCTAssertTrue(recipes.isEmpty)
        case .failure(_):
            XCTFail()
        }
    }
}

class RecipesListViewModel_when_setup_is_called: RecipesListViewModelTest {
    fileprivate let delegate: TestRecipesListViewModelDelegate = TestRecipesListViewModelDelegate()
    
    override func setUp() async throws {
        try await super.setUp()
        self.target.setup(delegate: self.delegate)
    }
    
    func test_then_delegate_is_not_nil() {
        XCTAssertNotNil(self.target.delegate)
    }
    
    func test_then_recipes_success_and_is_empty() {
        switch self.target.recipes {
        case .success(let recipes):
            XCTAssertTrue(recipes.isEmpty)
        case .failure(_):
            XCTFail()
        }
    }
}

class RecipesListViewModel_when_refresh_is_successful: RecipesListViewModelTest {
    fileprivate let delegate: TestRecipesListViewModelDelegate = TestRecipesListViewModelDelegate()
    let expectedRecipes = Recipe.mockData
    
    override func configureMocks() {
        super.configureMocks()
        self.recipesService.mockGetRecipesTestClosure = {
            return self.expectedRecipes
        }
    }
    
    override func setUp() async throws {
        try await super.setUp()
        self.target.setup(delegate: self.delegate)
        self.target.refresh()
    }
    
    func test_then_recipes_is_success_but_not_empty() {
        switch self.target.recipes {
        case .success(let recipes):
            XCTAssertFalse(recipes.isEmpty)
        case .failure(_):
            XCTFail()
        }
    }
    
    func test_then_recipes_is_expected() {
        switch self.target.recipes {
        case .success(let recipes):
            let actualRecipes = recipes.map { $0.recipe }
            XCTAssertEqual(actualRecipes, self.expectedRecipes)
        case .failure(_):
            XCTFail()
        }
    }
}

class RecipesListViewModel_when_refresh_throws_error: RecipesListViewModelTest {
    fileprivate let delegate: TestRecipesListViewModelDelegate = TestRecipesListViewModelDelegate()
    let expectedError = URLError(.unknown)
    
    override func configureMocks() {
        super.configureMocks()
        self.recipesService.mockGetRecipesTestClosure = {
            throw self.expectedError
        }
    }
    
    override func setUp() async throws {
        try await super.setUp()
        self.target.setup(delegate: self.delegate)
        self.target.refresh()
    }
    
    func test_then_recipes_error_is_failure() {
        switch self.target.recipes {
        case .success(_):
            XCTFail()
        case .failure(_):
            XCTAssertTrue(true)
        }
    }
}
