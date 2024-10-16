//
//  ViewModelAssembly.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RecipesListViewModel.self) { resolver in
            RecipesListViewModel()
        }.inObjectScope(.transient)
    }
}
