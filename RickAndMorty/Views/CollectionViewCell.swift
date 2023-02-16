//
//  CollectionViewCell.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 2/11/23.
//

import UIKit
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.width / 2
        }
    }
    @IBOutlet weak var label: UILabel!
    
    private var imageURL: URL? {
        didSet {
            imageView.image = nil
        }
    }
    
    func configure(with character: Character) {
        label.text = character.name
        
        guard let imageURL = URL(string: character.image ?? "") else { return }
        getImage(from: imageURL)
    }
    
    private func getImage(from url: URL) {
        //Get image from cache
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            imageView.image = cachedImage
            return
        }
        
        //Download image from url
        imageView.af.setImage(withURL: url)
        guard let cachedImage = imageView.image else { return }
        ImageCacheManager.shared.setObject(cachedImage, forKey: url.lastPathComponent as NSString)
    }
}
