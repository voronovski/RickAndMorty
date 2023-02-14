//
//  CollectionViewCell.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 2/11/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.width / 2
        }
    }
    @IBOutlet weak var label: UILabel!
    
//    private var imageURL: URL? {
//        didSet {
//            imageView.image = nil
//        }
//    }
    
    func configure(with character: Character) {
        label.text = character.name
//        imageView.image = UIImage(systemName: "person.circle")
        imageView.backgroundColor = .darkGray
    }
}
