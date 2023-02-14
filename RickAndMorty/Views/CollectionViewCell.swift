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
        imageView.af.setImage(withURL: imageURL)
    }
}
