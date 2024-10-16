//
//  RecipesService.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import SUIFNetworking

protocol RecipesServiceProtocol: AnyObject {
    func getRecipes() async throws -> [Recipe]
}


actor RecipesService: RecipesServiceProtocol {
    private let networkingService: any NetworkingServiceProtocol
    
    init(networkingService: any NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    func getRecipes() async throws -> [Recipe] {
        let response: NetworkingServiceResponse<RecipeResponse> = try await self.networkingService.async
            .fetch(from: URLs.malformedRecipes.url, headers: nil, parameters: nil)
        return response.model.recipes
    }
}

extension RecipesService {
    enum URLs: String {
        case allRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        case malformedRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        case emptyRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        
        var url: URL {
            URL(string: self.rawValue)!
        }
    }
}
