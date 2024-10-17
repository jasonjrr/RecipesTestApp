//
//  MockRecipesService.swift
//  RecipesTestAppTests
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
@testable import RecipesTestApp
import UIKit.UIImage

class MockRecipesService: RecipesServiceProtocol {
    var mockGetRecipesTestClosure: (() async throws -> [RecipesTestApp.Recipe])?
    func getRecipes() async throws -> [RecipesTestApp.Recipe] {
        guard let mockGetRecipesTestClosure else {
            throw Errors.mockGetRecipesTestClosureNotImplemented
        }
        return try await mockGetRecipesTestClosure()
    }
    
    var mockGetImageTestClosure: ((URL) async throws -> UIImage)?
    func getImage(for url: URL) async throws -> UIImage {
        guard let mockGetImageTestClosure else {
            throw Errors.mockGetImageTestClosureNotImplemented
        }
        return try await mockGetImageTestClosure(url)
    }
}

extension MockRecipesService {
    enum Errors: Error {
        case mockGetRecipesTestClosureNotImplemented
        case mockGetImageTestClosureNotImplemented
    }
}
