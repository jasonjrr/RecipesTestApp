//
//  RecipesTestAppApp.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import SwiftUI
import SwiftUIDesignSystem

fileprivate let appAssembly = AppAssembler()

@main
struct RecipesTestAppApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootCoordinatorView(
                coordinator: appAssembly.resolver.resolve(AppRootCoordinatorViewModel.self)!)
            .environment(appAssembly.resolver.resolve(Theme.self)!)
        }
    }
}
