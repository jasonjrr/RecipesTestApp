//
//  MockImageCache.swift
//  RecipesTestAppTests
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import UIKit.UIImage
@testable import RecipesTestApp

class MockImageCache: ImageCacheProtocol {
    var mock_cacheTestClosure: ((UIImage, Data, URL) async -> Void)?
    func cache(image: UIImage, imageData: Data, for url: URL) async {
        await self.mock_cacheTestClosure?(image, imageData, url)
    }
    
    var mock_imageTestClosure: ((URL) async -> UIImage?)?
    func image(for url: URL) async -> UIImage? {
        await self.mock_imageTestClosure?(url)
    }
}
