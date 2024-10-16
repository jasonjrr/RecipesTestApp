//
//  RecipesTestAppApp.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import SwiftUI

fileprivate let appAssembly = AppAssembler()

@main
struct RecipesTestAppApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootCoordinatorView(
                coordinator: appAssembly.resolver.resolve(AppRootCoordinatorViewModel.self)!)
        }
    }
}
