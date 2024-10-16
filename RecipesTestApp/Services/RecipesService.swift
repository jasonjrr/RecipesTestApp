//
//  RecipesService.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import SUIFNetworking
import UIKit.UIImage

protocol RecipesServiceProtocol: AnyObject {
    func getRecipes() async throws -> [Recipe]
    func getImage(for url: URL) async throws -> UIImage
}

actor RecipesService: RecipesServiceProtocol {
    private let imageCache: any ImageCacheProtocol
    private let networkingService: any NetworkingServiceProtocol
    
    init(imageCache: any ImageCacheProtocol, networkingService: any NetworkingServiceProtocol) {
        self.imageCache = imageCache
        self.networkingService = networkingService
    }
    
    func getRecipes() async throws -> [Recipe] {
        let response: NetworkingServiceResponse<RecipeResponse> = try await self.networkingService.async
            .fetch(from: URLs.allRecipes.url, headers: nil, parameters: nil)
        return response.model.recipes
    }
    
    func getImage(for url: URL) async throws -> UIImage {
        if let image = await self.imageCache.image(for: url) {
            return image
        }
        
        let response = try await self.networkingService.async.fetchImage(from: url)
        await self.imageCache.cache(image: response.image, imageData: response.data, for: url)
        return response.image
    }
}

extension RecipesService {
    enum Errors: LocalizedError {
        case unableToFetchImage(URL)
    }
    
    enum URLs: String {
        case allRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case malformedRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case emptyRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        
        var url: URL {
            URL(string: self.rawValue)!
        }
    }
}
