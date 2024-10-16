//
//  AppAssembler.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import Swinject

class AppAssembler {
    private let assembler: Assembler
    
    var resolver: Resolver {
        self.assembler.resolver
    }
    
    init() {
        self.assembler = Assembler([
            NavigationCoordinatorsAssembly(),
            ServicesAssembly(),
            ViewModelAssembly(),
        ])
    }
}
