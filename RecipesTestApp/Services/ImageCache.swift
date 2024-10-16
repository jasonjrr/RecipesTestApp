//
//  ImageCache.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation
import SDWebImage

protocol ImageCacheProtocol: AnyObject {
    func cache(image: UIImage, imageData: Data, for url: URL) async
    func image(for url: URL) async -> UIImage?
}

actor ImageCache: ImageCacheProtocol {
    private let cache: SDImageCache
    
    init() {
        SDImageCodersManager.shared.addCoder(SDImageIOCoder.shared)
        
        SDWebImageDownloader.shared.setValue("image/*,*/*;q=0.8", forHTTPHeaderField: "Accept")
            
        self.cache = SDImageCache(namespace: "tiny")
        cache.config.maxMemoryCost = 100 * 1024 * 1024 // 100MB memory
        cache.config.maxDiskSize = 100 * 1024 * 1024 // 100MB disk
        SDImageCachesManager.shared.addCache(cache)
        SDWebImageManager.defaultImageCache = SDImageCachesManager.shared
    }
    
    func cache(image: UIImage, imageData: Data, for url: URL) async {
        await SDImageCachesManager.shared
            .store(
                image,
                imageData: imageData,
                forKey: url.absoluteString,
                cacheType: .disk)
    }
    
    func image(for url: URL) async -> UIImage? {
        self.cache.imageFromDiskCache(forKey: url.absoluteString)
    }
}
