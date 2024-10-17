//
//  Recipe+Mocks.swift
//  RecipesTestAppTests
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
@testable import RecipesTestApp

extension Recipe {
    static var mockData: [Recipe] {
        [
            Recipe(
                id: "1",
                name: "Spaghetti Carbonara",
                cuisine: "Italian",
                photoURLLarge: "https://example.com/spaghetti_carbonara_large.jpg",
                photoURLSmall: "https://example.com/spaghetti_carbonara_small.jpg",
                sourceURL: "https://example.com/spaghetti_carbonara_recipe",
                youtubeURL: "https://www.youtube.com/watch?v=spaghetti_carbonara_video"),
            
            Recipe(
                id: "2",
                name: "Chicken Tikka Masala",
                cuisine: "Indian",
                photoURLLarge: "https://example.com/chicken_tikka_masala_large.jpg",
                photoURLSmall: "https://example.com/chicken_tikka_masala_small.jpg",
                sourceURL: "https://example.com/chicken_tikka_masala_recipe",
                youtubeURL: "https://www.youtube.com/watch?v=chicken_tikka_masala_video"),
            
            Recipe(
                id: "3",
                name: "Sushi Rolls",
                cuisine: "Japanese",
                photoURLLarge: "https://example.com/sushi_rolls_large.jpg",
                photoURLSmall: "https://example.com/sushi_rolls_small.jpg",
                sourceURL: "https://example.com/sushi_rolls_recipe",
                youtubeURL: "https://www.youtube.com/watch?v=sushi_rolls_video"),
            
            Recipe(
                id: "4",
                name: "Beef Tacos",
                cuisine: "Mexican",
                photoURLLarge: "https://example.com/beef_tacos_large.jpg",
                photoURLSmall: "https://example.com/beef_tacos_small.jpg",
                sourceURL: "https://example.com/beef_tacos_recipe",
                youtubeURL: "https://www.youtube.com/watch?v=beef_tacos_video"),
            
            Recipe(
                id: "5",
                name: "Mushroom Risotto",
                cuisine: "Italian",
                photoURLLarge: "https://example.com/mushroom_risotto_large.jpg",
                photoURLSmall: "https://example.com/mushroom_risotto_small.jpg",
                sourceURL: "https://example.com/mushroom_risotto_recipe",
                youtubeURL: "https://www.youtube.com/watch?v=mushroom_risotto_video"),
        ]
    }
}
