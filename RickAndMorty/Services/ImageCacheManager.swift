//
//  ImageCacheManager.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 2/15/23.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
