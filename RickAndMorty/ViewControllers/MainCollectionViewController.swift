//
//  MainCollectionViewController.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 2/11/23.
//

import UIKit

private let reuseIdentifier = "hero"

class MainCollectionViewController: UICollectionViewController {

    //MARK: - Private properties
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCharacters()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if let heroCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell {
            let character = characters[indexPath.item]
            heroCell.configure(with: character)
            
            cell = heroCell
        }
        
        return cell
    }
}

//MARK: - Networking
extension MainCollectionViewController {
    private func fetchCharacters() {
        NetworkManager.shared.fetchCharacters(from: Link.top50.rawValue) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
