//
//  AppRootCoordinatorViewModel.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import Swinject

@Observable
class AppRootCoordinatorViewModel: ViewModel {
    @ObservationIgnored
    private let resolver: Resolver
    
    let recipesListViewModel: RecipesListViewModel
    let path: CoordinatorNavigationPath = CoordinatorNavigationPath()
    
    init(resolver: Resolver) {
        self.resolver = resolver
        self.recipesListViewModel = resolver.resolve(RecipesListViewModel.self)!
        
        self.recipesListViewModel.setup(delegate: self)
    }
}

// MARK: RecipesListViewModel.Delegate
extension AppRootCoordinatorViewModel: RecipesListViewModel.Delegate {
    /// This extension would handle any navigation code coming from the `RecipesListViewModel`
    /// allowing us to decouple ViewModel logic and navigation.
}
