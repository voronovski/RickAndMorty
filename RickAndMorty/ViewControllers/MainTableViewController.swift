//
//  MainTableViewController.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 1/30/23.
//

import UIKit

final class MainTableViewController: UITableViewController {

    //MARK: Private properties
    var characters: [Character] = []
    var characterImage = UIImage(systemName: "person")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        fetchCharacters()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(characters[section].id)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let character = characters[indexPath.section]
        var content = cell.defaultContentConfiguration()
        content.text = character.name
        content.secondaryText = """
            Gender: \(character.gender),
            From: \(character.origin.name)
            """
        
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageDate):
                self?.characterImage = UIImage(data: imageDate)
            case .failure(let error):
                print(error)
            }
        }
        
        content.image = characterImage
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: Networking
extension MainTableViewController {
    private func fetchCharacters() {
        NetworkManager.shared.fetch(dataType: [Character].self, from: Link.top25.rawValue) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
