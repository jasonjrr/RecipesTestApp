//
//  AppRootCoordinatorView.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import SwiftUI
import SwiftUIFoundation

struct AppRootCoordinatorView: View {
    @Bindable var coordinator: AppRootCoordinatorViewModel
    
    var body: some View {
        CoordinatorNavigationStack(path: self.coordinator.path) {
            RecipesListView(viewModel: self.coordinator.recipesListViewModel)
        }
    }
}
