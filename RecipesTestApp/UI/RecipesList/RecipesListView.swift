//
//  RecipesListView.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import SwiftUI
import SwiftUIDesignSystem

struct RecipesListView: View {
    @Environment(Theme.self) private var theme: Theme
    @Bindable var viewModel: RecipesListViewModel
    
    var body: some View {
        ScrollView {
            if let _ = self.viewModel.recipesError {
                makeErrorBody()
            } else {
                makeSuccessBody()
            }
        }
        .background(self.theme.colors.secondaryBackground.color)
        .refreshable {
            self.viewModel.refresh()
        }
    }
    
    private func makeErrorBody() -> some View {
        VStack(spacing: 32.0) {
            Image(systemName: "exclamationmark.octagon")
                .resizable()
                .scaledToFit()
                .frame(width: 120.0, height: 120.0)
                .foregroundStyle(self.theme.colors.error.color)
            Text("Something went wrong.")
                .font(forStyle: .title, weight: .semibold)
                .foregroundStyle(self.theme.colors.label.color)
            Text("Please check your internet connection and try again.")
                .font(forStyle: .body)
                .foregroundStyle(self.theme.colors.secondaryLabel.color)
            Button("Refresh") {
                self.viewModel.refresh()
            }
            .font(forStyle: .headline, weight: .bold)
            .buttonStyle(.borderedProminent)
        }
        .multilineTextAlignment(.center)
        .padding(40.0)
        .padding(.top, 60.0)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func makeSuccessBody() -> some View {
        if self.viewModel.recipes.isEmpty {
            VStack(spacing: 32.0) {
                Image(systemName: "list.star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120.0, height: 120.0)
                Text("No recipes found.")
                    .font(forStyle: .title, weight: .semibold)
                    .foregroundStyle(self.theme.colors.label.color)
                Text("Please check your internet connection and try again.")
                    .font(forStyle: .body)
                    .foregroundStyle(self.theme.colors.secondaryLabel.color)
                Button("Refresh") {
                    self.viewModel.refresh()
                }
                .font(forStyle: .headline, weight: .bold)
                .buttonStyle(.borderedProminent)
            }
            .multilineTextAlignment(.center)
            .padding(40.0)
            .padding(.top, 60.0)
            .frame(maxWidth: .infinity)
        } else {
            LazyVStack {
                ForEach(self.viewModel.recipes) { recipe in
                    RecipeCard(recipe: recipe)
                        .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension RecipesListView {
    struct RecipeCard: View {
        @Environment(Theme.self) private var theme: Theme
        
        @ScaledMetric(relativeTo: .title3) var thumbnailSize: CGFloat = 40.0
        @ScaledMetric private var urlIconSize: CGFloat = 17.0
        
        let recipe: Recipe
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    if let url = URL(string: self.recipe.photoURLSmall) {
                        thumbnail(url: url)
                    }
                    header()
                }
                links()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                    .fill(self.theme.colors.cardBackground.color)
            }
            .compositingGroup()
        }
        
        private func thumbnail(url: URL) -> some View {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray
            }
            .frame(width: self.thumbnailSize, height: self.thumbnailSize)
            .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
        }
        
        private func header() -> some View {
            VStack(alignment: .leading) {
                Text(self.recipe.name)
                    .font(forStyle: .title3, weight: .medium)
                    .foregroundStyle(self.theme.colors.label.color)
                Text(self.recipe.cuisine)
                    .font(forStyle: .subheadline)
                    .foregroundStyle(self.theme.colors.secondaryLabel.color)
            }
        }
        
        @ViewBuilder
        private func links() -> some View {
            if let url = URL(string: self.recipe.sourceURL ?? .empty) {
                Link(destination: url) {
                    Label {
                        Text("Source")
                            .font(forStyle: .body)
                    } icon: {
                        Image(systemName: "globe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.urlIconSize, height: self.urlIconSize)
                    }
                }
            }
            if let url = URL(string: self.recipe.youtubeURL ?? .empty) {
                Link(destination: url) {
                    Label {
                        Text("YouTube")
                            .font(forStyle: .body)
                    } icon: {
                        Image(.youtube)
                            .resizable()
                            .scaledToFit()
                            .frame(width: self.urlIconSize, height: self.urlIconSize)
                    }
                }
            }
        }
    }
}
