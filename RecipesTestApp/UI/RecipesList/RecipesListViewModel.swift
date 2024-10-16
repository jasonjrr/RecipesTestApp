//
//  RecipesListViewModel.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation

@Observable
class RecipesListViewModel: ViewModel {
    @ObservationIgnored
    private let recipesService: RecipesServiceProtocol
    
    @ObservationIgnored
    private weak var delegate: Delegate?
    
    private(set) var recipes: [Recipe] = []
    
    init(recipesService: RecipesServiceProtocol) {
        self.recipesService = recipesService
        fetchRecipes()
    }
    
    @discardableResult
    func setup(delegate: Delegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    func refresh() {
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        Task {
            do {
                self.recipes = try await recipesService.getRecipes()
            } catch {
                print(error)
            }
        }
    }
}

extension RecipesListViewModel {
    protocol Delegate: AnyObject {
        //
    }
}
