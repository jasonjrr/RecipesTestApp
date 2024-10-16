//
//  AppRootCoordinatorView.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import SwiftUI

struct AppRootCoordinatorView: View {
    @ObservedObject var coordinator: AppRootCoordinatorViewModel
    
    var body: some View {
        Text("App Root Coordinator View")
    }
}
