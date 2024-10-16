//
//  ImageCacheTests.swift
//  RecipesTestAppTests
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import XCTest
@testable import RecipesTestApp
import SDWebImage

class ImageCacheTests: XCTestCase {
    var imageCache: ImageCache!
    
    override func setUp() {
        super.setUp()
        imageCache = ImageCache()
    }

    override func tearDown() {
        imageCache = nil
        super.tearDown()
    }
    
    func testCachingImage() async {
        let testImage = UIImage(named: "testImage")!
        let testData = testImage.pngData()!
        let testURL = URL(string: "https://example.com/image.png")!
        
        await self.imageCache.cache(image: testImage, imageData: testData, for: testURL)
        
        let cachedImage = await self.imageCache.image(for: testURL)
        XCTAssertNotNil(cachedImage)
    }
    
    func testFetchingNonExistentImage() async {
        let testURL = URL(string: "https://example.com/non_existent_image.png")!
        
        let nonExistentImage = await imageCache.image(for: testURL)
        XCTAssertNil(nonExistentImage)
    }
}
