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
        let recipe: Recipe
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    if let url = URL(string: self.recipe.photoURLSmall) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 36.0, height: 36.0)
                    }
                    Text(self.recipe.name)
                        .font(forStyle: .title3, weight: .medium)
                        .foregroundStyle(self.theme.colors.label.color)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                    .fill(self.theme.colors.cardBackground.color)
            }
        }
    }
}
