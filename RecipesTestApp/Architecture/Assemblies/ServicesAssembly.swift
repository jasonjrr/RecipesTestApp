//
//  ServicesAssembly.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import Swinject
import SUIFNetworking
import SwiftUIDesignSystem

class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ImageCacheProtocol.self) { _ in
            ImageCache()
        }.inObjectScope(.container)
        
        container.register((any NetworkingServiceProtocol).self) { _ in
            // Provide a nil imageURLCache, because we want to cache to disk
            NetworkingService(imageURLCache: nil)
        }.inObjectScope(.container)
        
        container.register(RecipesServiceProtocol.self) { resolver in
            RecipesService(
                imageCache: resolver.resolve(ImageCacheProtocol.self)!,
                networkingService: resolver.resolve((any NetworkingServiceProtocol).self)!)
        }.inObjectScope(.container)
        
        container.register(Theme.self) { _ in
            Theme()
        }.inObjectScope(.container)
    }
}
