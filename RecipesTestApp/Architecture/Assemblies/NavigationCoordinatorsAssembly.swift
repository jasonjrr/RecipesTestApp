//
//  NavigationCoordinatorsAssembly.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import Swinject

class NavigationCoordinatorsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppRootCoordinatorViewModel.self) { resolver in
            AppRootCoordinatorViewModel(resolver: resolver)
        }.inObjectScope(.container)
    }
}
