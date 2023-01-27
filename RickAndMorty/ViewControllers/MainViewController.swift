//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 1/26/23.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Private properties
    private let link = "https://rickandmortyapi.com/api/character/1,2,3,4,5"
    private var characters: [Character]!
    
    // MARK: - IBActions
    @IBAction func fetchDataPressed() {
        fetchCharacters()
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchCharacters() {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let characters = try jsonDecoder.decode([Character].self, from: data)
                print(characters)
                self?.characters = characters
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
