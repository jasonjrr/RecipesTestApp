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
            LazyVStack {
                ForEach(self.viewModel.recipes) { recipe in
                    RecipeCard(recipe: recipe)
                        .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(self.theme.colors.secondaryBackground.color)
        .refreshable {
            self.viewModel.refresh()
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
