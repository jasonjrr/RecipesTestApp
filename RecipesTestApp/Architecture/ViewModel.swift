//
//  ViewModel.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation

protocol ViewModel: AnyObject, Identifiable, Hashable, Equatable {}

extension ViewModel {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
