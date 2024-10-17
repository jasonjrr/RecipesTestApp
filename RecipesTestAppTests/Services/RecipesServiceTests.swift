//
//  RecipesServiceTests.swift
//  RecipesTestAppTests
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import XCTest
@testable import RecipesTestApp
import SUIFNetworking
import Combine

class RecipesServiceTest: XCTestCase {
    var imageCache: MockImageCache!
    var networkingService: MockNetworkingService<RecipeResponse>!
    var recipesService: RecipesService!
    
    override func setUp() async throws {
        try await super.setUp()
        self.imageCache = MockImageCache()
        self.networkingService = MockNetworkingService()
        
        configureMocks()
        
        self.recipesService = RecipesService(
            imageCache: self.imageCache,
            networkingService: self.networkingService)
    }
    
    func configureMocks() {}
}

class RecipesService_when_getRecipes_returns_results: RecipesServiceTest {
    let mockRecipes: [Recipe] = Recipe.mockData
    
    override func configureMocks() {
        self.networkingService.fetchFromURLOutputResult = .success(RecipeResponse(recipes: self.mockRecipes))
    }
    
    func test_then_expected_results_are_returned() async throws {
        let recipes = try await self.recipesService.getRecipes()
        XCTAssertEqual(recipes, self.mockRecipes)
    }
}

class RecipesService_when_getRecipes_throws_error: RecipesServiceTest {
    override func configureMocks() {
        self.networkingService.fetchFromURLOutputResult = .failure(URLError(.unknown))
    }
    
    func test_then_expected_results_are_returned() async {
        do {
            let _ = try await self.recipesService.getRecipes()
            XCTFail()
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.unknown))
        }
    }
}

class RecipesService_when_image_cannot_be_fetched: RecipesServiceTest {
    override func configureMocks() {
        self.networkingService.mock_fetchImageFromURL = { (_) -> AnyPublisher<NetworkingServiceImageResponse, any Error> in
            return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
        }
    }
    
    func test_then_getImage_throws_an_error() async {
        do {
            let _ = try await self.recipesService.getImage(for: URL(string: "https://example.com/image.png")!)
            XCTFail()
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.unknown))
        }
    }
}

class RecipesService_when_image_does_no_exist_in_cache: RecipesServiceTest {
    var imageCacheImageCallCount: Int = 0
    var imageCacheCacheCallCount: Int = 0
    var networkingServiceFetchImageFromURLCallCount: Int = 0
    
    var actual: UIImage?
    
    override func configureMocks() {
        self.networkingService.mock_fetchImageFromURL = { (url) -> AnyPublisher<NetworkingServiceImageResponse, any Error> in
            self.networkingServiceFetchImageFromURLCallCount += 1
            let image = UIImage(named: "testImage")!
            return Just(NetworkingServiceImageResponse(
                image: image,
                data: image.jpegData(compressionQuality: 1)!,
                response: URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        self.imageCache.mock_imageTestClosure = { (_) -> UIImage? in
            self.imageCacheImageCallCount += 1
            return nil
        }
        
        self.imageCache.mock_cacheTestClosure = { _, _, _ in
            self.imageCacheCacheCallCount += 1
        }
    }
    
    override func setUp() async throws {
        try await super.setUp()
        self.actual = try await self.recipesService.getImage(for: URL(string: "https://example.com/image.png")!)
    }
    
    func test_then_getImage_fetched_image_not_nil() async throws {
        XCTAssertNotNil(self.actual)
    }
    
    func test_networkingService_fetchImageFromURL_called_once() {
        XCTAssertEqual(self.networkingServiceFetchImageFromURLCallCount, 1)
    }
    
    func test_imageCache_image_is_called_once() {
        XCTAssertEqual(self.imageCacheImageCallCount, 1)
    }
    
    func test_imageCache_cache_is_called_once() {
        XCTAssertEqual(self.imageCacheCacheCallCount, 1)
    }
}
