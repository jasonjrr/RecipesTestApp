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
    let mockRecipes: [Recipe] = [
        Recipe(
            id: "1",
            name: "Spaghetti Carbonara",
            cuisine: "Italian",
            photoURLLarge: "https://example.com/spaghetti_carbonara_large.jpg",
            photoURLSmall: "https://example.com/spaghetti_carbonara_small.jpg",
            sourceURL: "https://example.com/spaghetti_carbonara_recipe",
            youtubeURL: "https://www.youtube.com/watch?v=spaghetti_carbonara_video"),
        
        Recipe(
            id: "2",
            name: "Chicken Tikka Masala",
            cuisine: "Indian",
            photoURLLarge: "https://example.com/chicken_tikka_masala_large.jpg",
            photoURLSmall: "https://example.com/chicken_tikka_masala_small.jpg",
            sourceURL: "https://example.com/chicken_tikka_masala_recipe",
            youtubeURL: "https://www.youtube.com/watch?v=chicken_tikka_masala_video"),
        
        Recipe(
            id: "3",
            name: "Sushi Rolls",
            cuisine: "Japanese",
            photoURLLarge: "https://example.com/sushi_rolls_large.jpg",
            photoURLSmall: "https://example.com/sushi_rolls_small.jpg",
            sourceURL: "https://example.com/sushi_rolls_recipe",
            youtubeURL: "https://www.youtube.com/watch?v=sushi_rolls_video"),
        
        Recipe(
            id: "4",
            name: "Beef Tacos",
            cuisine: "Mexican",
            photoURLLarge: "https://example.com/beef_tacos_large.jpg",
            photoURLSmall: "https://example.com/beef_tacos_small.jpg",
            sourceURL: "https://example.com/beef_tacos_recipe",
            youtubeURL: "https://www.youtube.com/watch?v=beef_tacos_video"),
        
        Recipe(
            id: "5",
            name: "Mushroom Risotto",
            cuisine: "Italian",
            photoURLLarge: "https://example.com/mushroom_risotto_large.jpg",
            photoURLSmall: "https://example.com/mushroom_risotto_small.jpg",
            sourceURL: "https://example.com/mushroom_risotto_recipe",
            youtubeURL: "https://www.youtube.com/watch?v=mushroom_risotto_video")
    ]
    
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
            let recipes = try await self.recipesService.getRecipes()
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
}
