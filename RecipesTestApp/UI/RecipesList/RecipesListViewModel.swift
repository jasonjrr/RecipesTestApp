//
//  RecipesListViewModel.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import UIKit.UIImage

@Observable
class RecipesListViewModel: ViewModel {
    @ObservationIgnored
    private let recipesService: RecipesServiceProtocol
    
    @ObservationIgnored
    private(set) weak var delegate: Delegate?
    
    private(set) var recipes: Result<[RecipeViewModel], Error> = .success([])
    
    init(recipesService: RecipesServiceProtocol) {
        self.recipesService = recipesService
    }
    
    @discardableResult
    func setup(delegate: Delegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    func refresh() {
        Task {
            do {
                let recipes = try await recipesService.getRecipes()
                    .map {
                        RecipeViewModel(recipesService: self.recipesService, recipe: $0)
                    }
                self.recipes = .success(recipes)
            } catch {
                self.recipes = .failure(error)
            }
        }
    }
}

// MARK: Delegate
extension RecipesListViewModel {
    protocol Delegate: AnyObject {
        //
    }
}

// MARK: RecipeItem
extension RecipesListViewModel {
    @Observable
    class RecipeViewModel: ViewModel {
        private let recipesService: RecipesServiceProtocol
        let recipe: Recipe
        
        var id: String {
            return self.recipe.id
        }
        
        private var _thumbnailImage: UIImage?
        var thumbnailImage: UIImage? {
            if let _thumbnailImage {
                return _thumbnailImage
            } else {
                getImage()
                return nil
            }
        }
        
        init(recipesService: RecipesServiceProtocol, recipe: Recipe) {
            self.recipesService = recipesService
            self.recipe = recipe
        }
        
        private func getImage() {
            Task {
                if let url = URL(string: self.recipe.photoURLSmall) {
                    self._thumbnailImage = try? await self.recipesService.getImage(for: url)
                } else {
                    self._thumbnailImage = nil
                }
            }
        }
    }
}
