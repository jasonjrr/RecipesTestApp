//
//  RecipesListViewModel.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation

@Observable
class RecipesListViewModel: ViewModel {
    @ObservationIgnored
    private weak var delegate: Delegate?
    
    @discardableResult
    func setup(delegate: Delegate) -> Self {
        self.delegate = delegate
        return self
    }
}

extension RecipesListViewModel {
    protocol Delegate: AnyObject {
        //
    }
}
